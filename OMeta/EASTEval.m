#import "EASTEval.h"

@implementation EASTEval
- (CEResultAndStream*)eval:(id)stream {
return [self evaluateChoice:stream left:^(id stream) {
__block id x; 
CEResultAndStream* result = ^{
 CEResultAndStream* listLike = [self anything:stream];
CEResultAndStream* result_0 = ^(id stream){ 
 return [self evaluateChar:stream char:'n']; ; 
 }(listLike.result);
if(!result_0.result) { 
return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; 
}
CEResultAndStream* result_1 = ^(id stream){ 
 CEResultAndStream* xResult = ^{
return [self anything:stream];
}();
x = xResult.result;
return xResult;; 
 }(result_0.stream);
if(!result_1.result) { 
return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; 
}

CEResultAndStream* isEmpty = [self eof:result_1.stream];
if ([[isEmpty result] boolValue]) {
return [[CEResultAndStream alloc] initWithResult:@[result_0.result , result_1.result] stream:listLike.stream];

} else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; }
 }();
 if(result.result  ) { 
 id actResult =  x ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
 }
 } right:^(id stream) { 
return [self evaluateChoice:stream left:^(id stream) {
__block id x;
__block id y; 
CEResultAndStream* result = ^{
 CEResultAndStream* listLike = [self anything:stream];
CEResultAndStream* result_0 = ^(id stream){ 
 return [self evaluateChar:stream char:'a']; ; 
 }(listLike.result);
if(!result_0.result) { 
return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; 
}
CEResultAndStream* result_1 = ^(id stream){ 
 CEResultAndStream* xResult = ^{
return [self eval:stream];
}();
x = xResult.result;
return xResult;; 
 }(result_0.stream);
if(!result_1.result) { 
return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; 
}
CEResultAndStream* result_2 = ^(id stream){ 
 CEResultAndStream* yResult = ^{
return [self eval:stream];
}();
y = yResult.result;
return yResult;; 
 }(result_1.stream);
if(!result_2.result) { 
return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; 
}

CEResultAndStream* isEmpty = [self eof:result_2.stream];
if ([[isEmpty result] boolValue]) {
return [[CEResultAndStream alloc] initWithResult:@[result_0.result , result_1.result , result_2.result] stream:listLike.stream];

} else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; }
 }();
 if(result.result  ) { 
 id actResult =  @([x intValue] + [y intValue]) ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
 }
 } right:^(id stream) { 
return [self evaluateChoice:stream left:^(id stream) {
__block id x;
__block id y; 
CEResultAndStream* result = ^{
 CEResultAndStream* listLike = [self anything:stream];
CEResultAndStream* result_0 = ^(id stream){ 
 return [self evaluateChar:stream char:'m']; ; 
 }(listLike.result);
if(!result_0.result) { 
return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; 
}
CEResultAndStream* result_1 = ^(id stream){ 
 CEResultAndStream* xResult = ^{
return [self eval:stream];
}();
x = xResult.result;
return xResult;; 
 }(result_0.stream);
if(!result_1.result) { 
return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; 
}
CEResultAndStream* result_2 = ^(id stream){ 
 CEResultAndStream* yResult = ^{
return [self eval:stream];
}();
y = yResult.result;
return yResult;; 
 }(result_1.stream);
if(!result_2.result) { 
return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; 
}

CEResultAndStream* isEmpty = [self eof:result_2.stream];
if ([[isEmpty result] boolValue]) {
return [[CEResultAndStream alloc] initWithResult:@[result_0.result , result_1.result , result_2.result] stream:listLike.stream];

} else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; }
 }();
 if(result.result  ) { 
 id actResult =  @([x intValue] * [y intValue]) ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
 }
 } right:^(id stream) { 
return [self evaluateChoice:stream left:^(id stream) {
__block id x;
__block id y; 
CEResultAndStream* result = ^{
 CEResultAndStream* listLike = [self anything:stream];
CEResultAndStream* result_0 = ^(id stream){ 
 return [self evaluateChar:stream char:'r']; ; 
 }(listLike.result);
if(!result_0.result) { 
return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; 
}
CEResultAndStream* result_1 = ^(id stream){ 
 CEResultAndStream* xResult = ^{
return [self eval:stream];
}();
x = xResult.result;
return xResult;; 
 }(result_0.stream);
if(!result_1.result) { 
return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; 
}
CEResultAndStream* result_2 = ^(id stream){ 
 CEResultAndStream* yResult = ^{
return [self eval:stream];
}();
y = yResult.result;
return yResult;; 
 }(result_1.stream);
if(!result_2.result) { 
return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; 
}

CEResultAndStream* isEmpty = [self eof:result_2.stream];
if ([[isEmpty result] boolValue]) {
return [[CEResultAndStream alloc] initWithResult:@[result_0.result , result_1.result , result_2.result] stream:listLike.stream];

} else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; }
 }();
 if(result.result  ) { 
 id actResult =  @([x intValue] - [y intValue]) ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
 }
 } right:^(id stream) { 
__block id x;
__block id y; 
CEResultAndStream* result = ^{
 CEResultAndStream* listLike = [self anything:stream];
CEResultAndStream* result_0 = ^(id stream){ 
 return [self evaluateChar:stream char:'d']; ; 
 }(listLike.result);
if(!result_0.result) { 
return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; 
}
CEResultAndStream* result_1 = ^(id stream){ 
 CEResultAndStream* xResult = ^{
return [self eval:stream];
}();
x = xResult.result;
return xResult;; 
 }(result_0.stream);
if(!result_1.result) { 
return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; 
}
CEResultAndStream* result_2 = ^(id stream){ 
 CEResultAndStream* yResult = ^{
return [self eval:stream];
}();
y = yResult.result;
return yResult;; 
 }(result_1.stream);
if(!result_2.result) { 
return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; 
}

CEResultAndStream* isEmpty = [self eof:result_2.stream];
if ([[isEmpty result] boolValue]) {
return [[CEResultAndStream alloc] initWithResult:@[result_0.result , result_1.result , result_2.result] stream:listLike.stream];

} else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; }
 }();
 if(result.result  ) { 
 id actResult =  @([x intValue] / [y intValue]) ;
 return [[CEResultAndStream alloc] initWithResult:actResult stream:result.stream];
 } else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream];
 }
 }];
 }];
 }];
 }];
}
@end