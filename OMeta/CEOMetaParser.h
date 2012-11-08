//
//  CEOMetaParser.h
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEOMetaTokenizer.h"

@interface CEOMetaParser : NSObject

- (id)initWithTokenizer:(id<CEOMetaTokenizer>)tokenizer;
- (id)parse:(NSString*)input;

@end
