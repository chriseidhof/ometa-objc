#import "Calc.h"

@implementation Calc

 - (void)setup { self.vars = [NSMutableDictionary dictionary]; }  
- (CEResultAndStream*)num:(id)stream {

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
 id actResult =   @([[ds componentsJoinedByString:@""] integerValue])  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)spaces:(id)stream {

return [self evaluateMany:stream body:^(id stream) {
return [self evaluateString:stream string:@" "]; 
}];
}

- (CEResultAndStream*)var:(id)stream {

__block id x; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* xResult = ^{
return [self letter:stream];
}();
x = xResult.result;
return xResult;
 } right:^(id stream) { 
return [self spaces:stream];
 }]; }();
 if(!result.failed  ) { 
 id actResult =  x ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)prim:(id)stream {

return [self evaluateChoice:stream left:^(id stream) {
__block id x; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* xResult = ^{
return [self var:stream];
}();
x = xResult.result;
return xResult;
 } right:^(id stream) { 
return [self spaces:stream];
 }]; }();
 if(!result.failed  ) { 
 id actResult =   self.vars[x]  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
 } right:^(id stream) { 
return [self evaluateChoice:stream left:^(id stream) {
__block id n; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* nResult = ^{
return [self num:stream];
}();
n = nResult.result;
return nResult;
 } right:^(id stream) { 
return [self spaces:stream];
 }]; }();
 if(!result.failed  ) { 
 id actResult =  n ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
 } right:^(id stream) { 
__block id x; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"("]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* xResult = ^{
return [self exp:stream];
}();
x = xResult.result;
return xResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@")"]; 
 } right:^(id stream) { 
return [self spaces:stream];
 }];
 }];
 }]; }();
 if(!result.failed  ) { 
 id actResult =  x ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
 }];
 }];
}

- (CEResultAndStream*)mulExp:(id)stream {

return [self evaluateChoice:stream left:^(id stream) {
__block id x;
__block id y; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* xResult = ^{
return [self prim:stream];
}();
x = xResult.result;
return xResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"*"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self spaces:stream];
 } right:^(id stream) { 
CEResultAndStream* yResult = ^{
return [self mulExp:stream];
}();
y = yResult.result;
return yResult;
 }];
 }];
 }]; }();
 if(!result.failed  ) { 
 id actResult =   @([x intValue] * [y intValue])  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
 } right:^(id stream) { 
return [self evaluateChoice:stream left:^(id stream) {
__block id x;
__block id y; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* xResult = ^{
return [self prim:stream];
}();
x = xResult.result;
return xResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"/"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self spaces:stream];
 } right:^(id stream) { 
CEResultAndStream* yResult = ^{
return [self mulExp:stream];
}();
y = yResult.result;
return yResult;
 }];
 }];
 }]; }();
 if(!result.failed  ) { 
 id actResult =   @([x intValue] / [y intValue])  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
 } right:^(id stream) { 
return [self prim:stream];
 }];
 }];
}

- (CEResultAndStream*)addExp:(id)stream {

return [self evaluateChoice:stream left:^(id stream) {
__block id x;
__block id y; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* xResult = ^{
return [self mulExp:stream];
}();
x = xResult.result;
return xResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"+"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self spaces:stream];
 } right:^(id stream) { 
CEResultAndStream* yResult = ^{
return [self exp:stream];
}();
y = yResult.result;
return yResult;
 }];
 }];
 }]; }();
 if(!result.failed  ) { 
 id actResult =   @([x intValue] + [y intValue])  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
 } right:^(id stream) { 
return [self evaluateChoice:stream left:^(id stream) {
__block id x;
__block id y; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* xResult = ^{
return [self mulExp:stream];
}();
x = xResult.result;
return xResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"-"]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self spaces:stream];
 } right:^(id stream) { 
CEResultAndStream* yResult = ^{
return [self exp:stream];
}();
y = yResult.result;
return yResult;
 }];
 }];
 }]; }();
 if(!result.failed  ) { 
 id actResult =   @([x intValue] - [y intValue])  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
 } right:^(id stream) { 
return [self mulExp:stream];
 }];
 }];
}

- (CEResultAndStream*)exp:(id)stream {

return [self evaluateChoice:stream left:^(id stream) {
__block id x;
__block id r; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* xResult = ^{
return [self var:stream];
}();
x = xResult.result;
return xResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self spaces:stream];
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"="]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self spaces:stream];
 } right:^(id stream) { 
CEResultAndStream* rResult = ^{
return [self exp:stream];
}();
r = rResult.result;
return rResult;
 }];
 }];
 }];
 }]; }();
 if(!result.failed  ) { 
 id actResult =   self.vars[x] = r  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
 } right:^(id stream) { 
return [self addExp:stream];
 }];
}
@end