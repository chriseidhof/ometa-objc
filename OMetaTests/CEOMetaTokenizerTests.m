//
//  CEOMetaTokinzerTests.m
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOMetaTokenizerTests.h"
#import "CEOMetaTokenizer.h"



@interface CEOMetaTokenizerTests () {
    CEOMetaTokenizer* tokenizer;
}

@end

@implementation CEOMetaTokenizerTests

- (void)setUp
{
    [super setUp];
    
    tokenizer = [[CEOMetaTokenizer alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (NSString*)program {
    NSArray* lines = @[ @"ometa ExpRecognizer {"
                         , @"  dig = '0' | '1' | '9' ,"
                         , @"  num = dig + ,"
//                         , @"  fac = fac ’*’ num"
//                         , @"    | fac ’/’ num"
//                         , @"    | num ,"
//                         , @"  exp = exp ’+’ fac"
//                         , @"    | exp ’-’ fac"
//                         , @"    | fac"
                      , @"}" ];
    return [lines componentsJoinedByString:@"\n"];

}

- (void)testSimpleProgram {
    NSArray* tokenized = [tokenizer tokenize:[self program]];
    NSArray* expectedOutput = @[@"ometa",@"ExpRecognizer", @"{",
                                @"dig", @"=", @"'0'", @"|", @"'1'", @"|", @"'9'", @",",
                                @"num",@"=",@"dig",@"+",@",",
                                @"}"];
    STAssertEqualObjects(tokenized, expectedOutput, @"Tokenizer should parse whitespace");
}

@end
