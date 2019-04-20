//
//  HTMainViewController.m
//  HantuCarHouse
//
//  Created by Usopp on 2019/4/16.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import "HTMainViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "HTLoginViewController.h"
//#import "UINavigationItem+BarButtonItem.h"

@interface HTMainViewController ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *scrollView;

@end

@implementation HTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor redColor]}; // title颜色
    self.navigationItem.title = @"首页";
    
//    [self.navigationItem xsg_addBackToBeforeBarButtonItem];
    
    // 轮播
    [self setUpAdsView];
}

- (void)setUpAdsView {
    self.scrollView.delegate = self;
    self.scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.scrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    // 网络图片
    self.scrollView.imageURLStringsGroup = @[@"https://f12.baidu.com/it/u=1726006228,3853083553&fm=72",@"https://f10.baidu.com/it/u=1512992334,3113031907&fm=72",@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=355100691,2204805346&fm=26&gp=0.jpg",@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=251812955,848951648&fm=26&gp=0.jpg"];
}

#pragma mark - SDCycleScrollView
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
}

#pragma mark - Action
- (IBAction)searchAction:(id)sender {
    // 登录测试
    HTLoginViewController *loginVC = [[HTLoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}
@end
