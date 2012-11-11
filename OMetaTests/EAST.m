#import "EAST.h"

@implementation EAST


- (CEResultAndStream*)dig:(id)stream {

__block id d; 
CEResultAndStream* result = ^{
 CEResultAndStream* dResult = ^{
return [self char:stream];
}();
d = dResult.result;
return dResult; }();
 if(!result.failed  &&  [d characterAtIndex:0] >= '0' && [d characterAtIndex:0] <= '9'  ) { 
 id actResult =   d  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)num:(id)stream {

__block id ds; 
CEResultAndStream* result = ^{
 CEResultAndStream* dsResult = ^{
return [self evaluateManyOne:stream body:^(id stream) {
return [self dig:stream];
}];
}();
ds = dsResult.result;
return dsResult; }();
 if(!result.failed  ) { 
 id actResult =   @[@"n", @([[ds componentsJoinedByString:@""] integerValue])]  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)fac:(id)stream {

return [self evaluateChoice:stream left:^(id stream) {
__block id x;
__block id y; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* xResult = ^{
return [self num:stream];
}();
x = xResult.result;
return xResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"*"]; 
 } right:^(id stream) { 
CEResultAndStream* yResult = ^{
return [self fac:stream];
}();
y = yResult.result;
return yResult;
 }];
 }]; }();
 if(!result.failed  ) { 
 id actResult =   @[@"m",x,y]  ;
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
return [self num:stream];
}();
x = xResult.result;
return xResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"/"]; 
 } right:^(id stream) { 
CEResultAndStream* yResult = ^{
return [self fac:stream];
}();
y = yResult.result;
return yResult;
 }];
 }]; }();
 if(!result.failed  ) { 
 id actResult =   @[@"d",x,y]  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
 } right:^(id stream) { 
return [self num:stream];
 }];
 }];
}

- (CEResultAndStream*)exp:(id)stream {

return [self evaluateChoice:stream left:^(id stream) {
__block id x;
__block id y; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* xResult = ^{
return [self fac:stream];
}();
x = xResult.result;
return xResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"+"]; 
 } right:^(id stream) { 
CEResultAndStream* yResult = ^{
return [self exp:stream];
}();
y = yResult.result;
return yResult;
 }];
 }]; }();
 if(!result.failed  ) { 
 id actResult =   @[@"a",x,y]  ;
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
return [self fac:stream];
}();
x = xResult.result;
return xResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"-"]; 
 } right:^(id stream) { 
CEResultAndStream* yResult = ^{
return [self exp:stream];
}();
y = yResult.result;
return yResult;
 }];
 }]; }();
 if(!result.failed  ) { 
 id actResult =   @[@"r",x,y]  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
 } right:^(id stream) { 
return [self fac:stream];
 }];
 }];
}
@end