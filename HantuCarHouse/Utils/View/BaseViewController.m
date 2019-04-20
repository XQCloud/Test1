//
//  BaseViewController.m
//  HantuCarHouse
//
//  Created by Usopp on 2019/4/18.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // setup data
    self.view.backgroundColor = [UIColor whiteColor];
    // 所有界面隐藏导航栏,用自定义的导航栏代替
//    self.fd_prefersNavigationBarHidden = YES;
//    // drawUI
//    [self drawTopNaviBar];
}

@end
