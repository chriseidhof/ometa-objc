//
//  CEOMetaParser.m
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOMetaParser.h"
#import "CEOMetaProgram.h"
#import "CEOMetaRule.h"
#import "CEOMetaExp.h"
#import "CEOMetaChoice.h"
#import "CEOMetaSeq.h"
#import "CEOMetaRepeatMany.h"
#import "CEOMetaNot.h"
#import "CEOMetaChar.h"
#import "CEOMetaRepeatOne.h"
#import "CEOMetaNamed.h"
#import "CEOMetaAct.h"

@interface CEOMetaParser () {
    id<CEOMetaTokenizer> tokenizer;
    NSArray* currentTokens;
}

@end

@implementation CEOMetaParser

- (id)initWithTokenizer:(id<CEOMetaTokenizer>)tokenizer_ {
    self = [super init];
    if(self) {
        tokenizer = tokenizer_;
    }
    return self;
}

- (id)parse:(NSString*)input {
    currentTokens = [tokenizer tokenize:input];
    [self keyword:@"ometa"];
    NSString* identifier = [self identifier];
    [self keyword:@"{"];
    NSArray* rules = [self parseRules];
    [self keyword:@"}"];
    return [[CEOMetaProgram alloc] initWithName:identifier rules:rules];
}

- (NSString*)identifier {
    NSString* token = [self peek];
    char start = [token characterAtIndex:0];
    if((start >= 'a' && start <= 'z') || (start >= 'A' && start <= 'Z')) {
        return [self processNextToken];
    }
    [NSException raise:@"Expected identifier" format:@"Expected identifier, saw %@", token];
    return nil;
}

- (NSArray*)parseRules {
    return [self parseMany:@selector(parseRule) separatedBy:@","];
}

- (CEOMetaRule*)parseRule {
    NSString* ruleName = [self identifier];
    [self keyword:@"="];
    id<CEOMetaExp> exp = [self parseExp];
    return [[CEOMetaRule alloc] initWithName:ruleName body:exp];
}

- (NSString*)keyword:(NSString*)keyword {
    NSString* token = [self peek];
    if([token isEqual:keyword]) {
        return [self processNextToken];
    }
    [NSException raise:@"Expected token" format:@"Expected \"%@\", saw \"%@\", context: %@", keyword, token, currentTokens];
    return nil;
}

- (id<CEOMetaExp>)parseExp {
    return [self parseChoice];
}

// TODO: refactor parseChoice and parseSeq, they are the same
- (id<CEOMetaExp>)parseChoice {
    NSArray* currentState = currentTokens;
    
    @try {
        id<CEOMetaExp> lhs = [self parseAct];
        [self keyword:@"|"];
        id<CEOMetaExp> rhs = [self parseChoice];
        return [[CEOMetaChoice alloc] initWithAlternative:lhs right:rhs];
    }
    @catch (NSException *exception) {
        currentTokens = currentState;
        return [self parseAct];
    }
}

- (id<CEOMetaExp>)parseAct {
    id<CEOMetaExp>left = [self parseSeq];
    NSArray* currentState = currentTokens;
    @try {
        [self keyword:@"->"];
        NSString* act = [self parseObjCExpr];
        return [[CEOMetaAct alloc] initWithLeft:left act:act];
    }
    @catch (NSException *exception) {
        currentTokens = currentState;
    }
    return left;
}

- (id<CEOMetaExp>)parseSeq {
    NSArray* currentState = currentTokens;
    @try {
        id<CEOMetaExp> lhs = [self parseMany];
        id<CEOMetaExp> rhs = [self parseSeq];
        return [[CEOMetaSeq alloc] initWithLeft:lhs right:rhs];
    }
    @catch (NSException *exception) {
        currentTokens = currentState;
        return [self parseMany];
    }
}

- (id<CEOMetaExp>)parseMany {
    id<CEOMetaExp>left = [self parseManyOne];
    NSArray* currentState = currentTokens;
    @try {
        [self keyword:@"*"];
        return [[CEOMetaRepeatMany alloc] initWithBody:left];
    }
    @catch (NSException *exception) {
        currentTokens = currentState;
    }
    return left;
}

