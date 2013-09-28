

#import <Foundation/Foundation.h>

@interface xlogger : NSObject

+ (instancetype)shared;

- (void)log:(NSString *)message;

@end
