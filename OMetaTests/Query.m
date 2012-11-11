#import "Query.h"

@implementation Query


- (CEResultAndStream*)query:(id)stream {
return [self selectQuery:stream];
}

- (CEResultAndStream*)spaces:(id)stream {
return [self evaluateMany:stream body:^(id stream) {
return [self evaluateString:stream string:@""]; 
}];
}

- (CEResultAndStream*)fields:(id)stream {
return [self evaluateString:stream string:@"*"]; 
}

- (CEResultAndStream*)letter:(id)stream {
__block id d; 
CEResultAndStream* result = ^{
 CEResultAndStream* dResult = ^{
return [self char:stream];
}();
d = dResult.result;
return dResult; }();
 if(result.result  && [d characterAtIndex:0] >= 'a' && [d characterAtIndex:0] <= 'z'  ) { 
 id actResult =  d  ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
 }
}

- (CEResultAndStream*)identifier:(id)stream {
__block id name; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* nameResult = ^{
return [self evaluateMany:stream body:^(id stream) {
return [self letter:stream];
}];
}();
name = nameResult.result;
return nameResult;
 } right:^(id stream) { 
return [self spaces:stream];
 }]; }();
 if(result.result  ) { 
 id actResult =  [name componentsJoinedByString:@""]  ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
 }
}

- (CEResultAndStream*)selectQuery:(id)stream {
__block id fields;
__block id entityName;
__block id where; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"select"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self spaces:stream];
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* fieldsResult = ^{
return [self fields:stream];
}();
fields = fieldsResult.result;
return fieldsResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"from"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self spaces:stream];
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* entityNameResult = ^{
return [self identifier:stream];
}();
entityName = entityNameResult.result;
return entityNameResult;
 } right:^(id stream) { 
CEResultAndStream* whereResult = ^{
return [self whereClause:stream];
}();
where = whereResult.result;
return whereResult;
 }];
 }];
 }];
 }];
 }];
 }]; }();
 if(result.result  ) { 
 id actResult =  NSFetchRequest* f = [NSFetchRequest fetchRequestWithEntityName:entityName];
    f.predicate = where;
    return [self.managedObjectContext executeFetchRequest:f error:NULL];
   ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
 }
}

- (CEResultAndStream*)whereClause:(id)stream {
__block id e; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"where "]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self spaces:stream];
 } right:^(id stream) { 
CEResultAndStream* eResult = ^{
return [self boolExpr:stream];
}();
e = eResult.result;
return eResult;
 }];
 }]; }();
 if(result.result  ) { 
 id actResult =  e  ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
 }
}

- (CEResultAndStream*)boolExpr:(id)stream {
__block id l;
__block id r; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* lResult = ^{
return [self identier:stream];
}();
l = lResult.result;
return lResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"="]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self spaces:stream];
 } right:^(id stream) { 
CEResultAndStream* rResult = ^{
return [self identifier:stream];
}();
r = rResult.result;
return rResult;
 }];
 }];
 }]; }();
 if(result.result  ) { 
 id actResult =  [NSString stringWithFormat:@"%@ = %@", l, r]  ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
 }
}
@end