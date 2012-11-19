//
//  CEOMetaTestHamlLike.m
//  OMeta
//
//  Created by Chris Eidhof on 11/17/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEOMetaTestHamlLike.h"
#import "Indentation.h"

@interface CEOMetaTestHamlLike () {
    Indentation* parser;
}

@end

@implementation CEOMetaTestHamlLike

- (void)setUp {
    parser = [[Indentation alloc] init];
}

- (void)testIndentation {
    NSString* input = [@[@"%UIView"
     ,@"  %UILabel"
     ,@"    title"
     ,@"  frame = CGRectMake(10,10,100,100)"
     ,@"  backgroundColor = [UIColor redColor]"
    ] componentsJoinedByString:@"\n"];
//    CEResultAndStream* x = [parser nestedBlock:input :@-1];
//    STAssertNotNil(x.result, @"Should parse block");

}

@end
