#import "Predicate.h"

@implementation Predicate


- (CEResultAndStream*)isTrue:(id)stream {

__block id z; 
CEResultAndStream* result = ^{
 CEResultAndStream* zResult = ^{
return [self anything:stream];
}();
z = zResult.result;
return zResult; }();
 if(!result.failed  && [z intValue] > 6 ) { 
 id actResult =  nil ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)semi:(id)stream  :(id)_x{
id x = _x;

 
CEResultAndStream* result = ^{
 return [self evaluateString:stream string:@";"];  }();
 if(!result.failed  ) { 
 id actResult =  x[0] ;
 return [CEResultAndStream result:actResult stream:result.stream];
 } else {
 return fail(stream);
 }
}

- (CEResultAndStream*)print:(id)stream {

return [self semi:stream :@[@5]];
}
@end