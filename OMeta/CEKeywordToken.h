//
//  CEKeywordToken.h
//  OMeta
//
//  Created by Chris Eidhof on 11/10/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KEYWORD(x) [CEKeywordToken keyword:(x)]

@interface CEKeywordToken : NSObject

+ (id)keyword:(NSString*)keyword;

@property (nonatomic,strong) NSString* keyword;

@end
