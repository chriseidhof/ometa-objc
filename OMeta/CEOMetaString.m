//
//  CEOMetaChar.m
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOMetaString.h"

@interface CEOMetaString () {
    NSString* string_;
}

@end

@implementation CEOMetaString

- (id)initWithString:(NSString *)string {
    self = [super init];
    if(self) {
        string_ = string;
    }
    return self;
}


- (NSString*)string {
    return string_;
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[self class]]) {
        CEOMetaString* other = (CEOMetaString*)object;
        return [self.string isEqual:other.string];
    }
    return NO;
}

- (NSUInteger)hash {
    return string_.hash;
}

- (NSString*)description {
    return string_;
}

- (NSString*)compile {
    NSString* expression = [NSString stringWithFormat:@"return [self evaluateString:stream string:@\"%@\"]; ", [string_ stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""]];
    return expression;
}

- (NSArray*)variables {
    return @[];
}

@end
