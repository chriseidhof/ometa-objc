//
//  CECodeToken.h
//  OMeta
//
//  Created by Chris Eidhof on 11/10/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CODE(x) [CECodeToken code:(x)]

@interface CECodeToken : NSObject

+ (id)code:(NSString*)code;

@property (nonatomic,strong) NSString* code;

@end
