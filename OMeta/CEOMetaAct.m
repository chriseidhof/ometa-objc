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
    id<CEObjCExp> act_;
}

@end

@implementation CEOMetaAct

- (id)initWithLeft:(id<CEOMetaExp>)left act:(id<CEObjCExp>)act {
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

- (id<CEObjCExp>)act {
    return act_;
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[CEOMetaAct class]]) {
        CEOMetaAct* other = (CEOMetaAct*)object;
        return [self.left isEqual:other.left] && [self.act isEqual:other.act] && [self.condition isEqual:other.condition];
    }
    return NO;
}

- (NSUInteger)hash {
    return [left_ hash] + [act_ hash] + [_condition hash];
}

- (NSString*)description {
    return [NSString stringWithFormat:@"( %@ ) ? { %@ } -> { %@ }", left_, _condition, act_];
}

- (NSString*)compile {
    NSString* body = [left_ compile];
    NSArray* vars = [left_ variables];
    NSString* condition = self.condition ? [@" && " stringByAppendingString:[self.condition compile]] : @"";
    NSString* varDefinitions = [[vars map:^id(id var) {
        return [NSString stringWithFormat:@"__block id %@;", var];
    }] componentsJoinedByString:@"\n"];
    return [@[varDefinitions, @"\nCEResultAndStream* result = ^{\n",
            body,
            @"}();\n if(!result.failed",
            condition,
            @") { \n",
            @"id actResult = ",
            [act_ compile],
            @";\n",
            @"return [CEResultAndStream result:actResult stream:result.stream];\n",
            @"} else {\n",
            @"return fail(stream);\n",
            @"}"
            ] componentsJoinedByString:@" "];
}

- (NSArray*)variables {
    return @[];
}

@end
