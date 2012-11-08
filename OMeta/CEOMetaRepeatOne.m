//
//  CEOMetaRepeatOne.m
//  OMeta
//
//  Created by Chris Eidhof on 11/8/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOMetaRepeatOne.h"

@interface CEOMetaRepeatOne () {
    id<CEOMetaExp> body_;
}

@end

@implementation CEOMetaRepeatOne

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
    if([object isKindOfClass:[CEOMetaRepeatOne class]]) {
        CEOMetaRepeatOne* other = (CEOMetaRepeatOne*)object;
        return [self.body isEqual:other.body];
    }
    return NO;
}

- (NSUInteger)hash {
    return [body_ hash];
}

- (NSString*)description {
    return [NSString stringWithFormat:@"( %@ ) *", body_];
}

- (NSString*)compile {
    NSString* body = [body_ compile];
    return [@[@"return [self evaluateManyOne:stream body:^(id stream) {",
            body,
            @"}];"] componentsJoinedByString:@"\n"];
}

- (NSArray*)variables {
    return @[];
}

@end