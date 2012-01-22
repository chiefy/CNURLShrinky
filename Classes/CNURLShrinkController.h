//
//  CNURLShrinkController.h
//  CNURLShrinky
//
//  Created by Christopher Najewicz on 1/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNURLShrinkController : NSObject

+ (CNURLShrinkController*)sharedCNURLShrinkController;

// Alias of above as by default macro makes long name of singleton
+ (CNURLShrinkController*)sharedController;

@end
