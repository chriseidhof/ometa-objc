//
//  CEOMetaExp.h
//  OMeta
//
//  Created by Chris Eidhof on 11/7/12.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#ifndef OMeta_CEOMetaExp_h
#define OMeta_CEOMetaExp_h

@protocol CEOMetaExp <NSObject>
- (NSString*)compile;
- (NSArray*)variables;
@end

#endif
