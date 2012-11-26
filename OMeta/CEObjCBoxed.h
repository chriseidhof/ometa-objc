//
//  CEObjCBoxed.h
//  OMeta
//
//  Created by Chris Eidhof on 11/26/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEObjCExp.h"

@interface CEObjCBoxed : NSObject <CEObjCExp>

- (id)initWithExp:(id<CEObjCExp>)exp;

@end
