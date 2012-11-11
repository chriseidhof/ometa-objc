//
//  CEOMetaNamed.h
//  OMeta
//
//  Created by Chris Eidhof on 11/8/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEOMetaExp.h"

@interface CEOMetaNamed : NSObject <CEOMetaExp>

- (id)initWithName:(NSString*)name body:(id<CEOMetaExp>)body;
- (NSString*)name;

@end
