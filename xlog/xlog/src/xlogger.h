

#define sy(statements) \
[xlogger setOwner:@"123"];\
statements
\

@interface xlogger : NSObject

+ (void)setOwner:(NSString *)owner;
+ (void)log:(NSString *)message;


@end
