//
//  NaviBarView.m
//  HantuCarHouse
//
//  Created by Usopp on 2019/4/18.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import "NaviBarView.h"

#define TagRightMenu -300   // 右侧菜单栏
#define TagRightImg -301  // 右侧图片
#define TagLeftClose -302 // 左边关闭按钮
#define TagBackBtn -303   // 左侧返回按钮
#define TagClose -304 // 关闭按钮
#define kTagLine -22    // 底部线条

@implementation NaviBarView {
    __weak BaseViewController *_controller;
    UIView *_statusBar;
    UIView *_navigationBar;
    UIView *_titleView;
    UIButton *_rightWishBtn;
    UIView *_rightMenuView;
    UIButton *_leftMenuBtn;
    UIButton *_leftScanQRCode;  // 左侧二维码扫码
    UIView *_searchBarView;
    UIView *_lineView;
    UIButton *_backBtn;
    UIButton *_closeBtn;
}

// 初始化
- (instancetype)initWithController:(BaseViewController *)controller {
    _controller = controller;
    
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavHeight)];
    self.backgroundColor = [UIColor clearColor];
    self.layer.zPosition = 999999;
    
    // 最顶部的状态栏
    _statusBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, StatusBarHeight)];
    _statusBar.backgroundColor = [UIColor whiteColor];
    [self addSubview:_statusBar];
    
    _navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, SCREEN_WIDTH, NavBarHeight)];
    _navigationBar.backgroundColor = [UIColor whiteColor];
    [self addSubview:_navigationBar];
    
    return self;
}
//// 返回按钮
//- (void)addBackBtn {
//    // 不能添加多个
//    UIView *srcBack = [_navigationBar viewWithTag:TagBackBtn];
//    if (srcBack)
//        return;
//
//    UIImage *background = [[UIImage imageNamed:@"nav_back_black"] ifRTLThenOrientationUpMirrored];
//    UIImage *backgroundOn = [[UIImage imageNamed:@"nav_back_black"] ifRTLThenOrientationUpMirrored];
//
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setAccessibilityIdentifier:@"TopBackBtn"];
//    button.tag = TagBackBtn;
//    [button onTap:self action:@selector(doBackPrev)];
//
//    [button setImage:background forState:UIControlStateNormal];
//    [button setImage:backgroundOn forState:UIControlStateHighlighted];
//
//    button.frame = CGRectMake(0, 0, 60, 44);
//    button.contentEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 20);
//    [_navigationBar addSubview:button];
//    [button rtlToParent];
//    _backBtn = button;
//}

//// 添加顶部右边的文字类的按钮
//- (UILabel *)addRightMenu:(NSString *)actionName withAction:(SEL)action {
//
//    // 当重复添加时,移除旧的按钮
//    UILabel *srcLabel = (UILabel *)[_navigationBar viewWithTag:TagRightMenu];
//    if (srcLabel) {
//        [srcLabel removeFromSuperview];
//    }
//
//    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - 110, 0, 100, 44)];
//    lb.backgroundColor = [UIColor clearColor];
//    lb.font = [UIFont systemFontOfSize:16];
//    lb.textColor = [UIColor blackColor];
//    lb.text = actionName;
//    lb.userInteractionEnabled = YES;
//    lb.textAlignment = NSTextAlignmentRight;
//    lb.tag = TagRightMenu;
//    [lb onTap:_controller action:action];
//    [_navigationBar addSubview:lb];
//    [lb rtlToParent];
//    _rightMenuView = lb;
//    return lb;
//}
//#pragma mark - set
//
//- (void)clearNavBarBackgroundColor {
//    _statusBar.backgroundColor = [UIColor clearColor];
//    _navigationBar.backgroundColor = [UIColor clearColor];
//    _titleLabel.textColor = [UIColor whiteColor];
//    [_navigationBar removeChildByTag:kTagLine];
//}

- (void)setNavigationTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setBackImage:(NSString *)imageName {
    UIImage *background = [UIImage imageNamed:imageName];
    UIImage *backgroundOn = [UIImage imageNamed:imageName];
    [_backBtn setImage:background forState:UIControlStateNormal];
    [_backBtn setImage:backgroundOn forState:UIControlStateHighlighted];
}

@end
