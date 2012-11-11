//
//  CEMetaTestQuery.m
//  OMeta
//
//  Created by Chris Eidhof on 11/11/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import "CEMetaTestQuery.h"
#import "Query.h"
#import "NSString+Stream.h"

@interface CEMetaTestQuery () {
    NSManagedObjectContext* context;
    Query* query;
}

@end


@implementation CEMetaTestQuery

- (void)setUp {
    [self setupContext];
    query = [[Query alloc] init];
    query.managedObjectContext = context;
    [self addFixtures];
}

- (void)addFixtures {
    NSManagedObject* o = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    [o setValue:[NSDate date] forKey:@"birthDate"];
    [o setValue:@"foo" forKey:@"name"];
    
    o = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    [o setValue:[[NSDate date] dateByAddingTimeInterval:1000] forKey:@"birthDate"];
    [o setValue:@"bar" forKey:@"name"];
    [context save:nil];
}

- (void)testOrder {
    NSArray* result = [query query:@"select * from User order by birthDate DESC"].result;
    STAssertTrue([[result[0] valueForKey:@"name"] isEqual:@"bar"], @"First object should be bar");
    STAssertTrue([[result[1] valueForKey:@"name"] isEqual:@"foo"], @"Second object should be foo");
}

- (void)testWhere {
    NSString* name = @"foo";
    NSString* q = [NSString stringWithFormat:@"select * from User where name='%@'", name];
    NSArray* result = [query query:q].result;
    STAssertTrue([[result[0] valueForKey:@"name"] isEqual:name], @"Should build where clause");
}

#pragma mark Helpers

- (void)setupContext {
    NSURL* modelURL = [[NSBundle mainBundle] URLForResource:@"TestModel" withExtension:@"momd"];
    NSManagedObjectModel* mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator* coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    [coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL];
    context = [[NSManagedObjectContext alloc] init];
    context.persistentStoreCoordinator = coordinator;
}

@end
