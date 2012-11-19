#import "HamlLike.h"

@implementation HamlLike


- (CEResultAndStream*)view:(id)stream {

__block id n; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"%"]; 
 } right:^(id stream) { 
CEResultAndStream* nResult = ^{
return [self className:stream];
}();
n = nResult.result;
return nResult;
 }]; }();
 if(!result.failed  ) { 
 id actResult =   [[NSClassFromString(n) alloc] init]  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)property:(id)stream  :(id)_viewName{
id viewName = _viewName;

__block id p; 
CEResultAndStream* result = ^{
 CEResultAndStream* pResult = ^{
return [self anything:stream];
}();
p = pResult.result;
return pResult; }();
 if(!result.failed  ) { 
 id actResult =   ^{NSLog(@"%@.%@", viewName, p); return p;}()  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)className:(id)stream {

return [self identifier:stream];
}

- (CEResultAndStream*)line:(id)stream  :(id)_context{
id context = _context;

__block id x;
__block id y; 
CEResultAndStream* result = ^{
 CEResultAndStream* listLike = [self anything:stream];
CEResultAndStream* result_0 = ^(id stream){ 
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* xResult = ^{
return [self view:stream];
}();
x = xResult.result;
return xResult;
 } right:^(id stream) { 
CEResultAndStream* yResult = ^{
return [self anything:stream];
}();
y = yResult.result;
return yResult;
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
 id actResult =   ^{[context addSubview:x]; return x;}  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)identifier:(id)stream {

__block id xs; 
CEResultAndStream* result = ^{
 CEResultAndStream* xsResult = ^{
return [self evaluateMany:stream body:^(id stream) {
return [self letter:stream];
}];
}();
xs = xsResult.result;
return xsResult; }();
 if(!result.failed  ) { 
 id actResult =  [xs componentsJoinedByString:@""] ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}
@end