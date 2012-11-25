//
//  CEObjCStringLiteral.m
//  OMeta
//
//  Created by Chris Eidhof on 11/25/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEObjCStringLiteral.h"

@interface CEObjCStringLiteral () {
    NSString* string;
}

@end

@implementation CEObjCStringLiteral

- (id)initWithString:(NSString *)string_
{
    self = [super init];
    if (self) {
        string = string_;
    }
    return self;
}

- (NSString*)compile {
    return [NSString stringWithFormat:@"@\"%@\"", [string description]];
}

@end
