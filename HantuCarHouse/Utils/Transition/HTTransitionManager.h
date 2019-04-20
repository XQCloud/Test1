//
//  HTTransitionManager.h
//
//  Created by Usopp on 2019/4/16.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTransitionProtocal.h"
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, XSGTransitionOption) {
    XSGTransitionOptionSwipeTrasition = 1 << 0,  // 允许手势转场
    XSGTransitionOptionWrapNav        = 1 << 1,  // 需要包装nav
};

@interface HTTransitionManager : NSObject

@property(nonatomic , weak) UIViewController<HTTransitionProtocal> *rootViewController;

+ (HTTransitionManager *)shareManager;

/**
 配置RootVC

 @param rootViewController RootVC
 */
- (void)configRootViewController:(UIViewController<HTTransitionProtocal> *)rootViewController;

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
 查找指定VC集合
 
 @param vcClass VC类
 @return VC集合
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
 @param animated 是否动画
 */
- (void)presentViewController:(UIViewController *)vc
                     animated:(BOOL)animated;

/**
 pushVC

 @param vc VC
 @param animated 是否动画
 */
- (void)pushViewController:(UIViewController *)vc
                  animated:(BOOL)animated;

@end
