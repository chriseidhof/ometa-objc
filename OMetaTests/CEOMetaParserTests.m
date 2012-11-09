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
#import "EAST.h"
#import "EASTEval.h"

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
      @"dig = char : d ? { [d characterAtIndex:0] >= '0' && [d characterAtIndex:0] <= '9' } -> { d } ,",
      @"num = ( dig + ) : ds -> { @([[ds componentsJoinedByString:@\"\"] integerValue]) } ,",
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

- (NSString*)expAST {
    NSArray* lines = @[
    @"ometa EAST {",
    @"dig = char : d ? { [d characterAtIndex:0] >= '0' && [d characterAtIndex:0] <= '9' } -> { d } ,",
    @"num = ( dig + ) : ds -> { @[@\"n\", @([[ds componentsJoinedByString:@\"\"] integerValue])] } ,",
    @"fac = num : x '*' fac : y -> { @[@\"m\",x,y] }",
    @"    | num : x '/' fac : y -> { @[@\"d\",x,y] }",
    @"    | num ,",
    @"exp = fac : x '+' exp : y -> { @[@\"a\",x,y] }",
    @"    | fac : x '-' exp : y -> { @[@\"r\",x,y] }",
    @"    | fac",
    @"}"
    ];
    return [lines componentsJoinedByString:@"\n"];
}

- (NSString*)expASTEval {
    NSArray* lines = @[
    @"ometa EASTEval {",
    @"eval = [ 'n' anything : x ] -> { x } ",
    @"     | [ 'a' eval : x  eval : y ] -> { @([x intValue] + [y intValue]) } ",
    @"     | [ 'm' eval : x  eval : y ] -> { @([x intValue] * [y intValue]) } ",
    @"     | [ 'r' eval : x  eval : y ] -> { @([x intValue] - [y intValue]) } ",
    @"     | [ 'd' eval : x  eval : y ] -> { @([x intValue] / [y intValue]) } ",
    @"}"
    ];
    return [lines componentsJoinedByString:@"\n"];
  
}

- (void)compileAndWriteToFile:(CEOMetaProgram*)program {
    NSString* compiled = [program compile];
    NSString* name = program.name;
    NSString* fileName = [[@"/Users/chris/Dropbox/Development/iPhone/testing/OMeta/OMeta/" stringByAppendingPathComponent:name] stringByAppendingPathExtension:@"m"];;
    NSString* header = [@[@"#import \"", name, @".h\"\n\n"] componentsJoinedByString:@""];;
    [[header stringByAppendingString:compiled] writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];

}

- (void)testCompileExp {
    CEOMetaProgram* exp = [parser parse:[self exp]];
    [self compileAndWriteToFile:exp];
    STAssertNotNil(exp, @"Should parse exp grammar");
}

- (void)testE {
    E* e = [[E alloc] init];
    CEResultAndStream* result = [e exp:@"20-100*5+10/2"];
    STAssertEquals([result.result intValue], -485, @"Should calculate");
}

- (void)testArray {
    [self compileAndWriteToFile:[parser parse:[self expAST]]];
    [self compileAndWriteToFile:[parser parse:[self expASTEval]]];
    EAST* e = [[EAST alloc] init];
    EASTEval* eval = [[EASTEval alloc] init];
    id ast = @[[e exp:@"20-100*5+10/2"].result];
    CEResultAndStream* result = [eval eval:ast];
    STAssertTrue([result.result isEqual:@(-485)], @"Should eval the AST");
}


@end