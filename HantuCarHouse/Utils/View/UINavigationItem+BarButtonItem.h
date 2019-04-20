//
//  UINavigationItem+BarButtonItem.h
//  SuYunTong
//
//  Created by sfit0194 on 15/9/23.
//  Copyright (c) 2015年 顺丰科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (BarButtonItem)

/**
 添加LeftBarButtonItem
 
 @param target target
 @param action 方法
 */
- (void)xsg_addLeftBarButtonItemWithTarget:(id)target action:(SEL)action;

/**
 添加LeftBarButtonItem

 @param target target
 @param action 方法
 @param imageName 自定义icon名称
 */
- (void)xsg_addLeftBarButtonItemWithTarget:(id)target action:(SEL)action imageName:(NSString *)imageName;

/**
 添加LeftBarButtonItem

 @param title 标题
 @param target target
 @param action 方法
 */
- (void)xsg_addLeftBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
 添加返回上一页BarButtonItem
 */
- (void)xsg_addBackToBeforeBarButtonItem;

/**
 添加返回根视图BarButtonItem
 */
- (void)xsg_addBackToRootBarButtonItem;

/**
 添加返回上一页BarButtonItem

 @param title 标题
 */
- (void)xsg_addBackToBeforeBarButtonItemWithTitle:(NSString *)title;

/**
 添加返回根视图BarButtonItem

 @param title 标题
 */
- (void)xsg_addBackToRootBarButtonItemWithTitle:(NSString *)title;

/**
 添加返回BarButtonItem

 @param target target
 @param action 方法
 */
- (void)xsg_addBackButtonItemWithTarget:(id)target action:(SEL)action;

/**
 添加RightBarButtonItem + 默认黑色
 
 @param title 标题
 @param target target
 @param action 方法
 */
- (void)xsg_addRightBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
 添加RightBarButtonItem
 
 @param title 标题
 @param target target
 @param action 方法
 @param textColor 位子颜色
 */
- (void)xsg_addRightBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action textColor:(UIColor *)textColor;

/**
 添加RightBarButtonItem + 自定义颜色
 
 @param title 标题
 @param titleColor 标题颜色
 @param target target
 @param action 方法
 */
- (void)xsg_addRightBarButtonItemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;
/**
 修改RightBarButtonItem + 自定义颜色
 
 @param title 标题
 @param titleColor 标题颜色
 @param tapEnable 是否可以点击
 */
- (void)xsg_updateRightBarButtonItemStatusWithTitle:(NSString *)title titleColor:(UIColor *)titleColor tapEnable:(BOOL)tapEnable;
/**
 添加RightBarButtonItem

 @param target target
 @param action 方法
 @param imageName 自定义icon名称
 */
- (void)xsg_addRightBarButtonItemWithTarget:(id)target action:(SEL)action imageName:(NSString *)imageName;

/**
 使用图片设置TitleView

 @param imageName 图片名
 */
- (void)xsg_setTitleViewWithImageName:(NSString *)imageName;

/**
 设置TitleView

 @param view view
 */
- (void)xsg_setTitleView:(UIView *)view;

@end
