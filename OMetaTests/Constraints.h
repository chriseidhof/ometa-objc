//
//  Constraints.h
//  OMeta
//
//  Created by Chris Eidhof on 11/17/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEEvaluator.h"
#import "NSArray+Extensions.h"

@interface Constraints : CEEvaluator

- (CEResultAndStream*)visualFormatString:(id)stream;

@end
