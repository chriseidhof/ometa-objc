//
//  CEOMetaSeq.m
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOMetaSeq.h"

@interface CEOMetaSeq () {
    id<CEOMetaExp> left_;
    id<CEOMetaExp> right_;
}
@end


@implementation CEOMetaSeq

- (id)initWithLeft:(id<CEOMetaExp>)left right:(id<CEOMetaExp>)right {
    self = [super init];
    if(self) {
        left_ = left;
        right_ = right;
    }
    return self;
}

- (id<CEOMetaExp>)left {
    return left_;
}

- (id<CEOMetaExp>)right {
    return right_;
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[CEOMetaSeq class]]) {
        CEOMetaSeq* other = (CEOMetaSeq*)object;
        return [self.left isEqual:other.left] && [self.right isEqual:self.right];
    }
    return NO;
}

- (NSUInteger)hash {
    return [left_ hash] + [right_ hash];
}

- (NSString*)description {
    return [NSString stringWithFormat:@"( %@ ) ( %@ )", left_, right_];
}

- (NSString*)compile {
        NSString* leftBody = [left_ compile];
        NSString* rightbody = [right_ compile];
        NSArray* expression =
        @[@"return [self evaluateSeq:stream left:^(id stream) {",
        leftBody,
        @" } right:^(id stream) { ",
        rightbody,
        @" }];"];
        return [expression componentsJoinedByString:@"\n"];
}

- (NSArray*)variables {
    return [[left_ variables] arrayByAddingObjectsFromArray:[right_ variables]];
}


@end
