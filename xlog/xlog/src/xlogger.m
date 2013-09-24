

#import "xlogger.h"

@implementation xlogger


+ (instancetype)shared
{
    static xlogger* _logger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _logger = [self new];
    });
    return _logger;
}

- (void)log:(NSString *)message
{
    printf("%s\n", [message UTF8String]);
}

- (id)init
{
    self = [super init];
    if (self)
    {
        NSArray* args = [[NSProcessInfo processInfo] arguments];
        NSMutableArray* owners = [NSMutableArray array];
        for (NSString* arg in args)
        {
            if ([arg hasPrefix:@"xlog."])
            {
                NSString* owner = [arg substringFromIndex:5]; // remove "xlog."
                [owners addObject:owner];
            }
        }
        
        NSLog(@"%@", owners);
        
        // TODO: config
    }
    return self;
}

@end
