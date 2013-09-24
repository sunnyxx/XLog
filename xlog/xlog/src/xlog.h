
#import "xlogger.h"
#import "xlog_ext.h"

//* Base Format Logging *//
static inline void _XLogF(char* file, unsigned int line, NSString* msg)
{
    NSString* fileName = [[[NSString stringWithFormat:@"%s", file] pathComponents] lastObject];
    NSString* output = [NSString stringWithFormat:@"! XLog [%@:%d] %@",fileName,line,msg];
    printf("%s\n", [output UTF8String]);
}
#define XLogF(FORMAT, ...) _XLogF(__FILE__,__LINE__,[NSString stringWithFormat:FORMAT, ##__VA_ARGS__])

//* Useful Extensions *//
#define XLogObj(obj) XLogF(@"%@", (obj))
#define XLogError(error) XLogF(@"NSError:[%d] %@",error.code, error.localizedDescription)

#define XLogInt(value) XLogF(@"%d", (value))
#define XLogFloat(value) XLogF(@"%f", (value))
#define XLogRect(rect) XLogF(@"CGRect:%@", NSStringFromCGRect((rect)))
#define XLogPoint(point) XLogF(@"CGPoint:%@", NSStringFromCGPoint((point)))