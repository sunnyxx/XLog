

#import "xlogger.h"

@implementation xlogger

static xlogger* _logger = nil;

+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _logger = [self new];
        // TODO:configs
    });
    return _logger;
}

- (void)log:(NSString *)message
{
    printf("%s", [message UTF8String]);
}

@end
