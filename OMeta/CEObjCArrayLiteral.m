//
//  CEObjCArrayLiteral.m
//  OMeta
//
//  Created by Chris Eidhof on 11/25/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEObjCArrayLiteral.h"
#import "NSArray+Extensions.h"

@interface CEObjCArrayLiteral () {
    NSArray* expressions;
}

@end

@implementation CEObjCArrayLiteral

- (id)initWithExpressions:(NSArray *)expressions_
{
    self = [super init];
    if (self) {
        expressions = expressions_;
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[CEObjCArrayLiteral class]]) {
        CEObjCArrayLiteral* other = (CEObjCArrayLiteral*)object;
        return [expressions isEqual:other->expressions];
    }
    return NO;
}

- (NSUInteger)hash {
    return [expressions hash];
}

- (NSString*)compile {
    NSString* expressionsCode = [[expressions map:^id(id<CEObjCExp> obj) {
        return [obj compile];
    }] componentsJoinedByString:@","];
    return [NSString stringWithFormat:@"@[%@]", expressionsCode];
}

@end
