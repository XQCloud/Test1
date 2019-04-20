//
//  HTCountDownTimerTool.h
//  HantuCarHouse
//
//  Created by Usopp on 2019/4/18.
//  Copyright © 2019 HanTu. All rights reserved.
//  倒计时工具

#import <Foundation/Foundation.h>
@class HTCountDownTimerTool;

NS_ASSUME_NONNULL_BEGIN
@protocol HTCountDownTimerDelegate <NSObject>

- (void)countDownTimer:(HTCountDownTimerTool *)tool currentValue:(NSInteger)value;

@end

@interface HTCountDownTimerTool : NSObject

@property(nonatomic,weak) id<HTCountDownTimerDelegate> delegate;

- (void)startTimer;

- (void)endTimer;
@end

NS_ASSUME_NONNULL_END
