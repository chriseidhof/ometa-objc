//
//  CEObjCMessage.h
//  OMeta
//
//  Created by Chris Eidhof on 11/25/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEObjCExp.h"

@interface CEObjCMessage : NSObject <CEObjCExp>

- (id)initWithReceiver:(id<CEObjCExp>)receiver selector:(NSArray*)selector;

@end
