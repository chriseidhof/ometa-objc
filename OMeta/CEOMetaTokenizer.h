//
//  CEOMetaTokenizer.h
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CEOMetaTokenizer <NSObject>

- (NSArray*)tokenize:(NSString*)input;

@end

@interface CEOMetaTokenizer : NSObject <CEOMetaTokenizer>
@end
