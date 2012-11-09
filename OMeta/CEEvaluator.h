//
//  CEChoiceEvaluator.h
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEResultAndStream.h"

@protocol Stream <NSObject>

- (id)peek;
- (CEResultAndStream*)token;

@end

@protocol CEEvaluator <NSObject>

- (CEResultAndStream*)evaluate:(id<Stream>)stream;

@end

typedef CEResultAndStream*(^evaluator)(id<Stream> stream);


@interface CEEvaluator : NSObject

- (CEResultAndStream*)evaluateChoice:(id<Stream>)stream left:(evaluator)left right:(evaluator)right;
- (CEResultAndStream*)evaluateSeq:(id<Stream>)stream left:(evaluator)left right:(evaluator)right;
- (CEResultAndStream*)evaluateMany:(id<Stream>)stream body:(evaluator)body;
- (CEResultAndStream*)evaluateChar:(id<Stream>)stream char:(char)char_;
- (CEResultAndStream*)evaluateManyOne:(id<Stream>)stream body:(evaluator)body;
- (CEResultAndStream*)char:(id<Stream>)stream;
- (CEResultAndStream*)anything:(id<Stream>)stream;
- (CEResultAndStream*)eof:(id<Stream>)stream;

@end