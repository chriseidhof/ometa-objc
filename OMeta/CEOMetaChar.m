//
//  CEOMetaChar.m
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOMetaChar.h"

@interface CEOMetaChar () {
    char char_;
}

@end

@implementation CEOMetaChar

- (id)initWithCharacter:(char)char__ {
    self = [super init];
    if(self) {
        char_ = char__;
    }
    return self;
}


- (char)character {
    return char_;
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[self class]]) {
        CEOMetaChar* other = (CEOMetaChar*)object;
        return self.character == other.character;
    }
    return NO;
}

- (NSUInteger)hash {
    return char_;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"'%c'", char_];
}

- (NSString*)compile {
    NSString* expression = [NSString stringWithFormat:@"return [self evaluateChar:stream char:'%c']; ", char_];
    return expression;
}

- (NSArray*)variables {
    return @[];
}

@end
