//
//  BaseViewController.h
//  HantuCarHouse
//
//  Created by Usopp on 2019/4/18.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NaviBarView.h"

NS_ASSUME_NONNULL_BEGIN

/**
 基类
 */
@interface BaseViewController : UIViewController

#pragma mark - 导航条相关
@property(nonatomic, copy)NSString *naviTitle;  // 标题
/** 导航条 */
@property(nonatomic, strong)NaviBarView *topNavBar;
/** 内容视图 */
@property (strong, nonatomic) UIView *containerView;

// 返回按钮点击操作
- (void)doBackPrev;
// 扫码和心愿单
- (void)addScanAndWishList;
// 设置导航条透明
- (void)clearNavBarBackgroundColor;

// 添加按钮
- (UIButton *)addBtnWithTitle:(NSString *)title action:(SEL)action;

- (UILabel *)addRightMenu:(NSString *)actionName withAction:(SEL)action;

@end

NS_ASSUME_NONNULL_END
