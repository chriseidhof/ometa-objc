//
//  CEObjCBoxed.m
//  OMeta
//
//  Created by Chris Eidhof on 11/26/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEObjCBoxed.h"

@interface CEObjCBoxed () {
    id<CEObjCExp> exp;
}

@end

@implementation CEObjCBoxed

- (id)initWithExp:(id<CEObjCExp>)exp_
{
    self = [super init];
    if (self) {
        exp = exp_;
    }
    return self;
}

- (NSString*)compile {
    return [NSString stringWithFormat:@"@(%@)", [exp compile]];
}

@end
