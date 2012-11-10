//
//  CEOMetaTokenizer.m
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOMetaTokenizer.h"
#import "NSArray+Extensions.h"
#import "CETokens.h"
#import "NSString+Extras.h"
#import "NSArray+Extensions.h"

@interface CEOMetaTokenizer () {
    NSScanner* scanner;
}

@end

@implementation CEOMetaTokenizer

- (NSArray*)tokenize:(NSString*)input {
    scanner = [NSScanner scannerWithString:input];
    NSMutableArray* tokens = [NSMutableArray array];
    while (![scanner isAtEnd]) {
        NSArray* nextTokens = [self parseTokens];
        if(nextTokens == nil) {
          [[NSException exceptionWithName:@"No tokens" reason:@"Couldn't parse the rest of the tokens" userInfo:nil] raise];
            return nil;
        }
        [tokens addObjectsFromArray:nextTokens];
    }
    return tokens;
}

- (NSArray*)parseTokens {
    NSArray* result = [self parseKeyword];
    if(!result) result = [self parseLiteral];
    if(!result) result = [self parseCodeBlock];
    if(!result) result = [self parseOperators];
    
    [self whitespace];
    
    return result;
}

- (NSArray*)parseKeyword {
    NSString* keyword = nil;
    [scanner scanCharactersFromSet:[NSCharacterSet letterCharacterSet] intoString:&keyword];
    if (keyword) {
        return @[KEYWORD(keyword)];
    }
    return nil;
}

- (NSArray*)parseLiteral {
    if([scanner scanString:@"'" intoString:NULL]) {
        NSString* literal = nil;
        [scanner scanUpToString:@"'" intoString:&literal];
        [scanner scanString:@"'" intoString:nil];
        if(literal) {
            return @[LIT(literal)];
        }
    }
    return nil;
}

- (void)whitespace {
    [scanner scanCharactersFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] intoString:NULL];
}

- (NSArray*)parseCodeBlock {
    NSString* openCodeBlock = @"{{{";
    NSString* closeCodeBlock = @"}}}";
    if([scanner scanString:openCodeBlock intoString:NULL]) {
        NSString* code;
        if([scanner scanUpToString:closeCodeBlock intoString:&code]) {
            [scanner scanString:closeCodeBlock intoString:NULL];
            if(code) {
                return @[[CECodeToken code:code]];
            }
        }
    }
    return nil;
}

- (NSArray*)parseOperators {
    NSString* operator = nil;
    [scanner scanCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"[]()=+*?:|,~"] intoString:&operator];
    if(operator) {
        return [[operator components] map:^id(id obj) {
            return [CEOperatorToken operator:obj];
        }];
    }
    // We scan { and } separately so there's no confusion with {{{ and }}}
    NSArray* otherTokens = @[@"->", @"{", @"}"];
    for(NSString* token in otherTokens) {
        [scanner scanString:token intoString:&operator];
        if(operator) {
            return @[[CEOperatorToken operator:operator]];
        }
        
    }
    return nil;
}

@end
