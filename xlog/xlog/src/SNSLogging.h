//
//  SNSLogging.h
//  XLogBase
//
//  Created by sunny on 13-10-17.
//
//

#import "XLog.h"

// log
#define SYLog(format...)    XLogBase(@"sy", XInfoLevel, format)
#define CSLog(format...)    XLogBase(@"cs", XInfoLevel, format)
#define WYQLog(format...)   XLogBase(@"wyq",XInfoLevel, format)
#define ZZYLog(format...)   XLogBase(@"zzy",XInfoLevel, format)
#define ZHLog(format...)    XLogBase(@"zh", XInfoLevel, format)
#define TSCLog(format...)   XLogBase(@"tsc",XInfoLevel, format)
#define LWLog(format...)    XLogBase(@"lw", XInfoLevel, format)
#define PHMLog(format...)   XLogBase(@"phm",XInfoLevel, format)
#define WLLog(format...)    XLogBase(@"wl", XInfoLevel, format)
// warning
#define SYWarning(format...)    XLogBase(@"sy", XWarningLevel, format)
#define CSWarning(format...)    XLogBase(@"cs", XWarningLevel, format)
#define WYQWarning(format...)   XLogBase(@"wyq",XWarningLevel, format)
#define ZZYWarning(format...)   XLogBase(@"zzy",XWarningLevel, format)
#define ZHWarning(format...)    XLogBase(@"zh", XWarningLevel, format)
#define TSCWarning(format...)   XLogBase(@"tsc",XWarningLevel, format)
#define LWWarning(format...)    XLogBase(@"lw", XWarningLevel, format)
#define PHMWarning(format...)   XLogBase(@"phm",XWarningLevel, format)
#define WLWarning(format...)    XLogBase(@"wl", XWarningLevel, format)
// error
#define SYError(format...)    XLogBase(@"sy", XErrorLevel, format)
#define CSError(format...)    XLogBase(@"cs", XErrorLevel, format)
#define WYQError(format...)   XLogBase(@"wyq",XErrorLevel, format)
#define ZZYError(format...)   XLogBase(@"zzy",XErrorLevel, format)
#define ZHError(format...)    XLogBase(@"zh", XErrorLevel, format)
#define TSCError(format...)   XLogBase(@"tsc",XErrorLevel, format)
#define LWError(format...)    XLogBase(@"lw", XErrorLevel, format)
#define PHMError(format...)   XLogBase(@"phm",XErrorLevel, format)
#define WLError(format...)    XLogBase(@"wl", XErrorLevel, format)

// modules
#define DBLog(format...)        XLogBase(@"Database", XInfoLevel, format)
#define DBWarning(format...)    XLogBase(@"Database", XWarningLevel, format)
#define DBError(format...)      XLogBase(@"Database", XErrorLevel, format)
#define NetworkLog(format...)        XLogBase(@"Network", XInfoLevel, format)
#define NetworkWarning(format...)    XLogBase(@"Network", XWarningLevel, format)
#define NetworkError(format...)      XLogBase(@"Network", XErrorLevel, format)

@interface SNSLoggingDelegate : NSObject <XLoggerDelegate>

@end

