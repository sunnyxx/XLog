//
//  XLogMacros.h
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

#import "XLogger.h"

// Basic macro
#ifdef DEBUG
    #define XLogBase(_owner, _level, _format, ...) \
        [[XLogger defaultLogger] logWithOwner:(_owner) \
                                        level:(_level) \
                                         file:[NSString stringWithUTF8String:__FILE__] \
                                     function:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
                                         line:__LINE__ \
                                       format:(_format), ##__VA_ARGS__]
#else
    #define XLogBase(owner, format...) do{}while(0)
#endif

// Anonymous build-in log
#define XLog(format...)     XLogBase(nil, XInfoLevel, format)
#define XWarning(format...) XLogBase(nil, XWarningLevel, format)
#define XError(format...)   XLogBase(nil, XErrorLevel, format)