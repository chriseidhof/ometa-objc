#import "Calc.h"

@implementation Calc

- (void)setup { self.vars = [NSMutableDictionary dictionary]; }  
- (CEResultAndStream*)dig:(id)stream {
__block id d; 
CEResultAndStream* result = ^{
 CEResultAndStream* dResult = ^{
return [self char:stream];
}();
d = dResult.result;
return dResult; }();
 if(result.result  && [d characterAtIndex:0] >= '0' && [d characterAtIndex:0] <= '9'  ) { 
 id actResult =  d  ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
 }
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
 if(result.result  ) { 
 id actResult =  @([[ds componentsJoinedByString:@""] integerValue])  ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
 }
}

- (CEResultAndStream*)space:(id)stream {
return [self evaluateString:stream string:@"_"]; 
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
return [self evaluateMany:stream body:^(id stream) {
return [self space:stream];
}];
 }]; }();
 if(result.result  ) { 
 id actResult =  x ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
 }
}

- (CEResultAndStream*)prim:(id)stream {
return [self evaluateChoice:stream left:^(id stream) {
__block id x; 
CEResultAndStream* result = ^{
 CEResultAndStream* xResult = ^{
return [self var:stream];
}();
x = xResult.result;
return xResult; }();
 if(result.result  ) { 
 id actResult =  self.vars[x]  ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
 }
 } right:^(id stream) { 
return [self evaluateChoice:stream left:^(id stream) {
return [self num:stream];
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
return [self evaluateString:stream string:@")"]; 
 }];
 }]; }();
 if(result.result  ) { 
 id actResult =  x  ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
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
CEResultAndStream* yResult = ^{
return [self mulExp:stream];
}();
y = yResult.result;
return yResult;
 }];
 }]; }();
 if(result.result  ) { 
 id actResult =  @([x intValue] * [y intValue])  ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
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
CEResultAndStream* yResult = ^{
return [self mulExp:stream];
}();
y = yResult.result;
return yResult;
 }];
 }]; }();
 if(result.result  ) { 
 id actResult =  @([x intValue] / [y intValue])  ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
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
CEResultAndStream* yResult = ^{
return [self exp:stream];
}();
y = yResult.result;
return yResult;
 }];
 }]; }();
 if(result.result  ) { 
 id actResult =  @([x intValue] + [y intValue])  ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
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
CEResultAndStream* yResult = ^{
return [self exp:stream];
}();
y = yResult.result;
return yResult;
 }];
 }]; }();
 if(result.result  ) { 
 id actResult =  @([x intValue] - [y intValue])  ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
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
return [self evaluateString:stream string:@"="]; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateMany:stream body:^(id stream) {
return [self space:stream];
}];
 } right:^(id stream) { 
CEResultAndStream* rResult = ^{
return [self exp:stream];
}();
r = rResult.result;
return rResult;
 }];
 }];
 }]; }();
 if(result.result  ) { 
 id actResult =  self.vars[x] = r  ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
 }
 } right:^(id stream) { 
return [self addExp:stream];
 }];
}
@end