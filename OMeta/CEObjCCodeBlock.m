//
//  CEObjCCodeBlock.m
//  OMeta
//
//  Created by Chris Eidhof on 11/25/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEObjCCodeBlock.h"

@interface CEObjCCodeBlock () {
    NSString* code;
}

@end

@implementation CEObjCCodeBlock

- (id)initWithCode:(NSString *)code_ {
    self = [super init];
    if(self) {
        code = code_;
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[CEObjCCodeBlock class]]) {
        CEObjCCodeBlock* other = (CEObjCCodeBlock*)object;
        return [code isEqual:other->code];
    }
    return NO;
}

- (NSUInteger)hash {
    return [code hash];
}

- (NSString*)description {
    return code;
}

- (NSString*)compile {
    return code;
}

@end
