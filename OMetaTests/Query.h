//
//  Query.h
//  OMeta
//
//  Created by Chris Eidhof on 11/11/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEEvaluator.h"
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Query : CEEvaluator

- (CEResultAndStream*)query:(id<Stream>)query;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;

@end
