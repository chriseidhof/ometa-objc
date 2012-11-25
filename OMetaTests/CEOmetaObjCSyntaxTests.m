//
//  CEOmetaObjCSyntaxTests.m
//  OMeta
//
//  Created by Chris Eidhof on 11/25/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOmetaObjCSyntaxTests.h"
#import "CEOMetaParser.h"

@interface CEOmetaObjCSyntaxTests () {
    CEOMetaParser* parser;
}

@end

@implementation CEOmetaObjCSyntaxTests

- (void)setUp {
    [super setUp];
    CEOMetaTokenizer* tokenizer = [[CEOMetaTokenizer alloc] init];
    parser = [[CEOMetaParser alloc] initWithTokenizer:tokenizer];
}

- (void)testIdentifier {
    [parser parse:@"ometa Test { test = 'a':x -> x }"];
}

- (void)testArray {
    [parser parse:@"ometa Test { test = 'a':x -> @[] }"];
    [parser parse:@"ometa Test { test = 'a':x -> @[x] }"];
    [parser parse:@"ometa Test { test = 'a':x -> @[x,y,z] }"];
}

- (void)testString {
    [parser parse:@"ometa Test { test = 'a':x -> @\"hello, world\" }"];
}

- (void)testParseSimpleMessage {
    [parser parse:@"ometa Test { test = 'a' -> [NSNull null] }"];
}

@end
