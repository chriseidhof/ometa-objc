//
//  CEOMetaSeq.h
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEOMetaExp.h"

@interface CEOMetaSeq : NSObject <CEOMetaExp>

- (id)initWithLeft:(id<CEOMetaExp>)left right:(id<CEOMetaExp>)right;

@end
