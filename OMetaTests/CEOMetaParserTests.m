//
//  CEOMetaParserTests.m
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOMetaParserTests.h"
#import "CEOMetaParser.h"
#import "CEOMetaTokenizer.h"
#import "CEOMetaProgram.h"
#import "CEOMetaRule.h"
#import "CEOMetaApp.h"
#import "CEOMetaChoice.h"
#import "CEOMetaSeq.h"
#import "CEOMetaRepeatMany.h"
#import "CEOMetaNot.h"
#import "CEOMetaChar.h"
#import "E.h"

@interface CEOMetaParserTests () {
    CEOMetaParser* parser;
}

@end

@implementation CEOMetaParserTests

- (void)setUp
{
    [super setUp];
    CEOMetaTokenizer* tokenizer = [[CEOMetaTokenizer alloc] init];
    parser = [[CEOMetaParser alloc] initWithTokenizer:tokenizer];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (NSString*)program {
    NSArray* lines = @[ @"ometa ExpRecognizer {"
//    , @"  dig = '0' | '1' | '9' ,"
    , @"  num = ( dig | alpha ) * | num"
    , @", dig = num | fac"
    , @", alpha = ~ dig"
    , @", binaryDig = '0' | '1'"
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
    id result = [parser parse:[self program]];
    CEOMetaApp* dig = [[CEOMetaApp alloc] initWithName:@"dig"];
    CEOMetaChoice* digOrAlpha = [[CEOMetaChoice alloc] initWithAlternative:dig right:[[CEOMetaApp alloc] initWithName:@"alpha"]];
    CEOMetaRepeatMany*  manyDigAlpha = [[CEOMetaRepeatMany alloc] initWithBody:digOrAlpha];
    CEOMetaChoice* numBody = [[CEOMetaChoice alloc] initWithAlternative:manyDigAlpha right:[[CEOMetaApp alloc] initWithName:@"num"]];
    CEOMetaRule* rule1 = [[CEOMetaRule alloc] initWithName:@"num" body:numBody];
    CEOMetaChoice* digBody = [[CEOMetaChoice alloc] initWithAlternative:[[CEOMetaApp alloc] initWithName:@"num"] right:[[CEOMetaApp alloc] initWithName:@"fac"]];
    CEOMetaRule* rule2 = [[CEOMetaRule alloc] initWithName:@"dig" body:digBody];
    
    CEOMetaNot*  notDig = [[CEOMetaNot alloc] initWithBody:dig];
    CEOMetaRule* rule3 = [[CEOMetaRule alloc] initWithName:@"alpha" body:notDig];
    
    CEOMetaChar* zero = [[CEOMetaChar alloc] initWithCharacter:'0'];
    CEOMetaChar* one = [[CEOMetaChar alloc] initWithCharacter:'1'];
    CEOMetaChoice* oneOrZero = [[CEOMetaChoice alloc] initWithAlternative:zero right:one];

    CEOMetaRule* rule4 = [[CEOMetaRule alloc] initWithName:@"binaryDig" body:oneOrZero];


    NSArray* rules = @[rule1,rule2,rule3,rule4];
    CEOMetaProgram* expectedResult = [[CEOMetaProgram alloc] initWithName:@"ExpRecognizer" rules:rules];
    STAssertEqualObjects(result, expectedResult, @"Tokenizer should parse simple program");
}

- (NSString*)exp {
    NSArray* lines = @[
      @"ometa E {",
      @"dig = '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' ,",
      @"num = ( dig + ) : ds -> { @([[ds componentsJoinedByString:@\"\"] integerValue]) } ,",
    //@"num = dig + : ds -> { @[@\"num\", [ds componentsJoinedByString:@\"\"]] } ",
      @"fac = num : x '*' fac : y -> { @([x integerValue] * [y integerValue]) }",
      @"    | num : x '/' fac : y -> { @([x integerValue] / [y integerValue]) }",
      @"    | num ,",
      @"exp = fac : x '+' exp : y -> { @([x integerValue] + [y integerValue]) }",
      @"    | fac : x '-' exp : y -> { @([x integerValue] - [y integerValue]) }",
      @"    | fac",
      @"}"
    ];
    return [lines componentsJoinedByString:@"\n"];
}

- (void)testCompileExp {
    CEOMetaProgram* exp = [parser parse:[self exp]];
    NSString* compiled = [exp compile];
    NSString* fileName = @"/Users/chris/Dropbox/Development/iPhone/testing/OMeta/OMeta/E.m";
    NSString* header = @"#import \"E.h\"\n\n";
    [[header stringByAppendingString:compiled] writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
    STAssertNotNil(compiled, @"Should parse exp grammar");
}

- (void)testE {
    E* e = [[E alloc] init];
    CEResultAndStream* result = [e exp:@"20-100*5+10/2"];
    STAssertNotNil(result.result, @"Should have a parse tree");
}

@end
