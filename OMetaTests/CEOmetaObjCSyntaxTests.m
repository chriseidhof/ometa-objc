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

@end
