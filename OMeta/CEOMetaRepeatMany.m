//
//  CEOMetaRepeatMany.m
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOMetaRepeatMany.h"

@interface CEOMetaRepeatMany () {
    id<CEOMetaExp> body_;
}

@end

@implementation CEOMetaRepeatMany

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
    if([object isKindOfClass:[CEOMetaRepeatMany class]]) {
        CEOMetaRepeatMany* other = (CEOMetaRepeatMany*)object;
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
    return [@[@"return [self evaluateMany:stream body:^(id stream) {",
            body,
            @"}];"] componentsJoinedByString:@"\n"];
}

- (NSArray*)variables {
    return [body_ variables];
}

@end
