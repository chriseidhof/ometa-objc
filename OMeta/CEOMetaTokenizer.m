//
//  CEOMetaTokenizer.m
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOMetaTokenizer.h"
#import "NSArray+Extensions.h"

@implementation CEOMetaTokenizer

- (NSArray*)tokenize:(NSString*)input {
    return [[input componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] filter:^BOOL(id obj) {
        return [obj length] > 0;
    }];
}

@end
