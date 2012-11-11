//
//  Calc.h
//  OMeta
//
//  Created by Chris Eidhof on 11/9/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEEvaluator.h"
#import "NSString+Stream.h"

@interface Calc : CEEvaluator

@property (nonatomic,strong) NSMutableDictionary* vars;
- (CEResultAndStream*)exp:(id<Stream>)stream;

@end
