//
//  CEOMetaAct.h
//  OMeta
//
//  Created by Chris Eidhof on 11/8/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEOMetaExp.h"
#import "CEObjCExp.h"

@interface CEOMetaAct : NSObject <CEOMetaExp>

- (id)initWithLeft:(id<CEOMetaExp>)left act:(id<CEObjCExp>)act;

@property (nonatomic,strong) id<CEObjCExp> condition;

@end
