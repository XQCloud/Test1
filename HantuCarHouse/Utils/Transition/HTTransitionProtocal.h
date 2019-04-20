//
//  HTTransitionProtocal.h
//
//  Created by Usopp on 2019/4/16.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol HTTransitionProtocal<NSObject>

@required

/**
 返回RootVC
 */
- (void)backToRootControllerAnimated:(BOOL)animated;

/**
 返回前一个VC
 */
- (void)backToBeforeController;

/**
 返回指定VC
 
 @param vcClass VC类
 */
- (void)backToViewControllerWithClass:(Class)vcClass;

/**
 查找指定VC（返回结果集中最后一个VC）
 
 @param vcClass VC类
 */
- (UIViewController *)findViewControllerWithClass:(Class)vcClass;

/**
 查找指定VC集合
 
 @param vcClass VC类
 */
- (NSArray<UIViewController *> *)findViewControllersWithClass:(Class)vcClass;

/**
 popVC
 
 @param animated 是否动画
 */
- (void)popViewControllerAnimated:(BOOL)animated;

/**
 dismissVC
 
 @param animated 是否动画
 */
- (void)dismissViewControllerAnimated:(BOOL)animated;

/**
 模态显示VC

 @param vc VC
 @param wrapNav 是否包装Nav
 @param animated 是否动画
 */
- (void)presentViewController:(UIViewController *)vc
                      wrapNav:(BOOL)wrapNav
                     animated:(BOOL)animated;

/**
 pushVC

 @param vc VC
 @param animated 是否动画
 */
- (void)pushViewController:(UIViewController *)vc
                  animated:(BOOL)animated;

@end
