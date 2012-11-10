//
//  CEOperatorToken.m
//  OMeta
//
//  Created by Chris Eidhof on 11/10/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOperatorToken.h"

@implementation CEOperatorToken

+ (id)operator:(NSString*)operator {
    CEOperatorToken* result = [[[self class] alloc] init];
    result.operator = operator;
    return result;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"<op '%@'>", self.operator];
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[CEOperatorToken class]]) {
        CEOperatorToken* other = (CEOperatorToken*)object;
        return [self.operator isEqual:other.operator];
    }
    return NO;
}

- (NSUInteger)hash {
    return self.operator.hash;
}

@end
