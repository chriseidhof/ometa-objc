//
//  CEOMetaProgram.h
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CEOMetaProgram : NSObject

- (id)initWithName:(NSString*)name rules:(NSArray*)rules;
- (NSString*)compile;

@property (nonatomic,readonly) NSString* name;
@property (nonatomic,readonly) NSArray* rules;
@property (nonatomic,strong) NSString* code;

@end
