//
//  NSString+Stream.m
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "NSString+Stream.h"

@implementation NSString (Stream)

- (NSInteger)remainingTokens {
    return self.length;
}

- (id)peek {
    if(self.length > 0) {
        return [self substringToIndex:1];
    }
    return nil;
}

- (CEResultAndStream*)token {
    if(self.length) {
        id token = [self substringToIndex:1];
        id rest = [self substringFromIndex:1];
        return [CEResultAndStream result:token stream:rest];
    }
    return nil;
}

@end
