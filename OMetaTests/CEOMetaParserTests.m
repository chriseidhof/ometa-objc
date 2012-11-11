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
#import "CEOMetaAST.h"

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

#pragma mark Syntax/Regression tests

- (void)testNameAndMany {
    NSString* program = @"ometa Test { var = letter:x space* -> {{{ x }}} }";
    CEOMetaProgram* p = [parser parse:program];
    STAssertTrue(p != nil, @"Should parse named followed by many");
}

- (void)testPriorities {
    id ast = [parser parse:@"ometa X { x='0'+:zeroes }"];
    STAssertNotNil(ast, @"Should parse + followed by name");
}

- (void)testParams {
    id ast = [parser parse:@"ometa X { space = ' ' *, scan :t = space* t}"];
    STAssertNotNil(ast, @"Should parse + followed by name");
}

- (void)testParseRuleApp {
    id ast = [parser parse:@"ometa X { token :t = space* t, x = token ( 'x' )}"];
    STAssertNotNil(ast, @"Should parse + followed by name");
    STAssertFalse(YES, @"TODO: ask original ometa authors about this rule. Is this application or a token followed by 'x'?");
}

#pragma mark Larger Tests

- (void)testCalc {
    [self compileAndWriteToFile:[parser parse:[self program:@"Calc"]]];
}
- (void)testSimpleProgram {
    id result = [parser parse:[self program:@"ExpRecognizer"]];
    STAssertNotNil(result, @"Tokenizer should parse simple program");
}

- (void)testCompileExp {
    [self compileAndWriteToFile:[parser parse:[self program:@"E"]]];
}

- (void)testArray {
    [self compileAndWriteToFile:[parser parse:[self program:@"EAST"]]];
    [self compileAndWriteToFile:[parser parse:[self program:@"EASTEval"]]];
}

- (void)testQuery {
    [self compileAndWriteToFile:[parser parse:[self program:@"Query"]]];
}

#pragma mark Helper methods

- (NSString*)fileNameForProgram:(NSString*)programName {
    return [[@"/Users/chris/Dropbox/Development/iPhone/testing/OMeta/OMetaTests/" stringByAppendingPathComponent:programName] stringByAppendingPathExtension:@"ometam"];
}

- (NSString*)program:(NSString*)programName {
    return [NSString stringWithContentsOfFile:[self fileNameForProgram:programName] encoding:NSUTF8StringEncoding error:NULL];
}

- (void)compileAndWriteToFile:(CEOMetaProgram*)program {
    NSString* compiled = [program compile];
    NSString* name = program.name;
    NSString* fileName = [[@"/Users/chris/Dropbox/Development/iPhone/testing/OMeta/OMetaTests/" stringByAppendingPathComponent:name] stringByAppendingPathExtension:@"m"];;
    NSString* header = [@[@"#import \"", name, @".h\"\n\n"] componentsJoinedByString:@""];;
    [[header stringByAppendingString:compiled] writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
