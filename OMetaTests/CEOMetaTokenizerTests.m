//
//  CEOMetaTokinzerTests.m
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOMetaTokenizerTests.h"
#import "CEOMetaTokenizer.h"
#import "CETokens.h"


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

- (NSString*)program {
    NSArray* lines = @[ @"ometa ExpRecognizer{ {{{x}}} "
                         , @"  dig = '0' | '1' | '9',"
                         , @"  num = dig+"
                      , @"}" ];
    return [lines componentsJoinedByString:@"\n"];

}

- (void)testSimpleProgram {
    NSArray* tokenized = [tokenizer tokenize:[self program]];
    NSArray* expectedOutput = @[KEYWORD(@"ometa"),KEYWORD(@"ExpRecognizer"), OP(@"{"), CODE(@"x"), 
                                KEYWORD(@"dig"), OP(@"="), LIT(@"0"), OP(@"|"), LIT(@"1"), OP(@"|"), LIT(@"9"), OP(@","),
                                KEYWORD(@"num"),OP(@"="),KEYWORD(@"dig"),OP(@"+"),
                                OP(@"}")];
    STAssertEqualObjects(tokenized, expectedOutput, @"Tokenizer should parse whitespace");
}

- (void)testEscape {
    NSArray* tokenized = [tokenizer tokenize:@"'\\n' '\\''"];
    NSArray* expectedOutput = @[LIT(@"\\n"), LIT(@"'")];
    STAssertEqualObjects(tokenized, expectedOutput, @"Expect escaping to work");
}




@end
