//
//  CECodeToken.m
//  OMeta
//
//  Created by Chris Eidhof on 11/10/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CECodeToken.h"

@implementation CECodeToken

+ (id)code:(NSString *)code {
    CECodeToken* result = [[[self class] alloc] init];
    result.code = code;
    return result;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"<code {{{ %@ }}}>", self.code];
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[CECodeToken class]]) {
        CECodeToken* other = (CECodeToken*)object;
        return [self.code isEqual:other.code];
    }
    return NO;
}

- (NSUInteger)hash {
    return self.code.hash;
}



@end
