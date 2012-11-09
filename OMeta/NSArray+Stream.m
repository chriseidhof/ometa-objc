//
//  NSArray+Stream.m
//  OMeta
//
//  Created by Chris Eidhof on 11/8/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "NSArray+Stream.h"

@implementation NSArray (Stream)

- (id)peek {
    if(self.count > 0) {
        return self[0];
    }
    return nil;
}

- (CEResultAndStream*)token {
    if(self.count) {
        id token = self[0];
        id rest = [self subarrayWithRange:NSMakeRange(1, self.count-1)];
        return [[CEResultAndStream alloc] initWithResult:token stream:rest];
    }
    return [[CEResultAndStream alloc] initWithResult:nil stream:nil];
}


@end
