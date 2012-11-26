//
//  CEObjCBinaryOp.h
//  OMeta
//
//  Created by Chris Eidhof on 11/26/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEObjCExp.h"

@interface CEObjCBinaryOp : NSObject <CEObjCExp>

- (id)initWithOperator:(NSString*)operator left:(id<CEObjCExp>)left right:(id<CEObjCExp>)right;

@end
