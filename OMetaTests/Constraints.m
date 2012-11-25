#import "Constraints.h"

@implementation Constraints


- (CEResultAndStream*)null:(id)stream {

 
CEResultAndStream* result = ^{
 return [self empty:stream]; }();
 if(!result.failed  ) { 
 id actResult =  [NSNull null] ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)visualFormatString:(id)stream {

__block id o;
__block id ls;
__block id v;
__block id rs; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* oResult = ^{
return [self evaluateChoice:stream left:^(id stream) {
return [self evaluateSeq:stream left:^(id stream) {
return [self orientation:stream];
 } right:^(id stream) { 
return [self evaluateString:stream string:@":"]; 
 }];
 } right:^(id stream) { 
return [self null:stream];
 }];
}();
o = oResult.result;
return oResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* lsResult = ^{
return [self evaluateChoice:stream left:^(id stream) {
return [self evaluateSeq:stream left:^(id stream) {
return [self superview:stream];
 } right:^(id stream) { 
return [self connection:stream];
 }];
 } right:^(id stream) { 
return [self null:stream];
 }];
}();
ls = lsResult.result;
return lsResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* vResult = ^{
return [self evaluateSeq:stream left:^(id stream) {
return [self view:stream];
 } right:^(id stream) { 
return [self evaluateMany:stream body:^(id stream) {
return [self evaluateSeq:stream left:^(id stream) {
return [self connection:stream];
 } right:^(id stream) { 
return [self view:stream];
 }];
}];
 }];
}();
v = vResult.result;
return vResult;
 } right:^(id stream) { 
CEResultAndStream* rsResult = ^{
return [self evaluateChoice:stream left:^(id stream) {
return [self evaluateSeq:stream left:^(id stream) {
return [self connection:stream];
 } right:^(id stream) { 
return [self superview:stream];
 }];
 } right:^(id stream) { 
return [self null:stream];
 }];
}();
rs = rsResult.result;
return rsResult;
 }];
 }];
 }]; }();
 if(!result.failed  ) { 
 id actResult =  [@[o,ls,v,rs] compact] ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)orientation:(id)stream {

return [self evaluateChoice:stream left:^(id stream) {
return [self evaluateString:stream string:@"H"]; 
 } right:^(id stream) { 
return [self evaluateString:stream string:@"V"]; 
 }];
}

- (CEResultAndStream*)superview:(id)stream {

return [self evaluateString:stream string:@"|"]; 
}

- (CEResultAndStream*)view:(id)stream {

__block id v;
__block id p; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"["]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* vResult = ^{
return [self viewName:stream];
}();
v = vResult.result;
return vResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* pResult = ^{
return [self evaluateChoice:stream left:^(id stream) {
return [self predicateListWithParens:stream];
 } right:^(id stream) { 
return [self null:stream];
 }];
}();
p = pResult.result;
return pResult;
 } right:^(id stream) { 
return [self evaluateString:stream string:@"]"]; 
 }];
 }];
 }]; }();
 if(!result.failed  ) { 
 id actResult =  [@[@"view",v,p] compact] ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)connection:(id)stream {

return [self evaluateChoice:stream left:^(id stream) {
__block id p; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"-"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* pResult = ^{
return [self predicateList:stream];
}();
p = pResult.result;
return pResult;
 } right:^(id stream) { 
return [self evaluateString:stream string:@"-"]; 
 }];
 }]; }();
 if(!result.failed  ) { 
 id actResult =  p ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
 } right:^(id stream) { 
return [self evaluateChoice:stream left:^(id stream) {
return [self evaluateString:stream string:@"-"]; 
 } right:^(id stream) { 
return [self null:stream];
 }];
 }];
}

- (CEResultAndStream*)predicateList:(id)stream {

return [self evaluateChoice:stream left:^(id stream) {
return [self simplePredicate:stream];
 } right:^(id stream) { 
return [self predicateListWithParens:stream];
 }];
}

- (CEResultAndStream*)simplePredicate:(id)stream {

return [self evaluateChoice:stream left:^(id stream) {
return [self metricName:stream];
 } right:^(id stream) { 
return [self positiveNumber:stream];
 }];
}

