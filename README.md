# CNURLShrink
By Christopher "Chief" Najewicz - [@tehsuck](http://twitter.com/tehsuck)  
[http://beefdisciple.com](http://beefdisciple.com)

## About

**CNURLShrinky** is an ARC based URL shortening Framework / Library.
Several years ago I had an idea for a simple Cocoa-based application that would allow DropBox users to easily share a file via their choice of URL Shortener. I ran across a great Objective-C based library called [URL-shink](https://github.com/amazingsyco/url-shrink) and eventually forked it and modified / improved it a bit.

Unfortunately that project has gone stale, and I am working on a new version of my app and want to improve upon what I envision url-shrink had potential to be for developers wanting a somewhat-simple dropin to support various URL-shorteners.

For now I am using the great [MKNetworkKit](https://github.com/MugunthKumar/MKNetworkKit) to allow for async and enqueued URL/API calls to services, [JSONKit](https://github.com/johnezang/JSONKit) for JSON support and [gdata-objectivec-client's XML support](http://code.google.com/p/gdata-objectivec-client/) for XML parsing.


## Services
I plan to implement the following services initially:
* [bit.ly](http://bit.ly/)
* [goo.gl](http://goo.gl/)
* [tinyURL](http://tinyurl.com/)
* [is.gd / v.gd](http://is.gd/)
* [TiNY](http://tiny.cc/)
* [to.ly](http://to.ly/)
* [bdb.im](http://bdb.im/)


## OS Support
CNURLShrinky will support OSX 10.6+ and iOS 4.2+


## Status
As of this commit the project builds, but has no functionality. I'll be working on that in weeks to come.