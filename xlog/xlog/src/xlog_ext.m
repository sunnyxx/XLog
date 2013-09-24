
#import "xlog_ext.h"
#import "xlogger.h"

@implementation NSString (xlog)

- (void)xlog
{
    [[xlogger shared] log:self];
}

@end