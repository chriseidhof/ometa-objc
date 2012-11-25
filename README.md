This is my Objective-C implementation of
[OMeta](http://www.tinlizzie.org/ometa-js/). It's work in progress, to
get an idea what's working have a look at the tests. The calculator is
working already:

    ometa Calc {
    
      {{{ - (void)setup { self.vars = [NSMutableDictionary dictionary]; }
    }}}
    
      num = digit+ : ds -> {{{ @([[ds componentsJoinedByString:@""]
    integerValue]) }}},
    
      spaces = ' '*,
    
      var = letter:x spaces -> x,
    
      prim = var:x spaces -> {{{ self.vars[x] }}}
           | num:n spaces -> n
           | '(' exp:x ')' spaces -> x,
    
      mulExp = prim:x '*' spaces mulExp:y -> {{{ @([x intValue] * [y
    intValue]) }}}
             | prim:x '/' spaces mulExp:y -> {{{ @([x intValue] / [y
    intValue]) }}}
             | prim,
    
      addExp = mulExp:x '+' spaces exp:y -> {{{ @([x intValue] + [y
    intValue]) }}}
             | mulExp:x '-' spaces exp:y -> {{{ @([x intValue] - [y
    intValue]) }}}
             | mulExp,
    
      exp = var:x spaces '=' spaces exp:r -> {{{ self.vars[x] = r }}}
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

Another interesting example is Query.ometa, translating code like this:

    NSString* q = [NSString stringWithFormat:@"select * from User where name='foo' order by birthDate DESC"];
    NSArray* result = [query query:q].result;

into this
    
    NSFetchRequest* f = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    f.predicate = [NSPredicate predicateWithFormat:@"name = %@", @"foo"]
    f.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"birthDate" ascending:NO]];
    return [self.managedObjectContext executeFetchRequest:f error:NULL];

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

* Implement parametrized rules (in progress)
* ? should be independent of ->
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
* The parser understands simple ObjC expressions, but the rest needs to be wrapped in `{{{` and `}}}`
* Use ParseKit?
* Rewrite parser to not use exceptions
* Now we support array literals, how about dictionary literals? Or could
  we support any kind of object?
* Use a proper pretty-printer for compiling the expressions.
* Use clang to parse objc-expressions?
* Think of left-factoring, look at Doaitse's ideas about this, and how OMeta/JS does it
