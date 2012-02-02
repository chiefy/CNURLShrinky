//
//  CNURLShrinkController.m
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
#import "CNShrinkerData.h"
#import "CNURLShrinker.h"

@implementation CNURLShrinkController

SINGLETON_GCD(CNURLShrinkController)

@synthesize serviceDefs = _serviceDefs;

+ (CNURLShrinkController*)sharedController {
    return [CNURLShrinkController sharedCNURLShrinkController];
}

- (id) init {
    if ( (self = [super init]) ) {
        // Initialization code here.
        NSBundle *services = [NSBundle bundleWithPath:
                              [NSString stringWithFormat:@"%@/%@",
                               [[NSBundle mainBundle] bundlePath],SERVICE_BUNDLE]];
        NSAssert(services,@"You must include a services bundle to use CNURLShinky with your iOS or Cocoa app");
        
        NSArray *servicePlists = [services pathsForResourcesOfType:@"plist" inDirectory:nil];
        
        NSAssert([servicePlists count] > 0,@"You must include at least one shortening service in your services bundle file");
        
        NSMutableDictionary *newServices = [[NSMutableDictionary alloc] initWithCapacity:servicePlists.count];
        
        for (NSString *plistPath in servicePlists) {
            NSDictionary *servicePlist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
            if (![servicePlist objectForKey:CNServiceNameKey] || 
                [[servicePlist objectForKey:CNServiceNameKey] isEqualToString:@""]) {
                continue;
            }
            CNShrinkerData *data = [[CNShrinkerData alloc] initWithService:servicePlist];
            [newServices setObject:data forKey:data.name];
        }
        _serviceDefs = [[NSDictionary alloc] initWithDictionary:newServices];
    }   
    return self;
}

+ (CNShrinkerData*)serviceDefinitionFor:(NSString*)shrinkerName {
    return [[[CNURLShrinkController sharedController] serviceDefs] objectForKey:shrinkerName];
}


+ (CNURLShrinker*)shortenURL:(NSURL*)longUrl 
                 withServiceName:(NSString*)shrinkerName
                  onComplete:(CNURLShrinkerCompletionBlock)completionBlock
                     onError:(CNURLShrinkerErrorBlock)errorBlock 
{
    CNShrinkerData *serviceDef = [CNURLShrinkController serviceDefinitionFor:shrinkerName];
    NSAssert(serviceDef,@"Could not load service definition");
    
    CNURLShrinker *newShrinker = [[CNURLShrinker alloc] initWithData:serviceDef];
    newShrinker.longUrl = longUrl;
    newShrinker.doneShortening = completionBlock;
    return newShrinker;
}

+ (CNURLShrinker*)shortenURL:(NSURL *)longUrl 
             withServiceName:(NSString *)shrinkerName {
    CNShrinkerData *serviceDef = [CNURLShrinkController serviceDefinitionFor:shrinkerName];
    NSAssert(serviceDef,@"Could not load service definition");
    
    CNURLShrinker *newShrinker = [[CNURLShrinker alloc] initWithData:serviceDef];
    newShrinker.longUrl = longUrl;
    [newShrinker shorten];
    return newShrinker;
}


@end