- (id<CEOMetaExp>)parseManyOne {
    id<CEOMetaExp>left = [self parseNamed];
    NSArray* currentState = currentTokens;
    @try {
        [self keyword:@"+"];
        return [[CEOMetaRepeatOne alloc] initWithBody:left];
    }
    @catch (NSException *exception) {
        currentTokens = currentState;
    }
    return left;
}

- (id<CEOMetaExp>)parseNamed {
    id<CEOMetaExp>body = [self parseNot];
    NSArray* currentState = currentTokens;
    @try {
        [self keyword:@":"];
        NSString* name = [self identifier];
        return [[CEOMetaNamed alloc] initWithName:name body:body];
    }
    @catch (NSException *exception) {
        currentTokens = currentState;
    }
    return body;
}

- (id<CEOMetaExp>)parseNot {
    NSArray* currentState = currentTokens;
    @try {
        [self keyword:@"~"];
        id<CEOMetaExp>body = [self parseParens];

        return [[CEOMetaNot alloc] initWithBody:body];
    }
    @catch (NSException *exception) {
        currentTokens = currentState;
        return [self parseParens];
    }
}

- (id<CEOMetaExp>)parseParens {
    NSArray* currentState = currentTokens;
    @try {
        [self keyword:@"("];
        id<CEOMetaExp> exp = [self parseExp];
        [self keyword:@")"];
        return exp;
    }
    @catch (NSException *exception) {
        currentTokens = currentState;
        return [self parseAtom];
    }
}

- (id<CEOMetaExp>)parseAtom {
    @try {
        return [self parseApp];
    }
    @catch (NSException *exception) {
    }
    return [self parseLiteral];
}

- (id<CEOMetaExp>)parseLiteral {
    NSString* token = [self peek];
    char quote = '\'';
    if(token.length == 3 && [token characterAtIndex:0] == quote && [token characterAtIndex:2] == quote) {
        [self processNextToken]; // pop the token
        return [[CEOMetaChar alloc] initWithCharacter:[token characterAtIndex:1]];
    }
    [NSException raise:@"Expected literal" format:@"Expected literal, saw \"%@\", context: %@", token, currentTokens];
    return nil;
}

- (id<CEOMetaExp>)parseApp {
    NSString* token = [self identifier];
    return [[CEOMetaApp alloc] initWithName:token];
}

- (NSString*)parseObjCExpr {
    [self keyword:@"{"];
    NSArray* tokens = [self tokensUntilEndToken:@"}"];
    return [tokens componentsJoinedByString:@" "];
}

#pragma mark Parser Combinators

- (NSArray*)tokensUntilEndToken:(NSString*)endToken {
    NSMutableArray* result = [NSMutableArray array];
    while(![[self peek] isEqual:endToken]) {
        [result addObject:[self processNextToken]];
    }
    [self keyword:endToken];
    return result;
}

- (NSArray*)parseMany:(SEL)elementParser separatedBy:(NSString*)separator {
    @try {
        id result = [self performSelector:elementParser];
        if([[self peek] isEqual:separator]) {
            [self processNextToken]; // the separator
            NSArray* rest = [self parseMany:elementParser separatedBy:separator];
            return [@[result] arrayByAddingObjectsFromArray:rest];
        } else {
            return @[result];
        }
    }
    @catch (NSException *exception) {
        return @[];
    }
    return nil;
}

- (NSString*)anything {
    return [self processNextToken];
}

- (NSString*)peek {
    if(currentTokens.count == 0) return nil;
    id token = currentTokens[0];
    return token;
}

- (NSString*)processNextToken {
    if(currentTokens.count == 0) return nil;
    id token = currentTokens[0];
    currentTokens = [currentTokens subarrayWithRange:NSMakeRange(1, currentTokens.count-1)];
    return token;
}

@end