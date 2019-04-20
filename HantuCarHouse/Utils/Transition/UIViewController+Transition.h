//
//  UIViewController+Transition.h
//
//  Created by Usopp on 2019/4/16.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTransitionManager.h"

@interface UIViewController (Transition)<UIViewControllerTransitioningDelegate>

@property(nonatomic, copy) id<UIViewControllerAnimatedTransitioning> presentAnimation; // present动画代理
@property(nonatomic, copy) id<UIViewControllerAnimatedTransitioning> dismissAnimation; // dismiss动画代理
@property(nonatomic, copy) UIPercentDrivenInteractiveTransition *swipeInteractiveTransition; // 交互动画代理

/**
 返回RootVC
 */
- (void)xsg_backToRootControllerAnimated:(BOOL)animated;

/**
 返回前一个VC
 */
- (void)xsg_backToBeforeController;

/**
 pushVC

 @param vc VC
 @param animated 是否动画
 */
- (void)xsg_pushViewController:(UIViewController *)vc
                      animated:(BOOL)animated;

/**
 popVC

 @param animated 是否动画
 */
- (void)xsg_popViewControllerAnimated:(BOOL)animated;

/**
 dismissVC

 @param animated 是否动画
 */
- (void)xsg_dismissViewControllerAnimated:(BOOL)animated;

/**
 模态显示VC
 
 @param vc VC
 @param animated 是否动画
 */
- (void)xsg_presentViewController:(UIViewController *)vc
                         animated:(BOOL)animated;

/**
 模态显示VC

 @param vc VC
 @param animated 是否动画
 @param options 转场配置
 */
- (void)xsg_presentViewController:(UIViewController *)vc
                         animated:(BOOL)animated
                          options:(XSGTransitionOption)options;

/**
 pushVC

 @param vc VC
 @param animated 是否动画
 @param options 转场配置
 */
- (void)xsg_pushViewController:(UIViewController *)vc
                      animated:(BOOL)animated
                       options:(XSGTransitionOption)options;

@end
