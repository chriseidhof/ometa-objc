//
//  CEEvaluatorTests.m
//  OMeta
//
//  Created by Chris Eidhof on 12/10/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEEvaluatorTests.h"
#import "CEEvaluator.h"
#import "OCMock.h"

@implementation CEEvaluatorTests

- (void)testApply {
    id evaluator = [[CEEvaluator alloc] init];
    id stream = @"xyz";
    CEResultAndStream* result = [(CEEvaluator*)evaluator apply:stream selectorName:@"anything:"];
    STAssertEqualObjects(result.result, @"x", @"Should have x as result");
}

@end
