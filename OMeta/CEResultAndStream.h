//
//  CEResultAndStream.h
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>

#define fail(x) [CEResultAndStream failWithStream:x]

@interface CEResultAndStream : NSObject

+ (id)result:(id)result stream:(id)stream;
+ (id)failWithStream:(id)stream;
- (id)result;
- (BOOL)failed;
- (id)stream;

@end
