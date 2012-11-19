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

- (CEResultAndStream*)lower:(id)stream {

return [self charRange:stream :@"a" :@"z"];
}

- (CEResultAndStream*)upper:(id)stream {

return [self charRange:stream :@"A" :@"Z"];
}

- (CEResultAndStream*)letter:(id)stream {

return [self evaluateChoice:stream left:^(id stream) {
return [self lower:stream];
 } right:^(id stream) { 
return [self upper:stream];
 }];
}

- (CEResultAndStream*)charRange:(id)stream  :(id)_x :(id)_y{
id x = _x;
id y = _y;

__block id d; 
CEResultAndStream* result = ^{
 CEResultAndStream* dResult = ^{
return [self char:stream];
}();
d = dResult.result;
return dResult; }();
 if(!result.failed  &&  [d characterAtIndex:0] >= [x characterAtIndex:0] && [d characterAtIndex:0] <= [y characterAtIndex:0]  ) { 
 id actResult =   d  ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}
@end