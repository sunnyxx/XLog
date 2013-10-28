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
// warning
#define SYWarning(format...)    XLogBase(@"sy", XWarningLevel, format)
// error
#define SYError(format...)    XLogBase(@"sy", XErrorLevel, format)

// modules
#define DBLog(format...)        XLogBase(@"Database", XInfoLevel, format)
#define DBWarning(format...)    XLogBase(@"Database", XWarningLevel, format)
#define DBError(format...)      XLogBase(@"Database", XErrorLevel, format)
#define NetworkLog(format...)        XLogBase(@"Network", XInfoLevel, format)
#define NetworkWarning(format...)    XLogBase(@"Network", XWarningLevel, format)
#define NetworkError(format...)      XLogBase(@"Network", XErrorLevel, format)

@interface SNSLoggingDelegate : NSObject <XLoggerDelegate>

@end

