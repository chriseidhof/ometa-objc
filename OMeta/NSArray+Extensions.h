//
//  NSArray+Map.h
//  TrainingHub
//
//  Created by Florian on 16.10.12.
//  Copyright (c) 2012 Aprendo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THBlocks.h"

@interface NSArray (Extensions)

- (NSArray*)map:(mapBlock)selector;
- (void)each:(eachBlock)selector;
- (NSArray*)filter:(filterBlock)block;
- (NSArray*)compact;
- (NSArray*)sortByKeys:(NSArray*)keys;
- (void)inBatch:(NSInteger)batchSize block:(batchBlock)block;

// Returns an NSArray with nested NSArrays of children.
// Assumes the input array is sorted.
- (NSArray*)groupBy:(NSString*)key;

- (id)binarySearchForObjectWithComparator:(searchBlock)block;

@end
