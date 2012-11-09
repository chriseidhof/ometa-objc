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
}

@end

@implementation CEResultAndStream

- (id)initWithResult:(id)result stream:(id)stream {
    self = [super init];
    if(self) {
        result_ = result;
        stream_ = stream;
    }
    return self;
}

- (id)result {
    return result_;
}

- (id)stream {
    return stream_;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"<result: %@, stream: %@>", result_, stream_];
}


@end
