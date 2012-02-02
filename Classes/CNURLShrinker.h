//
//  CNURLShrinker.h
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

#import "CNURLShrinkController.h"
#import "MKNetworkKit.h"

@class CNShrinkerData;

@interface CNURLShrinker : MKNetworkEngine {
    __strong MKNetworkOperation *_currentOperation;
}

@property(nonatomic, assign) CNShrinkerData *shrinkerData;
@property(nonatomic, strong) NSURL *longUrl, *shortUrl;
@property(nonatomic, copy) CNURLShrinkerCompletionBlock doneShortening, doneExpanding;
@property(nonatomic, copy) CNURLShrinkerErrorBlock onError;
@property(nonatomic, readonly) BOOL canShorten, canExpand;

- (id)initWithData:(CNShrinkerData*)data;

- (void)shorten;
- (void)shortenWithCompletionBlock:(CNURLShrinkerCompletionBlock)block
                           orError:(CNURLShrinkerErrorBlock)errorBlock;

- (void)expand;
- (void)expandWithCompletionBlock:(CNURLShrinkerCompletionBlock)block
                          orError:(CNURLShrinkerErrorBlock)errorBlock;

@end
