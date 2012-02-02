//
//  CNURLShrinkController.h
//  CNURLShrinky

// Copyright (c) 2012 Christopher Najewicz

// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in the 
// Software without restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
// Software, and to permit persons to whom the Software is furnished to do so, 
// subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN 
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

@class CNURLShrinker, CNShrinkerData;

typedef void (^CNURLShrinkerCompletionBlock)(CNURLShrinker* shrinker);
typedef void (^CNURLShrinkerErrorBlock)(NSError *error);

@interface CNURLShrinkController : NSObject {
    
    @private
    NSDictionary *_serviceDefs;

}

@property(nonatomic,strong,readonly) NSDictionary *serviceDefs;

+ (CNURLShrinkController*)sharedCNURLShrinkController;

// Alias of above as by default macro makes long name of singleton
+ (CNURLShrinkController*)sharedController;

+ (CNShrinkerData*)serviceDefinitionFor:(NSString*)shrinkerName;

+ (CNURLShrinker*)shortenURL:(NSURL*)longUrl 
             withServiceName:(NSString*)shrinkerName
                  onComplete:(CNURLShrinkerCompletionBlock)completionBlock
                     onError:(CNURLShrinkerErrorBlock)errorBlock;

+ (CNURLShrinker*)shortenURL:(NSURL*)longUrl 
             withServiceName:(NSString*)shrinkerName;



@end
