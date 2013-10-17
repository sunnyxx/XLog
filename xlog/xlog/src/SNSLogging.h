//
//  SNSLogging.h
//  xlog
//
//  Created by sunny on 13-10-17.
//
//

#import "XLog.h"

// log
#define SYLog(format...)    XLog(@"sy", XLogInfoLevel, format)
#define CSLog(format...)    XLog(@"cs", XLogInfoLevel, format)
#define WYQLog(format...)   XLog(@"wyq",XLogInfoLevel, format)
#define ZZYLog(format...)   XLog(@"zzy",XLogInfoLevel, format)
#define ZHLog(format...)    XLog(@"zh", XLogInfoLevel, format)
#define TSCLog(format...)   XLog(@"tsc",XLogInfoLevel, format)
#define LWLog(format...)    XLog(@"lw", XLogInfoLevel, format)
#define PHMLog(format...)   XLog(@"phm",XLogInfoLevel, format)
#define WLLog(format...)    XLog(@"wl", XLogInfoLevel, format)
// warning
#define SYWarning(format...)    XLog(@"sy", XLogWarningLevel, format)
#define CSWarning(format...)    XLog(@"cs", XLogWarningLevel, format)
#define WYQWarning(format...)   XLog(@"wyq",XLogWarningLevel, format)
#define ZZYWarning(format...)   XLog(@"zzy",XLogWarningLevel, format)
#define ZHWarning(format...)    XLog(@"zh", XLogWarningLevel, format)
#define TSCWarning(format...)   XLog(@"tsc",XLogWarningLevel, format)
#define LWWarning(format...)    XLog(@"lw", XLogWarningLevel, format)
#define PHMWarning(format...)   XLog(@"phm",XLogWarningLevel, format)
#define WLWarning(format...)    XLog(@"wl", XLogWarningLevel, format)
// error
#define SYError(format...)    XLog(@"sy", XLogErrorLevel, format)
#define CSError(format...)    XLog(@"cs", XLogErrorLevel, format)
#define WYQError(format...)   XLog(@"wyq",XLogErrorLevel, format)
#define ZZYError(format...)   XLog(@"zzy",XLogErrorLevel, format)
#define ZHError(format...)    XLog(@"zh", XLogErrorLevel, format)
#define TSCError(format...)   XLog(@"tsc",XLogErrorLevel, format)
#define LWError(format...)    XLog(@"lw", XLogErrorLevel, format)
#define PHMError(format...)   XLog(@"phm",XLogErrorLevel, format)
#define WLError(format...)    XLog(@"wl", XLogErrorLevel, format)

// modules
#define DBLog(format...)        XLog(@"Database", XLogLevel, format)
#define DBWarning(format...)    XLog(@"Database", XLogWarningLevel, format)
#define DBError(format...)      XLog(@"Database", XLogErrorLevel, format)
#define NetworkLog(format...)        XLog(@"Network", XLogLevel, format)
#define NetworkWarning(format...)    XLog(@"Network", XLogWarningLevel, format)
#define NetworkError(format...)      XLog(@"Network", XLogErrorLevel, format)

