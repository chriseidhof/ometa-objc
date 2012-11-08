//
//  THBlocks.h
//  TrainingHub
//
//  Created by Florian on 29.10.12.
//  Copyright (c) 2012 Aprendo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id(^mapBlock)(id obj);
typedef void(^eachBlock)(id obj);
typedef BOOL(^filterBlock)(id obj);
typedef void(^batchBlock)(NSArray* batch);
typedef NSComparisonResult(^searchBlock)(id obj);