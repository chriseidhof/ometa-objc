//
//  main.m
//  ometa-objc
//
//  Created by Alexis Gallagher on 2012-11-27.
//  Copyright (c) 2012 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

  @autoreleasepool {

    if (argc != 2) {
      pln(@"usage: ometa-objc /full/path/to/file.ometam");
      exit(1);
    }
    
    NSString * filepath = [NSString stringWithCString:argv[1] encoding:NSASCIIStringEncoding];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
      NSLog(@"No file found at path %@",filepath)
      exit(1);
    }

    

  }
  return 0;
}

