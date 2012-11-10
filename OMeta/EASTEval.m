#import "EASTEval.h"

@implementation EASTEval


- (CEResultAndStream*)eval:(id)stream {
return [self evaluateChoice:stream left:^(id stream) {
__block id x; 
CEResultAndStream* result = ^{
 CEResultAndStream* listLike = [self anything:stream];
CEResultAndStream* result_0 = ^(id stream){ 
 return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateChar:stream char:'n']; 
 } right:^(id stream) { 
CEResultAndStream* xResult = ^{
return [self anything:stream];
}();
x = xResult.result;
return xResult;
 }];; 
 }(listLike.result);
if(!result_0.result) { 
return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; 
}

CEResultAndStream* isEmpty = [self eof:result_0.stream];
if ([[isEmpty result] boolValue]) {
return [[CEResultAndStream alloc] initWithResult:@[result_0.result] stream:listLike.stream];

} else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; }
 }();
 if(result.result  ) { 
 id actResult =  x  ;
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
 return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateChar:stream char:'a']; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* xResult = ^{
return [self eval:stream];
}();
x = xResult.result;
return xResult;
 } right:^(id stream) { 
CEResultAndStream* yResult = ^{
return [self eval:stream];
}();
y = yResult.result;
return yResult;
 }];
 }];; 
 }(listLike.result);
if(!result_0.result) { 
return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; 
}

CEResultAndStream* isEmpty = [self eof:result_0.stream];
if ([[isEmpty result] boolValue]) {
return [[CEResultAndStream alloc] initWithResult:@[result_0.result] stream:listLike.stream];

} else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; }
 }();
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
 CEResultAndStream* listLike = [self anything:stream];
CEResultAndStream* result_0 = ^(id stream){ 
 return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateChar:stream char:'m']; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* xResult = ^{
return [self eval:stream];
}();
x = xResult.result;
return xResult;
 } right:^(id stream) { 
CEResultAndStream* yResult = ^{
return [self eval:stream];
}();
y = yResult.result;
return yResult;
 }];
 }];; 
 }(listLike.result);
if(!result_0.result) { 
return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; 
}

CEResultAndStream* isEmpty = [self eof:result_0.stream];
if ([[isEmpty result] boolValue]) {
return [[CEResultAndStream alloc] initWithResult:@[result_0.result] stream:listLike.stream];

} else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; }
 }();
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
 CEResultAndStream* listLike = [self anything:stream];
CEResultAndStream* result_0 = ^(id stream){ 
 return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateChar:stream char:'r']; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* xResult = ^{
return [self eval:stream];
}();
x = xResult.result;
return xResult;
 } right:^(id stream) { 
CEResultAndStream* yResult = ^{
return [self eval:stream];
}();
y = yResult.result;
return yResult;
 }];
 }];; 
 }(listLike.result);
if(!result_0.result) { 
return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; 
}

CEResultAndStream* isEmpty = [self eof:result_0.stream];
if ([[isEmpty result] boolValue]) {
return [[CEResultAndStream alloc] initWithResult:@[result_0.result] stream:listLike.stream];

} else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; }
 }();
 if(result.result  ) { 
 id actResult =  @([x intValue] - [y intValue])  ;
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
 return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateChar:stream char:'d']; 
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* xResult = ^{
return [self eval:stream];
}();
x = xResult.result;
return xResult;
 } right:^(id stream) { 
CEResultAndStream* yResult = ^{
return [self eval:stream];
}();
y = yResult.result;
return yResult;
 }];
 }];; 
 }(listLike.result);
if(!result_0.result) { 
return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; 
}

CEResultAndStream* isEmpty = [self eof:result_0.stream];
if ([[isEmpty result] boolValue]) {
return [[CEResultAndStream alloc] initWithResult:@[result_0.result] stream:listLike.stream];

} else {
 return [[CEResultAndStream alloc] initWithResult:nil stream:stream]; }
 }();
 if(result.result  ) { 
 id actResult =  @([x intValue] / [y intValue])  ;
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