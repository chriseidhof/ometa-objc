//
//  CEOMetaNamed.m
//  OMeta
//
//  Created by Chris Eidhof on 11/8/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOMetaNamed.h"

@interface CEOMetaNamed () {
    NSString* name_;
    id<CEOMetaExp> body_;
}

@end

@implementation CEOMetaNamed

- (id)initWithName:(NSString*)name body:(id<CEOMetaExp>)body {
    self = [super init];
    if(self) {
        body_ = body;
        name_ = name;
    }
    return self;
}


- (id<CEOMetaExp>)body {
    return body_;
}

- (NSString*)name {
    return name_;
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[CEOMetaNamed class]]) {
        CEOMetaNamed* other = (CEOMetaNamed*)object;
        return [self.name isEqual:other.name] && [self.body isEqual:other.body];
    }
    return NO;
}

- (NSUInteger)hash {
    return [body_ hash] + [name_ hash];
}

- (NSString*)description {
    return [NSString stringWithFormat:@"( %@ ) : %@", body_, name_];
}

- (NSString*)compile {
    NSString* body = [body_ compile];
    return [@[@"CEResultAndStream* ",name_, @"Result = ^{\n",
            body,
            @"\n}();\n",
            name_, @" = ", name_, @"Result.result;\n",
            @"return ", name_, @"Result;"] componentsJoinedByString:@""];
}

- (NSArray*)variables {
    return [[body_ variables] arrayByAddingObject:name_];
}

@end
