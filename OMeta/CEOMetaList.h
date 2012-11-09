//
//  CEOMetaList.h
//  OMeta
//
//  Created by Chris Eidhof on 11/8/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEOMetaExp.h"

@interface CEOMetaList : NSObject <CEOMetaExp>

- (id)initWithItems:(NSArray*)items;

@end
