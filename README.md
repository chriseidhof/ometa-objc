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

## Using ometa-objc to compile a grammar into a command line tool

Here is how to start with an .ometam grammar file and generate an
objc-c program which is an evaluator based on that grammar.

First, build the 'ometa-objc' target, which will generate the
ometa-objc command line tool that compiles .metam into .m files. Copy
the ometa-objc utility and the Calc.ometa grammar into the same
directory, and then generate the .m file as follows:

    ometa-objc Calc.ometa

This will generate a Calc.m, which provides the implementation for a
Calc class, which is a subclass of CEEvaluator. This class has methods
corresponding to the productions in the grammar. However, you still
need to write the interface Calc.h file by hand and include
dependencies.

Create a fresh project for a command line tool called Calc. To this
project, add the generated file Calc.m and define the header like so:

    //
    //  Calc.h
    //  OMeta
    
    #import <Foundation/Foundation.h>
    #import "CEEvaluator.h"
    #import "NSString+Stream.h"
    
    @interface Calc : CEEvaluator
    
    @property (nonatomic,strong) NSMutableDictionary* vars;
    - (CEResultAndStream*)exp:(id<Stream>)stream;
    @end
    
Our interface exports only the method "exp", since exp handles
evaluation of expressions and that's all we need since ultimately
everything is an expression.

Add the (transitive closure of ) the dependencies: CEResultAndStream,
CEEvaluator, NSString+Stream. As you add these files to the project,
be sure the .m files are all added to the default target "Calc", so
that they will be linked in.

To exercise the Calculator, fill in the main.m as follows:

    #import <Foundation/Foundation.h>
    #import "Calc.h"
    
    int main(int argc, const char * argv[])
    {
      @autoreleasepool {
        Calc* calc = [[Calc alloc] init];               // create the Calc evaluator
        [calc exp:@"x=10+10"];                          // eval "x=10*10"
        [calc exp:@"x=x*x"];                            // eval "x=x*x"
        CEResultAndStream* result = [calc exp:@"x"];    // eval "x" and save the result
        NSLog(@"calculated result = %@",result.result); // log the value of the result
      }
      return 0;
    }

That code creates a Calc object, feeds it the two expressions
"x=10+10" and "x=x*x", then extracts the result and prints it.

## Using a grammar as a unit test within the project

In the above approach, we put the generated evaluator Calc.m into
a new project and had to bring in depenendencies by hand. An alternative is
to follow the example fo the unit tests already in the project, as follows.

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


# RELATED INFO

* [Ometa homepage](http://tinlizzie.org/ometa/)
* [Ometa/JS workspace](http://www.tinlizzie.org/ometa-js/#Sample_Project)

# ALGAL'S THOUGHTS, QUESTIONS, IDEAS

* wrap the ometa parser generator into a command-line utility
* use clang for obj-c parsing and generation whenever possible
* use blocks to allow some kind of "runtime" compilation ?

  Now: takes .metam where semantic actions are uncompiled Obj-C and generates uncompiled obj-c.
  Instead: takes ometa AST where semantic actions are blocks values, and return a lambda or object.

  Maybe this is impossible or useless.

* 
  
  
