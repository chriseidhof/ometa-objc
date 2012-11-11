//
//  CEOMetaRule.m
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOMetaRule.h"

@interface CEOMetaRule () {
    NSString* name_;
    id<CEOMetaExp> body_;
}

@end

@implementation CEOMetaRule

- (id)initWithName:(NSString *)name body:(id<CEOMetaExp>)body {
    self = [super init];
    if(self) {
        name_ = name;
        body_ = body;
    }
    return self;
}

- (NSString*)name {
    return name_;
}

- (id<CEOMetaExp>)body {
    return body_;
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[CEOMetaRule class]]) {
        CEOMetaRule* other = (CEOMetaRule*)object;
        return [self.name isEqual:other.name] && [self.body isEqual:other.body] && [self.args isEqual:other.args];
    }
    return NO;
}

- (NSUInteger)hash {
    return [name_ hash] + [body_ hash] + [self.args hash];
}

- (NSString*)description {
    return [NSString stringWithFormat:@"%@ %@ = %@", name_, self.args, body_];
}

- (NSString*)compile {
    NSString* header = [@[@"- (CEResultAndStream*)", self.name, @":(id)stream {"] componentsJoinedByString:@""];
    NSString* body = [[self body] compile];
    NSString* footer = @"}";
    return [@[header, body, footer] componentsJoinedByString:@"\n"];
}

@end
