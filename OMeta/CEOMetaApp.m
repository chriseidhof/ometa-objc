//
//  CEOMetaApp.m
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOMetaApp.h"

@interface CEOMetaApp () {
    NSString* name_;
}

@end

@implementation CEOMetaApp

- (id)initWithName:(NSString *)name {
    self = [super init];
    if(self) {
        name_ = name;
    }
    return self;
}

- (NSString*)name {
    return name_;
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[CEOMetaApp class]]) {
        CEOMetaApp* other = (CEOMetaApp*)object;
        return [self.name isEqual:other.name];
    }
    return NO;
}

- (NSUInteger)hash {
    return [name_ hash];
}

- (NSString*)description {
    return name_;
}

- (NSString*)compile {
    return [@[@"return [self ", name_, @":stream];"] componentsJoinedByString:@""];;
}

- (NSArray*)variables {
    return @[];
}

@end
