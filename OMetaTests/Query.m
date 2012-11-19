#import "Query.h"

@implementation Query


- (CEResultAndStream*)query:(id)stream {

return [self selectQuery:stream];
}

- (CEResultAndStream*)spaces:(id)stream {

return [self evaluateMany:stream body:^(id stream) {
return [self evaluateString:stream string:@" "]; 
}];
}

- (CEResultAndStream*)fields:(id)stream {

return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"*"]; 
 } right:^(id stream) { 
return [self spaces:stream];
 }];
}

- (CEResultAndStream*)kSelect:(id)stream {

return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"s"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"e"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"l"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"e"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"c"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"t"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@" "]; 
 } right:^(id stream) { 
return [self spaces:stream];
 }];
 }];
 }];
 }];
 }];
 }];
 }];
}

- (CEResultAndStream*)kFrom:(id)stream {

return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"f"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"r"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"o"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"m"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@" "]; 
 } right:^(id stream) { 
return [self spaces:stream];
 }];
 }];
 }];
 }];
 }];
}

- (CEResultAndStream*)kOrder:(id)stream {

return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"o"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"r"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"d"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"e"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"r"]; 
 } right:^(id stream) { 
return [self evaluateString:stream string:@" "]; 
 }];
 }];
 }];
 }];
 }];
}

- (CEResultAndStream*)kBy:(id)stream {

return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"b"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"y"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@" "]; 
 } right:^(id stream) { 
return [self spaces:stream];
 }];
 }];
 }];
}

- (CEResultAndStream*)kWhere:(id)stream {

return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"w"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"h"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"e"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"r"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"e"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@" "]; 
 } right:^(id stream) { 
return [self spaces:stream];
 }];
 }];
 }];
 }];
 }];
 }];
}

- (CEResultAndStream*)kASC:(id)stream {

return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"A"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"S"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"C"]; 
 } right:^(id stream) { 
return [self spaces:stream];
 }];
 }];
 }];
}

- (CEResultAndStream*)kDESC:(id)stream {

return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"D"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"E"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"S"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"C"]; 
 } right:^(id stream) { 
return [self spaces:stream];
 }];
 }];
 }];
 }];
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
 if(!result.failed  ) { 
 id actResult =   [name componentsJoinedByString:@""]  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)selectQuery:(id)stream {

__block id fields;
__block id entityName;
__block id where;
__block id order; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
return [self kSelect:stream];
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* fieldsResult = ^{
return [self fields:stream];
}();
fields = fieldsResult.result;
return fieldsResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self kFrom:stream];
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* entityNameResult = ^{
return [self identifier:stream];
}();
entityName = entityNameResult.result;
return entityNameResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* whereResult = ^{
return [self whereClause:stream];
}();
where = whereResult.result;
return whereResult;
 } right:^(id stream) { 
CEResultAndStream* orderResult = ^{
return [self orderClause:stream];
}();
order = orderResult.result;
return orderResult;
 }];
 }];
 }];
 }];
 }]; }();
 if(!result.failed  ) { 
 id actResult =  
    ^{
    NSFetchRequest* f = [NSFetchRequest fetchRequestWithEntityName:entityName];
    f.predicate = where;
    f.sortDescriptors = order;
    return [self.managedObjectContext executeFetchRequest:f error:NULL];
    }()
   ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)whereClause:(id)stream {

return [self evaluateChoice:stream left:^(id stream) {
__block id e; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
return [self kWhere:stream];
 } right:^(id stream) { 
CEResultAndStream* eResult = ^{
return [self boolExpr:stream];
}();
e = eResult.result;
return eResult;
 }]; }();
 if(!result.failed  ) { 
 id actResult =   e  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
 } right:^(id stream) { 
return [self empty:stream];
 }];
}

- (CEResultAndStream*)boolExpr:(id)stream {

__block id field;
__block id r; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* fieldResult = ^{
return [self identifier:stream];
}();
field = fieldResult.result;
return fieldResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"="]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self spaces:stream];
 } right:^(id stream) { 
CEResultAndStream* rResult = ^{
return [self literal:stream];
}();
r = rResult.result;
return rResult;
 }];
 }];
 }]; }();
 if(!result.failed  ) { 
 id actResult =   
  ^{
  NSString* formatString = [field stringByAppendingString:@" = %@"];
  return [NSPredicate predicateWithFormat:formatString, r];
  }();
   ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)literal:(id)stream {

return [self stringLiteral:stream];
}

- (CEResultAndStream*)quote:(id)stream {

return [self evaluateString:stream string:@"'"]; 
}

- (CEResultAndStream*)stringLiteral:(id)stream {

__block id contents; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
return [self quote:stream];
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* contentsResult = ^{
return [self evaluateMany:stream body:^(id stream) {
return [self not:stream body:^(id stream) {
return [self quote:stream];
 }];
}];
}();
contents = contentsResult.result;
return contentsResult;
 } right:^(id stream) { 
return [self quote:stream];
 }];
 }]; }();
 if(!result.failed  ) { 
 id actResult =   [contents componentsJoinedByString:@""]  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)orderClause:(id)stream {

return [self evaluateChoice:stream left:^(id stream) {
__block id i; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
return [self kOrder:stream];
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self kBy:stream];
 } right:^(id stream) { 
CEResultAndStream* iResult = ^{
return [self sortDescriptor:stream];
}();
i = iResult.result;
return iResult;
 }];
 }]; }();
 if(!result.failed  ) { 
 id actResult =   @[i]  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
 } right:^(id stream) { 
return [self empty:stream];
 }];
}

- (CEResultAndStream*)sortDescriptor:(id)stream {

__block id l;
__block id o; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* lResult = ^{
return [self identifier:stream];
}();
l = lResult.result;
return lResult;
 } right:^(id stream) { 
CEResultAndStream* oResult = ^{
return [self ordering:stream];
}();
o = oResult.result;
return oResult;
 }]; }();
 if(!result.failed  ) { 
 id actResult =   [NSSortDescriptor sortDescriptorWithKey:l ascending:[o boolValue]]  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)ordering:(id)stream {

return [self evaluateChoice:stream left:^(id stream) {
 
CEResultAndStream* result = ^{
 return [self kASC:stream]; }();
 if(!result.failed  ) { 
 id actResult =   @YES  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
 } right:^(id stream) { 
return [self evaluateChoice:stream left:^(id stream) {
 
CEResultAndStream* result = ^{
 return [self kDESC:stream]; }();
 if(!result.failed  ) { 
 id actResult =   @NO  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
 } right:^(id stream) { 
 
CEResultAndStream* result = ^{
 return [self empty:stream]; }();
 if(!result.failed  ) { 
 id actResult =   @YES  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
 }];
 }];
}
@end