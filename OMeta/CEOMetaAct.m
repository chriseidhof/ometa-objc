//
//  CEOMetaAct.m
//  OMeta
//
//  Created by Chris Eidhof on 11/8/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOMetaAct.h"
#import "NSArray+Extensions.h"

@interface CEOMetaAct () {
    id<CEOMetaExp> left_;
    NSString* act_;
}

@end

@implementation CEOMetaAct

- (id)initWithLeft:(id<CEOMetaExp>)left act:(NSString*)act {
    self = [super init];
    if(self) {
        left_ = left;
        act_ = act;
    }
    return self;
}


- (id<CEOMetaExp>)left {
    return left_;
}

- (NSString*)act {
    return act_;
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[CEOMetaAct class]]) {
        CEOMetaAct* other = (CEOMetaAct*)object;
        return [self.left isEqual:other.left] && [self.act isEqual:other.act];
    }
    return NO;
}

- (NSUInteger)hash {
    return [left_ hash] + [act_ hash];
}

- (NSString*)description {
    return [NSString stringWithFormat:@"( %@ ) -> { %@ }", left_, act_];
}

- (NSString*)compile {
    NSString* body = [left_ compile];
    NSArray* vars = [left_ variables];
    NSString* varDefinitions = [[vars map:^id(id var) {
        return [NSString stringWithFormat:@"__block id %@;", var];
    }] componentsJoinedByString:@"\n"];
    return [@[varDefinitions, @"\nCEResultAndStream* result = ^{\n",
            body,
            @"}();\n if(result.result) { \n",
            @"id actResult = ",
            act_,
            @";\n",
            @"return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];\n",
            @"} else {\n",
            @"return [[CEResultAndStream alloc] initWithResult:nil stream:stream];\n",
            @"}"
            ] componentsJoinedByString:@" "];
}

- (NSArray*)variables {
    return @[];
}

@end
