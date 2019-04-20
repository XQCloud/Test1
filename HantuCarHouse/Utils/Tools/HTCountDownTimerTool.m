//
//  HTCountDownTimerTool.m
//  HantuCarHouse
//
//  Created by Usopp on 2019/4/18.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import "HTCountDownTimerTool.h"
#import "HTWeakTimer.h"
@interface HTCountDownTimerTool()

@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)NSInteger count;

@end

@implementation HTCountDownTimerTool

- (void)dealloc
{
    [self endTimer];
}

- (instancetype)init
{
    if (self = [super init]) {
        [self initData];
    }
    return self;
}

- (void)initData {
    self.count = 59;
}

- (void)startTimer
{
    [self initData];
    kWeakSelf;
    if (!self.timer)
    {
        self.timer = [HTWeakTimer scheduledTimerWithTimeInterval:1.0 block:^(id userInfo) {
            
            if (weakSelf.count > 1)
            {
                weakSelf.count--;
            }
            else
            {
                [weakSelf endTimer];
            }
            
            if (weakSelf.delegate) {
                [weakSelf.delegate countDownTimer:weakSelf currentValue:weakSelf.count];
            }
            
        } userInfo:nil repeats:YES];
        
        if (weakSelf.delegate) {
            [weakSelf.delegate countDownTimer:weakSelf currentValue:weakSelf.count];
        }
    }
}

- (void)endTimer
{
    [self.timer invalidate];
    self.timer = nil;
    self.count = 0;
    if (self.delegate) {
        [self.delegate countDownTimer:self currentValue:self.count];
    }
}

@end
