//
//  CELiteralToken.m
//  OMeta
//
//  Created by Chris Eidhof on 11/10/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CELiteralToken.h"

@implementation CELiteralToken

+ (id)literal:(NSString *)literal {
    CELiteralToken* result = [[[self class] alloc] init];
    result.literal = literal;
    return result;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"'%@'", self.literal];
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[CELiteralToken class]]) {
        CELiteralToken* other = (CELiteralToken*)object;
        return [self.literal isEqual:other.literal];
    }
    return NO;
}

- (NSUInteger)hash {
    return self.literal.hash;
}

@end
