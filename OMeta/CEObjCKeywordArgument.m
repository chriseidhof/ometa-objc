//
//  CEObjCKeywordArgument.m
//  OMeta
//
//  Created by Chris Eidhof on 11/25/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEObjCKeywordArgument.h"

@interface CEObjCKeywordArgument () {
    id<CEObjCExp>keyword;
    id<CEObjCExp>exp;
}

@end

@implementation CEObjCKeywordArgument

- (id)initWithKeyword:(id<CEObjCExp>)keyword_ exp:(id<CEObjCExp>)exp_
{
    self = [super init];
    if (self) {
        keyword = keyword_;
        exp = exp_;
    }
    return self;
}

- (NSString*)compile {
    return [NSString stringWithFormat:@"%@:%@", [keyword compile], [exp compile]];
}

@end
