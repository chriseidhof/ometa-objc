//
//  CEChoiceEvaluator.m
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEEvaluator.h"
#import "CEResultAndStream.h"

@implementation CEEvaluator

- (CEResultAndStream*)evaluateChoice:(id<Stream>)stream left:(evaluator)left right:(evaluator)right {
    CEResultAndStream* x = left(stream);
    if(x.result != nil) {
        return x;
    }
    return right(stream);
}

- (CEResultAndStream*)evaluateSeq:(id<Stream>)stream left:(evaluator)left right:(evaluator)right {
    CEResultAndStream* x = left(stream);
    if(x.result != nil) {
        CEResultAndStream* y = right(x.stream);
        if(y.result != nil) {
            return [[CEResultAndStream alloc] initWithResult:@[x.result,y.result] stream:y.stream];
        }
    }
    return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
}

- (CEResultAndStream*)evaluateMany:(id<Stream>)stream body:(evaluator)body {
    CEResultAndStream* x = body(stream);
    if(x.result) {
        CEResultAndStream* y = [self evaluateMany:x.stream body:body];
        if(y.result) {
            return [[CEResultAndStream alloc] initWithResult:[@[x.result] arrayByAddingObjectsFromArray:y.result] stream:y.stream];
        }
    }
    return [[CEResultAndStream alloc] initWithResult:@[] stream:stream];
}

- (CEResultAndStream*)evaluateManyOne:(id<Stream>)stream body:(evaluator)body {
    CEResultAndStream* x = body(stream);
    if(x.result) {
        CEResultAndStream* y = [self evaluateMany:x.stream body:body];
        if(y.result) {
            return [[CEResultAndStream alloc] initWithResult:[@[x.result] arrayByAddingObjectsFromArray:y.result] stream:y.stream];
        }
    }
    return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
}

- (CEResultAndStream*)evaluateChar:(id<Stream>)stream char:(char)char_ {
    id<NSObject> head = [stream peek];
    if([head isKindOfClass:[NSString class]]) {
        if([head isEqual:[NSString stringWithFormat:@"%c", char_]]) {
            return [stream token];
        }
    }
    return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
}

@end
