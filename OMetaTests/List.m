#import "List.h"

@implementation List


- (CEResultAndStream*)parse:(id)stream {

CEResultAndStream* listLike = [self anything:stream];
CEResultAndStream* result_0 = ^(id stream){ 
 return [self evaluateSeq:stream left:^(id stream) {
return [self evaluateString:stream string:@"x"]; 
 } right:^(id stream) { 
return [self evaluateString:stream string:@"y"]; 
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

}
@end