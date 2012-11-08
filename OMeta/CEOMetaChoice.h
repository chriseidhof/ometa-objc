//
//  CEOMetaChoice.h
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEOMetaExp.h"

@interface CEOMetaChoice : NSObject <CEOMetaExp>

- (id)initWithAlternative:(id<CEOMetaExp>)left right:(id<CEOMetaExp>)right;
- (id<CEOMetaExp>)left;
- (id<CEOMetaExp>)right;

@end
