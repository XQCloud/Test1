//
//  HTTransitionManager.m
//
//  Created by Usopp on 2019/4/16.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import "HTTransitionManager.h"

@interface HTTransitionManager ()



@end

@implementation HTTransitionManager

+ (HTTransitionManager *)shareManager
{
    static dispatch_once_t onceToken;
    static HTTransitionManager *instance = nil;
    
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    
    return instance;
}

- (void)configRootViewController:(UIViewController<HTTransitionProtocal> *)rootViewController
{
    if ([rootViewController isKindOfClass:[UIViewController class]] &&
        [[rootViewController class] conformsToProtocol:@protocol(HTTransitionProtocal)]) {
        self.rootViewController = rootViewController;
    }
    else {
        self.rootViewController = nil;
    }
}

- (void)backToRootControllerAnimated:(BOOL)animated
{
    if (self.rootViewController && [self.rootViewController respondsToSelector:@selector(backToRootControllerAnimated:)]) {
        [self.rootViewController backToRootControllerAnimated:animated];
    }
}

- (void)backToBeforeController
{
    if (self.rootViewController && [self.rootViewController respondsToSelector:@selector(backToBeforeController)]) {
        [self.rootViewController backToBeforeController];
    }
}

- (void)backToViewControllerWithClass:(Class)vcClass
{
    if (self.rootViewController && [self.rootViewController respondsToSelector:@selector(backToViewControllerWithClass:)]) {
        [self.rootViewController backToViewControllerWithClass:vcClass];
    }
}

- (NSArray<UIViewController *> *)findViewControllersWithClass:(Class)vcClass
{
    if (self.rootViewController && [self.rootViewController respondsToSelector:@selector(findViewControllersWithClass:)]) {
        return [self.rootViewController findViewControllersWithClass:vcClass];
    }
    return nil;
}

- (void)popViewControllerAnimated:(BOOL)animated
{
    if (self.rootViewController && [self.rootViewController respondsToSelector:@selector(popViewControllerAnimated:)]) {
        [self.rootViewController popViewControllerAnimated:animated];
    }
}

- (void)dismissViewControllerAnimated:(BOOL)animated
{
    if (self.rootViewController && [self.rootViewController respondsToSelector:@selector(dismissViewControllerAnimated:)]) {
        [self.rootViewController dismissViewControllerAnimated:animated];
    }
}

- (void)presentViewController:(UIViewController *)vc
                     animated:(BOOL)animated
{
    if (self.rootViewController && [self.rootViewController respondsToSelector:@selector(presentViewController:wrapNav:animated:)]) {
        [self.rootViewController presentViewController:vc
                                               wrapNav:NO
                                              animated:animated];
    }
}

- (void)pushViewController:(UIViewController *)vc
                  animated:(BOOL)animated
{
    if (self.rootViewController && [self.rootViewController respondsToSelector:@selector(pushViewController:animated:)]) {
        [self.rootViewController pushViewController:vc
                                           animated:animated];
    }
    
}

- (UIViewController *)findVCWithClass:(Class)class FromVC:(UIViewController *)vc
{
    if (!vc || !class) return nil;
    
    if ([vc isKindOfClass:class]) {
        return vc;
    }
    else if ([vc isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)vc viewControllers] count] > 0) {
        UINavigationController *nav = (UINavigationController *)vc;
        if ([[nav viewControllers] count] > 0) {
            if ([[[nav viewControllers] firstObject] isKindOfClass:class]) {
                return [[nav viewControllers] firstObject];
            }
        }
    }
    
    return nil;
}

@end
