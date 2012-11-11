//
//  EAST.h
//  OMeta
//
//  Created by Chris Eidhof on 11/8/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEResultAndStream.h"
#import "CEEvaluator.h"

@interface EAST : CEEvaluator

- (CEResultAndStream*)exp:(id)stream;

@end
