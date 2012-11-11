//
//  CEOMetaRule.h
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEOMetaApp.h"

@interface CEOMetaRule : NSObject

- (id)initWithName:(NSString*)name body:(id<CEOMetaExp>)body;
- (NSString*)name;
- (id<CEOMetaExp>)body;
@property (nonatomic,strong) NSArray* args;
- (NSString*)compile;

@end