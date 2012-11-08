//
//  NSArray+Map.m
//  TrainingHub
//
//  Created by Florian on 16.10.12.
//  Copyright (c) 2012 Aprendo. All rights reserved.
//

#import "NSArray+Extensions.h"

@implementation NSArray (Extensions)

- (NSArray*)map:(mapBlock)block {
    NSMutableArray* result = [NSMutableArray array];
    for(id obj in self) {
        id objResult = block(obj);
        [result addObject:objResult ? objResult : [NSNull null]];
    }
    return result;
}

- (void)each:(eachBlock)block {
    for(id obj in self) {
        block(obj);
    }
}

- (NSArray*)filter:(filterBlock)block {
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return block(evaluatedObject);
    }]];
}

- (NSArray*)compact {
    return [self filter:^BOOL(id obj) {
        return obj != [NSNull null];
    }];
}

- (NSArray*)sortByKeys:(NSArray*)keys {
    NSArray* sortDescriptors = [keys map:^id(id key) {
        return [NSSortDescriptor sortDescriptorWithKey:key ascending:YES];
    }];
    return [self sortedArrayUsingDescriptors:sortDescriptors];
}

- (NSArray*)groupBy:(NSString*)key {
  if(self.count == 0) return @[];

    NSMutableArray* result = [NSMutableArray array];
    NSString* currentKey = [self[0] valueForKey:key];
    NSMutableArray* currentGroup = [NSMutableArray array];
    for(id obj in self) {
        id value = [obj valueForKey:key];
        if((value == currentKey) || [value isEqual:currentKey]) {
            [currentGroup addObject:obj];
        } else {
            [result addObject:currentGroup];
            currentGroup = [NSMutableArray arrayWithObject:obj];
            currentKey = value;
        }
    }
    [result addObject:currentGroup];
    return result;
}

- (void)inBatch:(NSInteger)batchSize block:(batchBlock)block {
    if(self.count < batchSize) {
        block(self);
        return;
    }
    
    NSRange currentRange = NSMakeRange(0, batchSize);
    NSInteger count = self.count;
    while(currentRange.location < count) {
        if(currentRange.location + batchSize >= count) {
            currentRange.length = count - currentRange.location - 1;
        }
        block([self subarrayWithRange:currentRange]);
        currentRange.location+=batchSize;
    }
}

// assumes self is sorted by the key you're looking for
- (id)binarySearchForObjectWithComparator:(searchBlock)block {
    return [self binarySearchForObjectWithBlock:block startIndex:0 endIndex:self.count-1];
}

- (id)binarySearchForObjectWithBlock:(searchBlock)block startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    if(endIndex < startIndex) return nil;
    
    NSInteger middleElementIndex = startIndex + (endIndex - startIndex)/2;
    id middleElement = [self objectAtIndex:middleElementIndex];
    NSComparisonResult result = block(middleElement);
    switch (result) {
        case NSOrderedSame:
            return middleElement;
            break;
        case NSOrderedAscending:
            return [self binarySearchForObjectWithBlock:block startIndex:startIndex endIndex:middleElementIndex-1];
            break;
        case NSOrderedDescending:
            return [self binarySearchForObjectWithBlock:block startIndex:middleElementIndex+1 endIndex:endIndex];
            break;
    }
    return nil;
}


@end