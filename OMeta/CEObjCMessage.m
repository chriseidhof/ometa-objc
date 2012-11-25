//
//  CEObjCMessage.m
//  OMeta
//
//  Created by Chris Eidhof on 11/25/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEObjCMessage.h"
#import "NSArray+Extensions.h"

@interface CEObjCMessage () {
    id<CEObjCExp>receiver;
    NSArray* selector;
}

@end

@implementation CEObjCMessage

- (id)initWithReceiver:(id<CEObjCExp>)receiver_ selector:(NSArray *)selector_
{
    self = [super init];
    if (self) {
        receiver = receiver_;
        selector = selector_;
    }
    return self;
}

- (NSString*)compile {
    NSString* selectorString = [[selector map:^id(id<CEObjCExp> obj) {
        return [obj compile];
    }] componentsJoinedByString:@" "];
    return [NSString stringWithFormat:@"[%@ %@]", [receiver compile], selectorString];
}

@end
