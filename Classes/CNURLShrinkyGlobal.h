
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

/*!
 * @function Singleton GCD Macro
 * https://gist.github.com/1057420#gistcomment-63896
 */
#ifndef SINGLETON_GCD
#define SINGLETON_GCD(classname)                        \
\
+ (classname *)shared##classname {                      \
\
static dispatch_once_t pred;                        \
__strong static classname * shared##classname = nil;\
dispatch_once( &pred, ^{                            \
shared##classname = [[self alloc] init]; });    \
return shared##classname;                           \
}                                                           
#endif


// This is the name of the bundle file with definitions
// for any shortening services you setup.
//
// See the _template.plist inside the bundle for example
#define SERVICE_BUNDLE @"Services.bundle"


typedef enum CNDataFormat {
    CNDataFormatPlainText,
    CNDataFormatJSON,
    CNDataFormatXML
} CNDataFormat;

extern CNDataFormat CNDataFormatFromString(NSString* str);

extern NSString* const CNServiceDataFormatKey;
extern NSString* const CNServiceNameKey;
extern NSString* const CNAPIUrlsKey;
extern NSString* const CNShortenKey;
extern NSString* const CNExpandKey;
extern NSString* const CNAPIBaseUrlKey;
extern NSString* const CNFormatKey;
