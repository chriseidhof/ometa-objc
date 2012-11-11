//
//  CEOMetaRuleApp.h
//  OMeta
//
//  Created by Chris Eidhof on 11/11/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEOMetaExp.h"

@interface CEOMetaRuleApp : NSObject <CEOMetaExp>

- (id)initWithRuleName:(NSString*)name args:(NSArray*)args;

@end
