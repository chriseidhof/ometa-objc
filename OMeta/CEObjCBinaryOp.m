//
//  CEObjCBinaryOp.m
//  OMeta
//
//  Created by Chris Eidhof on 11/26/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEObjCBinaryOp.h"

@implementation CEObjCBinaryOp

- (id)initWithOperator:(NSString *)operator left:(id<CEObjCExp>)left right:(id<CEObjCExp>)right
{
    self = [super init];
    if (self) {
        assert(NO);
    }
    return self;
}

@end