- (CEResultAndStream*)predicateListWithParens:(id)stream {

__block id p;
__block id ps; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"("]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* pResult = ^{
return [self predicate:stream];
}();
p = pResult.result;
return pResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* psResult = ^{
return [self evaluateMany:stream body:^(id stream) {
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@","]; 
 } right:^(id stream) { 
return [self predicate:stream];
 }];
}];
}();
ps = psResult.result;
return psResult;
 } right:^(id stream) { 
return [self evaluateString:stream string:@")"]; 
 }];
 }];
 }]; }();
 if(!result.failed  ) { 
 id actResult =  [@[p] arrayByAddingObjectsFromArray:ps] ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)predicate:(id)stream {

__block id r;
__block id o;
__block id p; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* rResult = ^{
return [self evaluateChoice:stream left:^(id stream) {
return [self relation:stream];
 } right:^(id stream) { 
return [self null:stream];
 }];
}();
r = rResult.result;
return rResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* oResult = ^{
return [self objectOfPredicate:stream];
}();
o = oResult.result;
return oResult;
 } right:^(id stream) { 
CEResultAndStream* pResult = ^{
return [self evaluateChoice:stream left:^(id stream) {
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"@"]; 
 } right:^(id stream) { 
return [self priority:stream];
 }];
 } right:^(id stream) { 
return [self null:stream];
 }];
}();
p = pResult.result;
return pResult;
 }];
 }]; }();
 if(!result.failed  ) { 
 id actResult =  [@[r,o,p] compact] ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)relation:(id)stream {

return [self evaluateChoice:stream left:^(id stream) {
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"="]; 
 } right:^(id stream) { 
return [self evaluateString:stream string:@"="]; 
 }];
 } right:^(id stream) { 
return [self evaluateChoice:stream left:^(id stream) {
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"<"]; 
 } right:^(id stream) { 
return [self evaluateString:stream string:@"="]; 
 }];
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@">"]; 
 } right:^(id stream) { 
return [self evaluateString:stream string:@"="]; 
 }];
 }];
 }];
}

- (CEResultAndStream*)objectOfPredicate:(id)stream {

return [self evaluateChoice:stream left:^(id stream) {
return [self constant:stream];
 } right:^(id stream) { 
return [self viewName:stream];
 }];
}

- (CEResultAndStream*)priority:(id)stream {

return [self evaluateChoice:stream left:^(id stream) {
return [self metricName:stream];
 } right:^(id stream) { 
return [self number:stream];
 }];
}

- (CEResultAndStream*)constant:(id)stream {

return [self evaluateChoice:stream left:^(id stream) {
return [self metricName:stream];
 } right:^(id stream) { 
return [self number:stream];
 }];
}

- (CEResultAndStream*)metricName:(id)stream {

return [self cIdentifier:stream];
}

- (CEResultAndStream*)viewName:(id)stream {

return [self cIdentifier:stream];
}

- (CEResultAndStream*)positiveNumber:(id)stream {

__block id n; 
CEResultAndStream* result = ^{
 CEResultAndStream* nResult = ^{
return [self number:stream];
}();
n = nResult.result;
return nResult; }();
 if(!result.failed  && [n intValue] > 0  ) { 
 id actResult =  n ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)number:(id)stream {

__block id ds; 
CEResultAndStream* result = ^{
 CEResultAndStream* dsResult = ^{
return [self evaluateManyOne:stream body:^(id stream) {
return [self digit:stream];
}];
}();
ds = dsResult.result;
return dsResult; }();
 if(!result.failed  ) { 
 id actResult =   @([[ds componentsJoinedByString:@""] integerValue]) ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)cIdentifier:(id)stream {

__block id x;
__block id xs; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* xResult = ^{
return [self identifierStart:stream];
}();
x = xResult.result;
return xResult;
 } right:^(id stream) { 
CEResultAndStream* xsResult = ^{
return [self evaluateMany:stream body:^(id stream) {
return [self identifierPart:stream];
}];
}();
xs = xsResult.result;
return xsResult;
 }]; }();
 if(!result.failed  ) { 
 id actResult =  [[@[x] arrayByAddingObjectsFromArray:xs] componentsJoinedByString:@""] ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)identifierStart:(id)stream {

return [self evaluateChoice:stream left:^(id stream) {
return [self letter:stream];
 } right:^(id stream) { 
return [self evaluateString:stream string:@"_"]; 
 }];
}

- (CEResultAndStream*)identifierPart:(id)stream {

return [self evaluateChoice:stream left:^(id stream) {
return [self identifierStart:stream];
 } right:^(id stream) { 
return [self digit:stream];
 }];
}
@end