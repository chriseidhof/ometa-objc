//
//  CEOMetaRuleApp.m
//  OMeta
//
//  Created by Chris Eidhof on 11/11/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOMetaRuleApp.h"
#import "CEOMetaExp.h"

@interface CEOMetaRuleApp () {
    NSString* name_;
    NSArray* args_;
}

@end

@implementation CEOMetaRuleApp 

- (id)initWithRuleName:(NSString*)name args:(NSArray*)args {
    self = [super init];
    if(self) {
        name_ = name;
        args_ = args;
    }
    return self;
}

- (NSArray*)args {
    return args_;
}

- (NSString*)name {
    return name_;
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[CEOMetaRuleApp class]]) {
        CEOMetaRuleApp* other = (CEOMetaRuleApp*)object;
        return [self.name isEqual:other.name] && [self.args isEqual:other.args];
    }
    return NO;
}

- (NSUInteger)hash {
    return [args_ hash] + [name_ hash];
}

- (NSString*)description {
    return [NSString stringWithFormat:@"%@( %@ )", name_, [args_ componentsJoinedByString:@","]];
}

- (NSString*)compile {
    // TODO: duplicated from list
    
    NSMutableArray* results = [NSMutableArray array];
    
    for(NSInteger i = 0; i < args_.count; i++) {
        NSString* item = args_[i];
        [results addObject:[NSString stringWithFormat:@":%@", item]];
    }

    NSString* vars = [results componentsJoinedByString:@" "];
    NSString* returnVal = [@[@"return [self ", name_, @":stream ", vars, @"];"] componentsJoinedByString:@""];;
    return returnVal;
}

- (NSArray*)variables {
    return @[];
}

@end
