//
//  HTHomeNavigationViewController.m
//  HantuCarHouse
//
//  Created by Usopp on 2019/4/16.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import "HTHomeNavigationViewController.h"

@interface HTHomeNavigationViewController ()

@end

@implementation HTHomeNavigationViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationBarHidden = YES;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        HTLoadNibView(self);
        [self viewDidLoad];
    }
    return self;
}

@end
