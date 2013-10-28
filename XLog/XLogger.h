//
//  XLogger.h
//  XLog
//
//  Created by Sunny Sun on 18/10/13.
//  Copyright (c) 2013 Sunny Sun. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions
//  are met:
//  1. Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//  3. The name of the author may not be used to endorse or promote products
//  derived from this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
//  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
//  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
//  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
//  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
//  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
//  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
//  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "XLoggerConfigurable.h"

@interface XLogger : NSObject
/**
 * Get a default logger
 * @return Singleton of XLogger
 */
+ (instancetype)defaultLogger;

/**
 * This is where format and arguments parsed, assembled and printed.
 *
 * @param owner: A owner name of whom calls this log.
 * @param level: A bit mask stands for this log's level.
 * @param file: File path of where this log is called.
 * @param function: Function name of where this log is called.
 * @param line: Line number of where this log is called.
 * @param format,...: Format string and arg list
 */
- (void)logWithOwner:(NSString *)owner
               level:(XLogLevel)level
                file:(NSString *)file
            function:(NSString *)function
                line:(NSUInteger)line
              format:(NSString *)format, ...;

/**
 * Delegate for configuring.
 * @discussion As in general, logger's configuration will not be changed runtime, 
 *             so use a static class delegate will do.
 */
@property (nonatomic, weak) Class<XLoggerDelegate> delegate;

/**
 * Bits mask of current level
 * @discussion This property is effective only if logger's delegate is not available.
 * Usage:[[XLogger defaultLogger] setLevel:XWarningLevel | XErrorLevel];
 */
@property (nonatomic) XLogLevel level;

/**
 * Register a formatter class that confirm <XLoggerFormatter> protocol to logger.
 *
 * @discussion As logger's delegate, use a class.
 */
- (void)registerFormatterClass:(Class<XLoggerFormatter>)formatterClass;

@end
