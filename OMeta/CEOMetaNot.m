//
//  CEOMetaNot.m
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOMetaNot.h"

@interface CEOMetaNot () {
    id<CEOMetaExp> body_;
}

@end

@implementation CEOMetaNot

- (id)initWithBody:(id<CEOMetaExp>)body {
    self = [super init];
    if(self) {
        body_ = body;
    }
    return self;
}


- (id<CEOMetaExp>)body {
    return body_;
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[self class]]) {
        CEOMetaNot* other = (CEOMetaNot*)object;
        return [self.body isEqual:other.body];
    }
    return NO;
}

- (NSUInteger)hash {
    return [body_ hash];
}

- (NSString*)description {
    return [NSString stringWithFormat:@"~ ( %@ )", body_];
}

- (NSString*)compile {
    NSString* body = [body_ compile];
    NSArray* expression =
    @[@"return [self evaluateNot:stream body:^(id stream) {",
    body,
    @" }];"];
    return [expression componentsJoinedByString:@"\n"];
}

- (NSArray*)variables {
    return [body_ variables];
}


@end
