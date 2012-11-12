//
//  Predicate.h
//  OMeta
//
//  Created by Chris Eidhof on 11/11/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEEvaluator.h"

@interface Predicate : CEEvaluator

- (CEResultAndStream*)print:(id)stream;

@end
