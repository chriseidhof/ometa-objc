//
//  CEOMetaTestConstraints.m
//  OMeta
//
//  Created by Chris Eidhof on 11/17/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOMetaTestConstraints.h"
#import "Constraints.h"

@interface CEOMetaTestConstraints () {
    Constraints* parser;
}
@end

@implementation CEOMetaTestConstraints

- (void)setUp {
    parser = [[Constraints alloc] init];
}

- (void)testExamples {
    CEResultAndStream* standardSpace = [parser visualFormatString:@"[button]-[textField]"];
    STAssertNotNil(standardSpace.result, @"Should parse");
    CEResultAndStream* widthConstraint = [parser visualFormatString:@"[button(>=50)]"];
    STAssertNotNil(widthConstraint.result, @"Should parse");
    CEResultAndStream* superView = [parser visualFormatString:@"|-50-[orchidBox]-50-|"];
    STAssertNotNil(superView.result, @"Should parse");
    CEResultAndStream* vertical = [parser visualFormatString:@"V:[topField]-10-[bottomField]"];
    STAssertNotNil(vertical.result, @"Should parse");
    CEResultAndStream* complete = [parser visualFormatString:@"|-[find]-50-[findNext]-[findField(>=20,<=100@999)]-|"];
    STAssertNotNil(complete.result, @"Should parse");
}

@end
