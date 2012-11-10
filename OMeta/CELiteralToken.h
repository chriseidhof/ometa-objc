//
//  CELiteralToken.h
//  OMeta
//
//  Created by Chris Eidhof on 11/10/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LIT(x) [CELiteralToken literal:(x)]

@interface CELiteralToken : NSObject

+ (id)literal:(NSString*)literal;
@property (nonatomic,strong) NSString* literal;

@end
