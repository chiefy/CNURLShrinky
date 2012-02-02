//
//  CNURLShrinker.m
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

#import "CNURLShrinker.h"
#import "CNShrinkerData.h"
#import "MKNetworkKit.h"
#import "JSONKit.h"

@interface CNURLShrinker (/*PRIVATE*/) 
- (NSMutableDictionary*)buildParamsForShorten;
@end

@implementation CNURLShrinker
@synthesize 
    shrinkerData = _shrinkerData,
    longUrl = _longUrl,
    shortUrl = _shortUrl,
    onError = _onError,
    doneShortening = _doneShortening,
    doneExpanding = _doneExpanding;

- (id)initWithData:(CNShrinkerData*)data {
    NSAssert(data, @"You must instantiate a CNURLShrinker with an instance of CNShrinkerData");
    
    if( (self = [super initWithHostName:data.APIBaseUrl.host customHeaderFields:nil]) ) {
        self.shrinkerData = data;
        return self;
    } else return nil;
}

- (NSMutableDictionary*)buildParamsForShorten {
    NSString *dataFormatDesc = CNStringFromDataFormat(self.shrinkerData.dataFormat);
    
    NSArray *objs = [NSArray arrayWithObjects:
                     [self.longUrl absoluteString],
                     dataFormatDesc,
                     nil];
    NSArray *keys = [NSArray arrayWithObjects:
                     [self.shrinkerData.params objectForKey:CNShortenKey],
                     [self.shrinkerData.params objectForKey:CNFormatKey],
                     nil];
    
    return [NSMutableDictionary dictionaryWithObjects:objs forKeys:keys];
}


- (MKNKResponseBlock)responseBlock {
    return ^(MKNetworkOperation *completedOp) {
        NSLog(@"Completed: %@",[[completedOp.responseData objectFromJSONData] objectForKey:@"shorturl"]);
        if(self.doneShortening)
            self.doneShortening(self);
    };
}

- (MKNKErrorBlock)errorBlock {
    return ^(NSError *error) {
        NSLog(@"Error: %@",error);  
    };
}

- (MKNetworkOperation*)operationWithPath:(NSString *)path 
                                  params:(NSMutableDictionary *)body 
                              httpMethod:(NSString *)method {
    __strong MKNetworkOperation *newOp = [super operationWithPath:path params:body httpMethod:method];
    [newOp onCompletion:[self responseBlock] onError:[self errorBlock]];
    return newOp;
}

- (MKNetworkOperation*)prepShortenOperation {
    NSString *path = [self.shrinkerData.APIBaseUrl.path lastPathComponent];
    MKNetworkOperation *op = [self operationWithPath:path
                                              params:[self buildParamsForShorten]
                                          httpMethod:@"GET"];
    return op;
}

- (BOOL)canShorten {
    return (self.longUrl && self.shrinkerData.canShorten);
}

- (BOOL)canExpand {
    return (self.shortUrl && self.shrinkerData.canExpand);
}

- (void)shorten {
    if(![self canShorten]) return;
    [self enqueueOperation:[self prepShortenOperation]];
}

- (void)shortenWithCompletionBlock:(CNURLShrinkerCompletionBlock)block 
                           orError:(CNURLShrinkerErrorBlock)errorBlock
{
    if(![self canShorten]) return;
    
    self.doneShortening = nil;
    self.doneShortening = block;
    self.onError = nil;
    self.onError = errorBlock;
    [self enqueueOperation:[self prepShortenOperation]];
}

@end
