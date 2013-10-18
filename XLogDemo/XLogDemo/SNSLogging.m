//
//  SNSLogging.m
//  xlog
//
//  Created by Sunny on 13-10-18.
//
//

#import "SNSLogging.h"

@implementation SNSLoggingDelegate

static SNSLoggingDelegate* singleton = nil;
static NSDictionary* configDict = nil;

+ (void)load
{
    // delegate
    singleton = [self new];
    [XLogger defaultLogger].delegate = singleton;
    
    // plist
    NSString* path = [[NSBundle mainBundle] pathForResource:@"SNSLogging.plist" ofType:nil];
    configDict = [NSDictionary dictionaryWithContentsOfFile:path];
    if (!configDict)
    {
        XLog(@"SNSLoggingDelegate: config plist(%@) not found", path);
    }
}

#pragma mark - XLogger delegate

- (BOOL)XLogger:(XLogger *)logger shouldShowOwner:(NSString *)owner level:(XLogLevel)level
{
    NSDictionary* showDict = configDict[@"Owner"];
    XLogLevel showBits = [showDict[owner] unsignedIntegerValue];
    XLogLevel allBits = [showDict[XLoggerOwnerKeyAll] unsignedIntegerValue];
    return (showBits & level) || (allBits & level);
}

- (BOOL)XLogger:(XLogger *)logger shouldShowComponent:(NSString *)componentKey
{
    return [configDict[@"Setting"][componentKey] boolValue];
}

- (NSString *)XLogger:(XLogger *)logger titleForLevel:(XLogLevel)level
{
    if (level & XInfoLevel)
    {
        return configDict[@"Setting"][@"InfoTitle"];
    }
    else if (level & XWarningLevel)
    {
        return configDict[@"Setting"][@"WarningTitle"];
    }
    else if (level & XErrorLevel)
    {
        return configDict[@"Setting"][@"ErrorTitle"];
    }
    return nil;
}


@end
