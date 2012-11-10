//
//  CEOperatorToken.h
//  OMeta
//
//  Created by Chris Eidhof on 11/10/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>

#define OP(x) [CEOperatorToken operator:(x)]

@interface CEOperatorToken : NSObject

+ (id)operator:(NSString*)operator;
@property (nonatomic,strong) NSString* operator;

@end
