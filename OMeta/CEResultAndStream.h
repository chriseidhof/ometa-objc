//
//  CEResultAndStream.h
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CEResultAndStream : NSObject

- (id)initWithResult:(id)result stream:(id)stream;
- (id)result;
- (id)stream;

@end
