//
//  CEOMetaList.m
//  OMeta
//
//  Created by Chris Eidhof on 11/8/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOMetaList.h"
#import "NSArray+Extensions.h"

@interface CEOMetaList () {
    NSArray* items_;
}

@end

@implementation CEOMetaList

- (id)initWithItems:(NSArray *)items {
    self = [super init];
    if(self) {
        items_ = items;
    }
    return self;
}

- (NSArray*)items {
    return items_;
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[CEOMetaList class]]) {
        CEOMetaList* other = (CEOMetaList*)object;
        return [self.items isEqual:other.items];
    }
    return NO;
}

- (NSUInteger)hash {
    return [items_ hash];
}

- (NSString*)description {
    NSArray* escapedItems = [items_ map:^id(id obj) {
        return [NSString stringWithFormat:@"(%@)", obj];
    }];
    return [NSString stringWithFormat:@"[ %@ ]", [escapedItems componentsJoinedByString:@" "]];;
}

- (NSString*)compile {
    NSMutableString* compiledItems = [NSMutableString string];
    NSMutableArray* results = [NSMutableArray array];
    
    NSString* currentStream = @"listLike.result";
    for(NSInteger i = 0; i < items_.count; i++) {
        id<CEOMetaExp> item = items_[i];
        NSString* compiledItem = [item compile];
        [compiledItems appendString:[NSString stringWithFormat:@"CEResultAndStream* result_%d = ^(id stream){ \n %@; \n }(%@);\nif(result_%d.failed) { \nreturn fail(stream); \n}\n", i, compiledItem, currentStream, i]];
        currentStream = [NSString stringWithFormat:@"result_%d.stream", i];
        [results addObject:[NSString stringWithFormat:@"result_%d.result", i]];
    }
    NSString* listLike = @"CEResultAndStream* listLike = [self anything:stream];";
    NSString* empty = [NSString stringWithFormat:@"CEResultAndStream* isEmpty = [self eof:%@];", currentStream];
    NSString* returnVal = [NSString stringWithFormat:@"return [CEResultAndStream result:@[%@] stream:listLike.stream];\n", [results componentsJoinedByString:@" , "]];

    NSString* test = [NSString stringWithFormat:@"if ([[isEmpty result] boolValue]) {\n%@\n} else {\n return fail(stream); }\n", returnVal];
    
    return [@[listLike,compiledItems,empty,test] componentsJoinedByString:@"\n"];
}

- (NSArray*)variables {
    return [[items_ map:^id(id obj) {
        return [obj variables];
    }] flatten];
}

@end
