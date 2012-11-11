//
//  CERuleApplicationToken.h
//  OMeta
//
//  Created by Chris Eidhof on 11/11/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RULEAPP(x) [CERuleApplicationToken ruleApplication:x]

@interface CERuleApplicationToken : NSObject

+ (id)ruleApplication:(NSString *)ruleName;
@property (nonatomic,strong) NSString* ruleName;

@end
