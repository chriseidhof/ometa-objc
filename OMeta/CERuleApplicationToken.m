//
//  CERuleApplicationToken.m
//  OMeta
//
//  Created by Chris Eidhof on 11/11/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CERuleApplicationToken.h"

@implementation CERuleApplicationToken

+ (id)ruleApplication:(NSString *)ruleName {
    CERuleApplicationToken* result = [[[self class] alloc] init];
    result.ruleName = ruleName;
    return result;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"%@(", self.ruleName];
}

- (NSUInteger)hash {
    return self.ruleName.hash;
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[CERuleApplicationToken class]]) {
        CERuleApplicationToken* other = (CERuleApplicationToken*)object;
        return [self.ruleName isEqual:other.ruleName];
    }
    return NO;
}

@end
