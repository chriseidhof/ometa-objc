//
//  CEOMetaProgram.m
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOMetaProgram.h"
#import "NSArray+Extensions.h"

@interface CEOMetaProgram () {
    NSString* name_;
    NSArray* rules_;
}

@end

@implementation CEOMetaProgram

- (id)initWithName:(NSString *)name rules:(NSArray*)rules {
    self = [super init];
    if(self) {
        name_ = name;
        rules_ = rules;
    }
    return self;
}

- (NSString*)name {
    return name_;
}

- (NSArray*)rules {
    return rules_;
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[CEOMetaProgram class]]) {
        CEOMetaProgram* other = (CEOMetaProgram*)object;
        return [self.name isEqual:other.name] && [self.rules isEqual:other.rules] && (([self.code isEqual:other.code]) || (self.code == nil && other.code == nil));
    }
    return NO;
}

- (NSUInteger)hash {
    return [name_ hash] + [rules_ hash] + [_code hash];
}

- (NSString*)description {
    NSString* rulesDescription = [[rules_ map:^id(id obj) {
        return [obj description];
    }] componentsJoinedByString:@",\n"];
    return [NSString stringWithFormat:@"ometa %@ { {{{ %@ }}} %@ }", name_, _code, rulesDescription];
}

- (NSString*)compile {
    NSString* methods = [[self.rules map:^id(id obj) {
        return [obj compile];
    }] componentsJoinedByString:@"\n\n"];
    return [@[[NSString stringWithFormat:@"@implementation %@\n", self.name]
            ,_code ? _code : @""
            ,methods
            ,@"@end"
    ] componentsJoinedByString:@"\n"];
}

@end
