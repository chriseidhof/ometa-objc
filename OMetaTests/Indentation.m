#import "Indentation.h"

@implementation Indentation


- (NSArray*)parse:(id)stream {
  return [self nestedBlock:stream :@(-1)].result;
}
  
- (CEResultAndStream*)newLine:(id)stream {

return [self evaluateString:stream string:@"\n"]; 
}

- (CEResultAndStream*)wsNoNL:(id)stream {

__block id spaces; 
CEResultAndStream* result = ^{
 CEResultAndStream* spacesResult = ^{
return [self evaluateMany:stream body:^(id stream) {
return [self evaluateString:stream string:@" "]; 
}];
}();
spaces = spacesResult.result;
return spacesResult; }();
 if(!result.failed  ) { 
 id actResult =  @([spaces count]) ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)wsToEnd:(id)stream {

return [self evaluateSeq:stream left:^(id stream) {
return [self wsNoNL:stream];
 } right:^(id stream) { 
return [self newLine:stream];
 }];
}

- (CEResultAndStream*)startWS:(id)stream {

__block id x; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateManyOne:stream body:^(id stream) {
return [self wsToEnd:stream];
}];
 } right:^(id stream) { 
CEResultAndStream* xResult = ^{
return [self wsNoNL:stream];
}();
x = xResult.result;
return xResult;
 }]; }();
 if(!result.failed  ) { 
 id actResult =  x ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

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

- (CEResultAndStream*)exp:(id)stream  :(id)_indent{
id indent = _indent;

__block id contents;
__block id children; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* contentsResult = ^{
return [self evaluateManyOne:stream body:^(id stream) {
return [self not:stream body:^(id stream) {
return [self newLine:stream];
 }];
}];
}();
contents = contentsResult.result;
return contentsResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
return [self newLine:stream];
 } right:^(id stream) { 
CEResultAndStream* childrenResult = ^{
return [self evaluateChoice:stream left:^(id stream) {
return [self nestedBlock:stream :indent];
 } right:^(id stream) { 
return [self null:stream];
 }];
}();
children = childrenResult.result;
return childrenResult;
 }];
 }]; }();
 if(!result.failed  ) { 
 id actResult =  @[[contents componentsJoinedByString:@""],children] ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)blockLine:(id)stream  :(id)_indent{
id indent = _indent;

__block id currIndent;
__block id r; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* currIndentResult = ^{
return [self startWS:stream];
}();
currIndent = currIndentResult.result;
return currIndentResult;
 } right:^(id stream) { 
CEResultAndStream* rResult = ^{
return [self exp:stream :currIndent];
}();
r = rResult.result;
return rResult;
 }]; }();
 if(!result.failed  && [indent intValue] == [currIndent intValue] ) { 
 id actResult =  r ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)nestedBlock:(id)stream  :(id)_curr{
id curr = _curr;

return [self evaluateChoice:stream left:^(id stream) {
__block id x;
__block id r; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* xResult = ^{
return [self wsNoNL:stream];
}();
x = xResult.result;
return xResult;
 } right:^(id stream) { 
CEResultAndStream* rResult = ^{
return [self exp:stream :x];
}();
r = rResult.result;
return rResult;
 }]; }();
 if(!result.failed  && [x intValue] > [curr intValue] ) { 
 id actResult =  @[r] ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
 } right:^(id stream) { 
__block id indent;
__block id r;
__block id others; 
CEResultAndStream* result = ^{
 return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* indentResult = ^{
return [self startWS:stream];
}();
indent = indentResult.result;
return indentResult;
 } right:^(id stream) { 
return [self evaluateSeq:stream left:^(id stream) {
CEResultAndStream* rResult = ^{
return [self exp:stream :indent];
}();
r = rResult.result;
return rResult;
 } right:^(id stream) { 
CEResultAndStream* othersResult = ^{
return [self evaluateMany:stream body:^(id stream) {
return [self blockLine:stream :indent];
}];
}();
others = othersResult.result;
return othersResult;
 }];
 }]; }();
 if(!result.failed  && [indent intValue] > [curr intValue] ) { 
 id actResult =  [@[r] arrayByAddingObjectsFromArray:others] ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
 }];
}
@end