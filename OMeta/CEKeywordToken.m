//
//  CEKeywordToken.m
//  OMeta
//
//  Created by Chris Eidhof on 11/10/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEKeywordToken.h"

@implementation CEKeywordToken

+ (id)keyword:(NSString *)keyword {
    CEKeywordToken* result = [[[self class] alloc] init];
    result.keyword = keyword;
    return result;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"[%@]", self.keyword];
}

- (NSUInteger)hash {
    return self.keyword.hash;
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[CEKeywordToken class]]) {
        CEKeywordToken* other = (CEKeywordToken*)object;
        return [self.keyword isEqual:other.keyword];
    }
    return NO;
}


@end
