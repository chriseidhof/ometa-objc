//
//  CEOMetaGeneratedCodeTests.m
//  OMeta
//
//  Created by Chris Eidhof on 11/11/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

// ************
//     NOTE
// ************
// In order for these tests to succeed, you might need to run the test-suite twice
// (the files here get generated in the CEOMetaParserTests class)

#import "CEOMetaGeneratedCodeTests.h"
#import "E.h"
#import "EAST.h"
#import "Calc.h"
#import "EASTEval.h"
#import "Query.h"

@implementation CEOMetaGeneratedCodeTests

- (void)testE {
    E* e = [[E alloc] init];
    CEResultAndStream* result = [e exp:@"20-100*5+10/2"];
    STAssertEquals([result.result intValue], -485, @"Should calculate");
}

- (void)testArray {
    EAST* e = [[EAST alloc] init];
    EASTEval* eval = [[EASTEval alloc] init];
    id ast = @[[e exp:@"20-100*5+10/2"].result];
    CEResultAndStream* result = [eval eval:ast];
    STAssertTrue([result.result isEqual:@(-485)], @"Should eval the AST");
}

- (void)testCalc {
    Calc* calc = [[Calc alloc] init];
    [calc exp:@"x=10+10"];
    [calc exp:@"x=x*x"];
    CEResultAndStream* result = [calc exp:@"x"];
    STAssertTrue([result.result isEqual:@400], @"Calculator should work");
}

@end
