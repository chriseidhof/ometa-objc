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

- (id)init {
    self = [super init];
    if(self) {
        [self setup];
    }
    return self;
}

- (void)setup {
}

- (CEResultAndStream*)evaluateChoice:(id<Stream>)stream left:(evaluator)left right:(evaluator)right {
    CEResultAndStream* x = left(stream);
    if(!x.failed) {
        return x;
    }
    return right(stream);
}

- (CEResultAndStream*)evaluateSeq:(id<Stream>)stream left:(evaluator)left right:(evaluator)right {
    CEResultAndStream* x = left(stream);
    if(!x.failed) {
        CEResultAndStream* y = right(x.stream);
        if(!y.failed) {
            return [CEResultAndStream result:@[x.result ? x.result : [NSNull null],y.result ? y.result : [NSNull null]] stream:y.stream];
        }
    }
    return fail(stream);
}

- (CEResultAndStream*)evaluateMany:(id<Stream>)stream body:(evaluator)body {
    CEResultAndStream* x = body(stream);
    if(!x.failed) {
        assert([stream remainingTokens] > [x.stream remainingTokens]);
        CEResultAndStream* y = [self evaluateMany:x.stream body:body];
        if(y.result) {
            return [CEResultAndStream result:[@[x.result] arrayByAddingObjectsFromArray:y.result] stream:y.stream];
        }
    }
    return [CEResultAndStream result:@[] stream:stream];
}

- (CEResultAndStream*)evaluateManyOne:(id<Stream>)stream body:(evaluator)body {
    CEResultAndStream* x = body(stream);
    if(!x.failed) {
        CEResultAndStream* y = [self evaluateMany:x.stream body:body];
        if(y.result) {
            return [CEResultAndStream result:[@[x.result] arrayByAddingObjectsFromArray:y.result] stream:y.stream];
        }
    }
    return fail(stream);
}

- (CEResultAndStream*)evaluateChar:(id<Stream>)stream char:(char)char_ {
    id<NSObject> head = [stream peek];
    if([head isKindOfClass:[NSString class]]) {
        if([head isEqual:[NSString stringWithFormat:@"%c", char_]]) {
            return [stream token];
        }
    }
    return fail(stream);
}

- (CEResultAndStream*)evaluateString:(id<Stream>)stream string:(NSString*)string_ {
    id<NSObject> head = [stream peek];
    if([head isKindOfClass:[NSString class]]) {
        if([head isEqual:string_]) {
            return [stream token];
        }
    }
    return fail(stream);
}


- (CEResultAndStream*)char:(id<Stream>)stream {
    return [stream token];
}

- (CEResultAndStream*)anything:(id<Stream>)stream {
    if([stream remainingTokens] > 0) {
        return [stream token];
    }
    return fail(stream);
}

- (CEResultAndStream*)not:(id<Stream>)stream body:(evaluator)body {
    CEResultAndStream* resultAndStream = body(stream);
    if(resultAndStream.failed) {
        return [stream token];
    } else {
        return fail(stream);        
    }
}

- (CEResultAndStream*)empty:(id<Stream>)stream {
    return [CEResultAndStream result:nil stream:stream];
}

- (CEResultAndStream*)eof:(id<Stream>)stream {
    if([stream remainingTokens] == 0) {
        return [CEResultAndStream result:@YES stream:stream];
    }
    return fail(stream);
}

- (CEResultAndStream*)charRange:(id)stream  :(id)x :(id)y {
    CEResultAndStream* token = [self char:stream];
    NSString* str = (NSString*)token.result;
    if([str isKindOfClass:[NSString class]] && str.length) {
        unichar c = [str characterAtIndex:0];
        if (c >= [x characterAtIndex:0] && c <= [y characterAtIndex:0]) {
            return token;
        }
    }
    return fail(stream);
}

- (CEResultAndStream*)token:(id)stream inCharacterSet:(NSCharacterSet*)characterSet {
    CEResultAndStream* token = [self char:stream];
    NSString* str = (NSString*)token.result;
    if([str isKindOfClass:[NSString class]] && str.length) {
        unichar c = [str characterAtIndex:0];
        if([characterSet characterIsMember:c]) {
            return token;
        }
    }
    return fail(stream);
}

- (CEResultAndStream*)letter:(id)stream {
    return [self token:stream inCharacterSet:[NSCharacterSet letterCharacterSet]];
}

- (CEResultAndStream*)digit:(id)stream {
    return [self token:stream inCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
}


@end
