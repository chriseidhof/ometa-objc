//
//  CEObjCIdentifier.m
//  OMeta
//
//  Created by Chris Eidhof on 11/25/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEObjCIdentifier.h"

@interface CEObjCIdentifier () {
    NSString* identifier;
}

@end

@implementation CEObjCIdentifier

- (id)initWithIdentifierName:(NSString *)identifier_ {
    self = [super init];
    if(self) {
        identifier = identifier_;
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[CEObjCIdentifier class]]) {
        CEObjCIdentifier* other = (CEObjCIdentifier*)object;
        return [identifier isEqual:other->identifier];
    }
    return NO;
}

- (NSUInteger)hash {
    return [identifier hash];
}

- (NSString*)description {
    return identifier;
}

- (NSString*)compile {
    return identifier;
}

@end
