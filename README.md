This is my Objective-C implementation of
[OMeta](http://www.tinlizzie.org/ometa-js/). It's work in progress, to
get an idea what's working have a look at the tests. The calculator is
working already:

    ometa Calc {
    
      {{{ - (void)setup { self.vars = [NSMutableDictionary dictionary]; }  }}}
    
      dig = char:d ? {{{ [d characterAtIndex:0] >= '0' && [d characterAtIndex:0] <= '9' }}} -> {{{ d }}},
      letter = char:d ? {{{ [d characterAtIndex:0] >= 'a' && [d characterAtIndex:0] <= 'z' }}} -> {{{ d }}},
    
      num = dig+ : ds -> {{{ @([[ds componentsJoinedByString:@""] integerValue]) }}},
    
      space = ' ',
    
      var = letter:x space* -> {{{x}}},
    
      prim = var:x -> {{{ self.vars[x] }}}
           | num
           | '(' exp:x ')' -> {{{ x }}},
    
      mulExp = prim:x '*' mulExp:y -> {{{ @([x intValue] * [y intValue]) }}}
             | prim:x '/' mulExp:y -> {{{ @([x intValue] / [y intValue]) }}}
             | prim,
    
      addExp = mulExp:x '+' exp:y -> {{{ @([x intValue] + [y intValue]) }}}
             | mulExp:x '-' exp:y -> {{{ @([x intValue] - [y intValue]) }}}
             | mulExp,
    
      exp = var:x '=' space* exp:r -> {{{ self.vars[x] = r }}}
          | addExp
    
    }

To compile this code into a .m file, you can do the following:

    CEOMetaTokenizer* tokenizer = [[CEOMetaTokenizer alloc] init];
    parser = [[CEOMetaParser alloc] initWithTokenizer:tokenizer];
    [self compileAndWriteToFile:[parser parse:input]];

    - (void)compileAndWriteToFile:(CEOMetaProgram*)program {
        NSString* compiled = [program compile];
        NSString* name = program.name;
        NSString* fileName = [[@"/Users/chris/Dropbox/Development/iPhone/testing/OMeta/OMeta/" stringByAppendingPathComponent:name] stringByAppendingPathExtension:@"m"];;
        NSString* header = [@[@"#import \"", name, @".h\"\n\n"] componentsJoinedByString:@""];;
        [[header stringByAppendingString:compiled] writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }

And this is how you use it:

    Calc* calc = [[Calc alloc] init];
    [calc exp:@"x=10+10"];
    [calc exp:@"x=x*x"];
    CEResultAndStream* result = [calc exp:@"x"];
    STAssertTrue([result.result isEqual:@400], @"Calculator should calculate.");


If you want to debug the code generator, it helps to re-indent the generated
files before inspecting them. Currently, the debug process for this is a
bit painful (if you generate code that doesn't compile the entire
project doesn't compile).

# Links

* http://tinlizzie.org/~awarth/papers/dls07.pdf

# Why?

I wanted to learn OMeta and implementing it yourself is a fun and
interesting way. I also think it could be very useful to prototype some
ideas I have for languages built on top of the ObjC runtime.

# TODO

* Implement parametrized rules
* Implement higher-order rules
* Clean up the parser (it's a bit complicated)
* Find out how to use this in a real project (how to include this in a Build Phase)
* Subclassing parsers? (Not sure whether I like subclassing as a way of
  extending, think if there's another possibility)
* Including other parsers?

# IDEAS

* Generate blocks instead of methods, and generate methods that wrap the
blocks. Might be handier for composition/optimization
* The CEEvaluator defines some methods, maybe they should be inlined?
* Research how to generate Objective-C classes
* Now, when we compile an `.ometam` file the result is an `.m`. What
 about generating one more step (i.e. the `m` with its input applied)
* Now, the parser doesn't understand any Objective-C, any ObjC code is wrapped
in `{{{` and `}}}`. Maybe add an ObjC parser? This will be difficult.
* Use ParseKit?
* Rewrite parser to not use exceptions
* Now we support array literals, how about dictionary literals? Or could
  we support any kind of object?
* Use a proper pretty-printer for compiling the expressions.
* Use clang to parse expressions?
* Think of left-factoring, look at Doaitse's ideas about this, and how OMeta/JS does it