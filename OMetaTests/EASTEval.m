#import "EASTEval.h"

@implementation EASTEval


- (CEResultAndStream*)eval:(id)stream {

return [self evaluateChoice:stream left:^(id stream) {
__block id x; 
CEResultAndStream* result = ^{
 CEResultAndStream* listLike = [self anything:stream];
CEResultAndStream* result_0 = ^(id stream){ 
 return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"num"]; 
 } right:^(id stream) { 
CEResultAndStream* xResult = ^{
return [self anything:stream];
}();
x = xResult.result;
return xResult;
 }];; 
 }(listLike.result);
if(result_0.failed) { 
return fail(stream); 
}

CEResultAndStream* isEmpty = [self eof:result_0.stream];
if ([[isEmpty result] boolValue]) {
return [CEResultAndStream result:@[result_0.result] stream:listLike.stream];

} else {
 return fail(stream); }
 }();
 if(!result.failed  ) { 
 id actResult =  x ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
 } right:^(id stream) { 
return [self evaluateChoice:stream left:^(id stream) {
__block id x;
__block id y; 
CEResultAndStream* result = ^{
 CEResultAndStream* listLike = [self anything:stream];
CEResultAndStream* result_0 = ^(id stream){ 
 return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"add"]; 
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
if(result_0.failed) { 
return fail(stream); 
}

CEResultAndStream* isEmpty = [self eof:result_0.stream];
if ([[isEmpty result] boolValue]) {
return [CEResultAndStream result:@[result_0.result] stream:listLike.stream];

} else {
 return fail(stream); }
 }();
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
 CEResultAndStream* listLike = [self anything:stream];
CEResultAndStream* result_0 = ^(id stream){ 
 return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"mul"]; 
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
if(result_0.failed) { 
return fail(stream); 
}

CEResultAndStream* isEmpty = [self eof:result_0.stream];
if ([[isEmpty result] boolValue]) {
return [CEResultAndStream result:@[result_0.result] stream:listLike.stream];

} else {
 return fail(stream); }
 }();
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
 CEResultAndStream* listLike = [self anything:stream];
CEResultAndStream* result_0 = ^(id stream){ 
 return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"sub"]; 
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
if(result_0.failed) { 
return fail(stream); 
}

CEResultAndStream* isEmpty = [self eof:result_0.stream];
if ([[isEmpty result] boolValue]) {
return [CEResultAndStream result:@[result_0.result] stream:listLike.stream];

} else {
 return fail(stream); }
 }();
 if(!result.failed  ) { 
 id actResult =   @([x intValue] - [y intValue])  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
 } right:^(id stream) { 
__block id x;
__block id y; 
CEResultAndStream* result = ^{
 CEResultAndStream* listLike = [self anything:stream];
CEResultAndStream* result_0 = ^(id stream){ 
 return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"div"]; 
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
if(result_0.failed) { 
return fail(stream); 
}

CEResultAndStream* isEmpty = [self eof:result_0.stream];
if ([[isEmpty result] boolValue]) {
return [CEResultAndStream result:@[result_0.result] stream:listLike.stream];

} else {
 return fail(stream); }
 }();
 if(!result.failed  ) { 
 id actResult =   @([x intValue] / [y intValue])  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
 }];
 }];
 }];
 }];
}
@end