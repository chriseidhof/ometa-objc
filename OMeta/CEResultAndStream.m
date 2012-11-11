//
//  CEResultAndStream.m
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEResultAndStream.h"

@interface CEResultAndStream () {
    id result_;
    id stream_;
    BOOL failed_;
}

@end

@implementation CEResultAndStream

+ (id)result:(id)result stream:(id)stream {
    CEResultAndStream* r = [[[self class] alloc] init];
    if(r) {
        r->result_ = result;
        r->stream_ = stream;
        r->failed_ = NO;
    }
    return r;
}

+ (id)failWithStream:(id)stream {
    CEResultAndStream* r = [[[self class] alloc] init];
    r->stream_ = stream;
    r->failed_ = YES;
    return r;
}

- (id)result {
    return result_;
}

- (id)stream {
    return stream_;
}

- (BOOL)failed {
    return failed_;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"<result: %@, stream: %@>", result_, stream_];
}


@end
