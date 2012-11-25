//
//  CEObjCStringLiteralToken.h
//  OMeta
//
//  Created by Chris Eidhof on 11/25/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>

#define OBJC_STRING_LIT(x) [CEObjCStringLiteralToken stringLiteral:(x)]

@interface CEObjCStringLiteralToken : NSObject

@property (nonatomic,strong) NSString* string;

+ (id)stringLiteral:(NSString*)string;

@end
