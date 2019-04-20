//
//  NaviBarView.h
//  HantuCarHouse
//
//  Created by Usopp on 2019/4/18.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseViewController;

NS_ASSUME_NONNULL_BEGIN

#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define NavBarHeight 44
#define NavHeight (StatusBarHeight + NavBarHeight)

/**
 导航条
 */
@interface NaviBarView : UIView

@property (retain, nonatomic) UIView *statusBar;    // 状态栏
@property (retain, nonatomic) UIView *navigationBar;    // 导航条
@property (retain, nonatomic) UIButton *rightWishBtn;   // 右侧分享按钮
@property (retain, nonatomic) UIButton *leftMenuBtn;    // 左侧菜单栏
@property (retain, nonatomic) UIButton *backBtn;    // 返回按钮
@property (retain, nonatomic) UILabel *titleLabel;  // 标题
@property(nonatomic, strong)UIView *lineView;   // 底部分割线

- (instancetype)initWithController:(BaseViewController *)controller;

// 扫码和心愿单
- (void)addScanAndWishList;
// 添加返回按钮
- (void)addBackBtn;
// 添加底部分割线
- (void)addBottomSepLine;
// 设置标题
- (void)setNavigationTitle:(NSString *)title;
// 设置导航条透明
- (void)clearNavBarBackgroundColor;

// 右侧添加按钮
- (UILabel *)addRightMenu:(NSString *)actionName withAction:(SEL)action;

@end

NS_ASSUME_NONNULL_END
