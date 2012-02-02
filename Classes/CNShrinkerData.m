//
//  CNShinkerData.m
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


#import "CNShrinkerData.h"

@implementation CNShrinkerData

@synthesize APIBaseUrl = _APIBaseUrl,
            name = _name,
            params = _params,
            dataFormat = _dataFormat;

- (id)initWithService:(NSDictionary *)service {
    if( (self = [super init]) ) {
        
        _canExpand = _canShorten = NO;
        
        NSAssert(service, @"CNShrinkerData must be initialized with data from a plist service file");
        
        self.name = [service objectForKey:CNServiceNameKey];
        
        NSMutableDictionary *apiUrls = [[NSMutableDictionary alloc] initWithDictionary:[service objectForKey:CNAPIUrlsKey]];
        
        NSAssert(apiUrls,@"Services require an API URL section");
        
        NSString 
            *shortenKey,
            *expandKey,
            *formatKey;

        NSAssert([apiUrls objectForKey:CNAPIBaseUrlKey], @"Services require a base URL definition for building API calls");
        self.APIBaseUrl = [NSURL URLWithString:[apiUrls objectForKey:CNAPIBaseUrlKey]];
        [apiUrls removeObjectForKey:CNAPIBaseUrlKey];
        
        if( (shortenKey = [apiUrls objectForKey:CNShortenKey]) ) {
            _canShorten = YES;
        }
        
        if( (expandKey = [apiUrls objectForKey:CNExpandKey]) ) {
            _canExpand = YES;
        }
        
        if( (formatKey = [apiUrls objectForKey:CNFormatKey]) ){
            NSDictionary *formats = [service objectForKey:CNServiceDataFormatKey];
            [formats enumerateKeysAndObjectsUsingBlock:
             ^(id key, NSNumber* obj, BOOL *stop){
                 *stop = [obj boolValue];
                 if(stop) {
                     self.dataFormat = CNDataFormatFromString(key);
                 }
             }];
        } else {
            self.dataFormat = CNDataFormatPlainText;
        }
        
        self.params = [[NSDictionary alloc] initWithDictionary:apiUrls];
        
        return self;
    
    } else
        return nil;
}

- (BOOL)canExpand {
    return _canExpand;
}

- (BOOL)canShorten {
    return _canShorten;
}

@end
