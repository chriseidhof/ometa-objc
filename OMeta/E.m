#import "E.h"

@implementation E
- (CEResultAndStream*)dig:(id)stream {
return [self evaluateChoice:stream left:^(id stream) {
return [self evaluateChar:stream char:'0']; 
 } right:^(id stream) { 
return [self evaluateChoice:stream left:^(id stream) {
return [self evaluateChar:stream char:'1']; 
 } right:^(id stream) { 
return [self evaluateChoice:stream left:^(id stream) {
return [self evaluateChar:stream char:'2']; 
 } right:^(id stream) { 
return [self evaluateChoice:stream left:^(id stream) {
return [self evaluateChar:stream char:'3']; 
 } right:^(id stream) { 
return [self evaluateChoice:stream left:^(id stream) {
return [self evaluateChar:stream char:'4']; 
 } right:^(id stream) { 
return [self evaluateChoice:stream left:^(id stream) {
return [self evaluateChar:stream char:'5']; 
 } right:^(id stream) { 
return [self evaluateChoice:stream left:^(id stream) {
return [self evaluateChar:stream char:'6']; 
 } right:^(id stream) { 
return [self evaluateChoice:stream left:^(id stream) {
return [self evaluateChar:stream char:'7']; 
 } right:^(id stream) { 
return [self evaluateChoice:stream left:^(id stream) {
return [self evaluateChar:stream char:'8']; 
 } right:^(id stream) { 
return [self evaluateChar:stream char:'9']; 
 }];
 }];
 }];
 }];
 }];
 }];
 }];
 }];
 }];
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
 if(result.result) { 
 id actResult =  @([[ds componentsJoinedByString:@""] integerValue]) ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
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
return [self evaluateChar:stream char:'*']; 
 } right:^(id stream) { 
CEResultAndStream* yResult = ^{
return [self fac:stream];
}();
y = yResult.result;
return yResult;
 }];
 }]; }();
 if(result.result) { 
 id actResult =  @([x integerValue] * [y integerValue]) ;
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
return [self num:stream];
}();
x = xResult.result;
return xResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateChar:stream char:'/']; 
 } right:^(id stream) { 
CEResultAndStream* yResult = ^{
return [self fac:stream];
}();
y = yResult.result;
return yResult;
 }];
 }]; }();
 if(result.result) { 
 id actResult =  @([x integerValue] / [y integerValue]) ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
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
return [self evaluateChar:stream char:'+']; 
 } right:^(id stream) { 
CEResultAndStream* yResult = ^{
return [self exp:stream];
}();
y = yResult.result;
return yResult;
 }];
 }]; }();
 if(result.result) { 
 id actResult =  @([x integerValue] + [y integerValue]) ;
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
return [self fac:stream];
}();
x = xResult.result;
return xResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateChar:stream char:'-']; 
 } right:^(id stream) { 
CEResultAndStream* yResult = ^{
return [self exp:stream];
}();
y = yResult.result;
return yResult;
 }];
 }]; }();
 if(result.result) { 
 id actResult =  @([x integerValue] - [y integerValue]) ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
 }
 } right:^(id stream) { 
return [self fac:stream];
 }];
 }];
}
@end