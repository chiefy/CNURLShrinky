
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

#import "CNURLShrinkyGlobal.h"

#define JSON_TXT @"json"
#define XML_TXT @"xml"
#define TEXT_TXT @""

CNDataFormat CNDataFormatFromString(NSString* str) {
    if([str isEqualToString:JSON_TXT] || [str isEqualToString:[JSON_TXT uppercaseString]]) {
        return CNDataFormatJSON;
    } else if([str isEqualToString:XML_TXT] || [str isEqualToString:[XML_TXT uppercaseString]]) {
        return CNDataFormatXML;
    } else
        return CNDataFormatPlainText;
}

NSString* CNStringFromDataFormat(CNDataFormat df) {
    switch (df) {
        case CNDataFormatJSON:
            return JSON_TXT;
            break;
        case CNDataFormatXML:
            return XML_TXT;
            break;
        case CNDataFormatPlainText:
            return TEXT_TXT;
            break;
        default:
            return nil;
            break;
    }
}

NSString * const CNServiceDataFormatKey = @"Data Format";
NSString * const CNServiceNameKey = @"Service Name";
NSString * const CNAPIUrlsKey = @"API URL";

NSString * const CNShortenKey = @"shorten";
NSString * const CNExpandKey = @"expand";
NSString * const CNFormatKey = @"format";
NSString * const CNAPIBaseUrlKey = @"base";
