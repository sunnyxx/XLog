XLog
====
**A lightweight, configurable, teamwork-able objc project logger.**
## Installation
With Cocoapods:
``` ruby
	pod 'XLog', :git=>'https://github.com/sunnyxx/XLog.git'
```
## Quick usage for self-log
**Compare to NSLog,** Fairly a shorter one, with more readable `FileName` and `LineNumber`(by default)
``` objc
	NSLog(@"hello world");
	XLog(@"hello world");
	// 2013-10-29 00:32:19.920 XLogDemo[864:70b] hello world
	// LOG:[main.m:16] hello world
```
**Log with levels**
``` objc
	XLog(@"normal info level");
	XWarning(@"warning level");
	XError(@"error level");
```
**Simple level control**
``` objc
 	[[XLogger defaultLogger] setLevel:XWarningLevel | XErrorLevel];
```
## Config your log  
**Class configuration delegate**
``` objc
	@interface MyLogConfiguration : NSObject <XLoggerDelegate> @end
```
Implement this delegate, notice this is a static CLASS delegate, then set it.
``` objc
	[[XLogger defaultLogger] setDelegate:[MyLogConfiguration class]];
```
The demo implements a delegate using plist, which could be easy to use.  
**Define every macro of team members or modules**
``` objc
	#define MikeLog(format...) XLogBase(@"Mike", XInfoLevel, format)
	#define BobError(format...) XLogBase(@"Bob", XErrorLevel, format)
	#define DBWarning(format...) XLogBase(@"DB", XWarningLevel, format)
```
Then you can see whichever member or module and its levels you want to see by setting the delegate.
## Print your own format with Magic
**Build-in magic formatters**  
You can log like above with some build-in formatters:
``` objc
        CGRect rect = CGRectMake(1, 2, 3, 4);
        XLog(@"rect:%R", rect);
        XLog(@"point:%P", rect.origin);
        XLog(@"size:%S", rect.size);
        XLog(@"selector:%SEL", _cmd);
```
