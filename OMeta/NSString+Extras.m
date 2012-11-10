//
//  NSString+Extras.m
//  OMeta
//
//  Created by Chris Eidhof on 11/10/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "NSString+Extras.h"

@implementation NSString (Extras)

- (NSArray*)components {
    NSMutableArray* array = [NSMutableArray array];
    for (NSInteger i = 0; i < self.length; i++) {
        [array addObject:[NSString stringWithFormat:@"%c", [self characterAtIndex:i]]];
    }
    return array;
}

@end
