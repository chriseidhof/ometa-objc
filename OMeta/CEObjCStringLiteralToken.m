//
//  CEObjCStringLiteralToken.m
//  OMeta
//
//  Created by Chris Eidhof on 11/25/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEObjCStringLiteralToken.h"

@implementation CEObjCStringLiteralToken

+ (id)stringLiteral:(NSString *)string {
    CEObjCStringLiteralToken* x = [[self alloc] init];
    x.string = string;
    return x;
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[CEObjCStringLiteralToken class]]) {
        CEObjCStringLiteralToken* other = (CEObjCStringLiteralToken*)object;
        return [self.string isEqual:other.string];
    }
    return NO;
}

- (NSUInteger)hash {
    return self.string.hash;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"<STRLIT %@>", self.string];
}

@end
