//
//  main.m
//  ometa-objc
//
//  Created by Alexis Gallagher on 2012-11-27.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CEOMetaTokenizer.h"
#import "CEOMetaParser.h"
#import "CEOMetaProgram.h"

int main(int argc, const char * argv[])
{

  @autoreleasepool {

    if (argc != 2) {
      NSLog(@"usage: ometa-objc /full/path/to/file.ometam");
      exit(1);
    }
    
    NSString * ometaFilepath = [NSString stringWithCString:argv[1] encoding:NSUTF8StringEncoding];
    if (![[NSFileManager defaultManager] fileExistsAtPath:ometaFilepath]) {
      NSLog(@"No file found at path %@",ometaFilepath);
      exit(1);
    }
    
    NSString * ometaFilestring = [NSString stringWithContentsOfFile:ometaFilepath encoding:NSUTF8StringEncoding error:NULL];
    if (!ometaFilestring) {
      NSLog(@"Unable to read file %@, probably due to it not being encoded at UTF8",ometaFilepath);
      exit(1);
    }
    CEOMetaTokenizer * tokenizer =[[CEOMetaTokenizer alloc] init];
    CEOMetaParser * parser = [[CEOMetaParser alloc] initWithTokenizer:tokenizer];
    CEOMetaProgram * program = [parser parse:ometaFilestring];
    NSString * programSourceWithoutHeader = [program compile];

    NSString * compiledFilename = program.name;
    NSString * compiledFilePath = [[[[NSFileManager defaultManager] currentDirectoryPath]
                                    stringByAppendingPathComponent:compiledFilename] stringByAppendingPathExtension:@"m"];

    NSString * programSource = [NSString stringWithFormat:
                                @"#import \"%@.h\"\n\n%@",compiledFilename,programSourceWithoutHeader];
    
    BOOL success = [programSource writeToFile:compiledFilePath atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    
    if (!success) {
      NSLog(@"error saving generated parser to path %@ with contents:\n%@",compiledFilePath,programSource);
    }
                                
  }
  return 0;
}

