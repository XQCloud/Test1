//
//  HTWeakTimer.h
//  HantuCarHouse
//
//  Created by Usopp on 2019/4/18.
//  Copyright © 2019 HanTu. All rights reserved.
//  定时器

#import <Foundation/Foundation.h>
typedef void (^HTTimerHandler)(id userInfo);

NS_ASSUME_NONNULL_BEGIN

@interface HTWeakTimer : NSObject
+ (NSTimer *) scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                    userInfo:(id)userInfo
                                     repeats:(BOOL)repeats;

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(HTTimerHandler)block
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats;
@end

NS_ASSUME_NONNULL_END
