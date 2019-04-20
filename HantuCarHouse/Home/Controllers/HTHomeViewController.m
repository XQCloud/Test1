//
//  HTHomeViewController.m
//
//  Created by Usopp on 2019/4/16.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import "HTHomeViewController.h"
#import "HTCenterTabBar.h"
#import "HTMainViewController.h"
#import "HTPurchaseViewController.h"
#import "HTPriceCheckViewController.h"
#import "HTMineViewController.h"


@interface HTHomeViewController ()<UITabBarControllerDelegate,HTCenterTabBarDelegate>

@end

@implementation HTHomeViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    
    [self loadViews];
    [self registerNotifications];
}
- (void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:XSGLoginSuccessNotification object:nil];
}

- (void)registerNotifications
{
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(checkVersionUpdate)
//                                                 name:XSGLoginSuccessNotification
//                                               object:nil];
}

- (void)loadViews
{
    // 添加子控制器
    [self addChildViewController:[[HTMainViewController alloc] init] title:@"首页" image:@"tab0" selectedImage:@"tab0_selected"];
    [self addChildViewController:[[HTPurchaseViewController alloc] init] title:@"精准采购" image:@"tab1" selectedImage:@"tab1_selected"];
    [self addChildViewController:[[HTPriceCheckViewController alloc] init] title:@"询价单" image:@"tab3" selectedImage:@"tab3_selected"];
    [self addChildViewController:[[HTMineViewController alloc] init] title:@"我的" image:@"tab4" selectedImage:@"tab4_selected"];
    
    //改变颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kTextColor_S02}
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kTextColor_S01}
                                             forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    //移除TabBar顶部边线
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    
    HTCenterTabBar *tabBar = [[HTCenterTabBar alloc] init];
    //取消tabBar的透明效果
    tabBar.translucent = NO;
    tabBar.layer.zPosition = 1;
    tabBar.centerTabBarDelegate = self;
    // KVC：如果要修系统的某些属性，但被设为readOnly，就是用KVC，即setValue：forKey：。
    [self setValue:tabBar forKey:@"tabBar"];
}

/*
 *  加入子控制器
 */
- (void)addChildViewController:(UIViewController *)childVc
                         title:(NSString *)title
                         image:(NSString *)image
                 selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.title = title;
    
    // 设置子控制器的tabBarItem图片
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 禁用图片渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 为子控制器包装导航控制器
    //    UINavigationController *navigationVc = [[UINavigationController alloc] initWithRootViewController:childVc];
    // 添加子控制器
    [self addChildViewController:childVc];
}

#pragma mark - XSGLogoutCompleteNotification

- (void)handleLogoutCompleteNotification:(NSNotification *)notification
{
    self.selectedIndex = 0;
}

- (void)tabBarDidClickCenterButton:(HTCenterTabBar *)tabBar
{
    NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:5];
}



#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}


#pragma mark - XSGTransitionProtocal

- (void)fixCallDelay
{
    CFRunLoopWakeUp(CFRunLoopGetCurrent());
}

- (UIViewController *)containerVC
{
    // 自身为容器VC
    if ([self isKindOfClass:[UINavigationController class]] && self.tabBarController) {
        // Tab 套 Nav 返回 Tab
        return self.tabBarController;
    }
    else if ([self isKindOfClass:[UITabBarController class]] && self.navigationController) {
        // Nav 套 Tab 返回 Nav
        return self.navigationController;
    }
    // 自身为非容器VC
    else if ([self isKindOfClass:[UIViewController class]]) {
        if (self.navigationController && self.tabBarController) {
            for (UIViewController *subVC in self.navigationController.viewControllers) {
                if (subVC == self.tabBarController) {
                    return self.navigationController;
                }
            }
            return self.tabBarController;
        }
        else if (self.navigationController) {
            return self.navigationController;
        }
        else if (self.tabBarController) {
            return self.tabBarController;
        }
    }
    
    return self;
}

- (void)backToRootControllerAnimated:(BOOL)animated
{
    [self dismissViewControllerAnimated:animated completion:nil];
    
    if (!self.navigationController) {
        [self.navigationController popToRootViewControllerAnimated:animated];
    }
}

- (void)backToBeforeController
{
    //presenteVC只可能是容器VC或普通VC
    UIViewController *presented= [self containerVC];
    while (presented) {
        if (presented.presentedViewController && !presented.presentedViewController.isBeingDismissed) {
            presented = presented.presentedViewController;
        }
        else {
            break;
        }
    }
    
    if (presented == self) {
        //仅判断最近一层是否为Nav
        if ([presented isKindOfClass:[UINavigationController class]]) {
            if ([[(UINavigationController *)presented viewControllers] count] > 1) {
                [(UINavigationController *)presented popViewControllerAnimated:YES];
            }
        }
        else if ([presented isKindOfClass:[UITabBarController class]]) {
            if ([[(UITabBarController *)presented viewControllers] count] > 1) {
                UIViewController *selectedVC = [(UITabBarController *)presented selectedViewController];
                if ([selectedVC isKindOfClass:[UINavigationController class]]) {
                    if ([[(UINavigationController *)selectedVC viewControllers] count] > 1) {
                        [(UINavigationController *)selectedVC popViewControllerAnimated:YES];
                    }
                }
            }
        }
        return ;
    }
    
    if ([presented isKindOfClass:[UINavigationController class]]) {
        if ([((UINavigationController *)presented).viewControllers count] > 1) {
            [((UINavigationController *)presented) popViewControllerAnimated:YES];
        }
        else {
            [((UINavigationController *)presented) dismissViewControllerAnimated:YES completion:nil];
        }
    }
    else if ([presented isKindOfClass:[UITabBarController class]]) {
        if ([[(UITabBarController *)presented viewControllers] count] > 1) {
            UIViewController *selectedVC = [(UITabBarController *)presented selectedViewController];
            if ([selectedVC isKindOfClass:[UINavigationController class]]) {
                if ([[(UINavigationController *)selectedVC viewControllers] count] > 1) {
                    [(UINavigationController *)selectedVC popViewControllerAnimated:YES];
                }
            }
        }
    }
    else {
        [presented dismissViewControllerAnimated:YES completion:nil];
    }
    
    [self fixCallDelay];
}

- (void)backToViewControllerWithClass:(Class)vcClass
{
    if (!vcClass) {
        return;
    }
    
    UIViewController *tagetVC = [self findViewControllerWithClass:vcClass];
    
    if (!tagetVC) return ;
    
    //自身为容器VC
    if ([tagetVC isKindOfClass:[UINavigationController class]]) {
        if ((UINavigationController *)tagetVC.presentedViewController) {
            [(UINavigationController *)tagetVC.presentedViewController dismissViewControllerAnimated:YES
                                                                                          completion:nil];
        }
    }
    else if ([tagetVC isKindOfClass:[UITabBarController class]]) {
        if ((UITabBarController *)tagetVC.presentedViewController) {
            [(UITabBarController *)tagetVC.presentedViewController dismissViewControllerAnimated:YES
                                                                                      completion:nil];
        }
    }
    //自身为非容器VC
    else if (tagetVC.navigationController && tagetVC.tabBarController) {
        UIViewController *vc = nil;
        for (UIViewController *subVC in tagetVC.navigationController.viewControllers) {
            if (subVC == tagetVC.tabBarController) {
                vc = tagetVC.navigationController;
                break;
            }
        }
        if (!vc) {
            for (UIViewController *subVC in tagetVC.tabBarController.viewControllers) {
                if (subVC == tagetVC.navigationController) {
                    vc = tagetVC.tabBarController;
                    break;
                }
            }
        }
        
        if (!vc) {
            return;
        }
        
        if (vc.presentedViewController) {
            [vc dismissViewControllerAnimated:YES completion:nil];
        }
        
        if (vc == tagetVC.navigationController) {
            if ([[tagetVC.navigationController viewControllers] count] > 1) {
                [tagetVC.navigationController popToViewController:tagetVC.tabBarController
                                                         animated:YES];
            }
            [tagetVC.tabBarController setSelectedViewController:tagetVC];
        }
        else if (vc == tagetVC.tabBarController) {
            [tagetVC.tabBarController setSelectedViewController:tagetVC.navigationController];
        }
    }
    else if (tagetVC.navigationController) {
        //nav sub vc
        if (tagetVC.navigationController.presentedViewController) {
            [tagetVC.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
        
        if ([tagetVC.navigationController.viewControllers count] > 1) {
            [tagetVC.navigationController popToViewController:tagetVC
                                                     animated:YES];
        }
    }
    else if (tagetVC.tabBarController) {
        if (tagetVC.tabBarController.presentedViewController) {
            [tagetVC.tabBarController dismissViewControllerAnimated:YES completion:nil];
        }
        [tagetVC.tabBarController setSelectedViewController:tagetVC];
    }
    else {
        if (tagetVC.presentedViewController) {
            [tagetVC dismissViewControllerAnimated:YES completion:nil];
        }
    }
    
    [self fixCallDelay];
}

- (UIViewController *)findViewControllerWithClass:(Class)vcClass
{
    if (!vcClass) {
        return nil;
    }
    
    UIViewController *presented= [self containerVC];
    UIViewController *tagetVC = nil;
    
    do {
        if ([presented isKindOfClass:vcClass]) {
            tagetVC = presented;
        }
        else if ([presented isKindOfClass:[UINavigationController class]]) {
            //nav vc
            for (UIViewController *vc in [(UINavigationController *)presented viewControllers]) {
                if ([vc isKindOfClass:[UITabBarController class]]) {
                    for (UIViewController *subVC in [(UITabBarController *)vc viewControllers]) {
                        if ([subVC isKindOfClass:[UINavigationController class]]) {
                            //根视图结构非法 nav - tab - nav
                        }
                        else if ([subVC isKindOfClass:[UIViewController class]]) {
                            if ([subVC isKindOfClass:vcClass]) {
                                tagetVC = subVC;
                            }
                        }
                    }
                }
                else if ([vc isKindOfClass:vcClass]) {
                    tagetVC = vc;
                }
            }
        } else if ([presented isKindOfClass:[UITabBarController class]]) {
            //tab vc
            for (UIViewController *vc in [(UITabBarController *)presented viewControllers]) {
                //仅判断最近一层是否为Nav
                if ([vc isKindOfClass:[UINavigationController class]]) {
                    for (UIViewController *subVC in [(UINavigationController *)vc viewControllers]) {
                        if ([subVC isKindOfClass:vcClass]) {
                            tagetVC = subVC;
                        }
                    }
                }
                else if ([vc isKindOfClass:[UIViewController class]]) {
                    if ([vc isKindOfClass:vcClass]) {
                        tagetVC = vc;
                    }
                }
                
            }
        } else {
            //other vc
        }
    } while ((presented = presented.presentedViewController));
    
    return tagetVC;
}

- (NSArray<UIViewController *> *)findViewControllersWithClass:(Class)vcClass
{
    if (!vcClass) {
        return nil;
    }
    
    NSMutableArray<UIViewController *> *targetVCs = [NSMutableArray array];
    UIViewController *presented= [self containerVC];
    
    do {
        if ([presented isKindOfClass:vcClass]) {
            [targetVCs addObject:presented];
        }
        else if ([presented isKindOfClass:[UINavigationController class]]) {
            //nav vc
            for (UIViewController *vc in [(UINavigationController *)presented viewControllers]) {
                if ([vc isKindOfClass:[UITabBarController class]]) {
                    for (UIViewController *subVC in [(UITabBarController *)vc viewControllers]) {
                        if ([subVC isKindOfClass:[UINavigationController class]]) {
                            //根视图结构非法 nav - tab - nav
                        }
                        else if ([subVC isKindOfClass:[UIViewController class]]) {
                            if ([subVC isKindOfClass:vcClass]) {
                                [targetVCs addObject:subVC];
                            }
                        }
                    }
                }
                else if ([vc isKindOfClass:vcClass]) {
                    [targetVCs addObject:vc];
                }
            }
        } else if ([presented isKindOfClass:[UITabBarController class]]) {
            //tab vc
            for (UIViewController *vc in [(UITabBarController *)presented viewControllers]) {
                //仅判断最近一层是否为Nav
                if ([vc isKindOfClass:[UINavigationController class]]) {
                    for (UIViewController *subVC in [(UINavigationController *)vc viewControllers]) {
                        if ([subVC isKindOfClass:vcClass]) {
                            [targetVCs addObject:subVC];
                        }
                    }
                }
                else if ([vc isKindOfClass:[UIViewController class]]) {
                    if ([vc isKindOfClass:vcClass]) {
                        [targetVCs addObject:vc];
                    }
                }
                
            }
        } else {
            //other vc
        }
    } while ((presented = presented.presentedViewController));
    
    return targetVCs;
}

- (void)popViewControllerAnimated:(BOOL)animated
{
    UINavigationController *nav = [self findLatestNavigationController];
    
    if (!nav) {
        return;
    }
    
    if ([[nav viewControllers] count] > 1) {
        [nav popViewControllerAnimated:animated];
    }
    
    [self fixCallDelay];
}

- (void)dismissViewControllerAnimated:(BOOL)animated
{
    //presenteVC只可能是容器VC或普通VC
    UIViewController *presented= [self containerVC];
    while (presented) {
        if (presented.presentedViewController && !presented.presentedViewController.isBeingDismissed) {
            presented = presented.presentedViewController;
        }
        else {
            break;
        }
    }
    
    if (presented == self) return;
    
    [presented.presentingViewController dismissViewControllerAnimated:animated
                                                           completion:NULL];
    
    [self fixCallDelay];
}

- (void)presentViewController:(UIViewController *)vc
                      wrapNav:(BOOL)wrapNav
                     animated:(BOOL)animated
{
    if (!vc || ![vc isKindOfClass:[UIViewController class]]) {
        return;
    }
    
    //presenteVC只可能是容器VC或普通VC
    UIViewController *presented= [self containerVC];
    while (presented) {
        if (presented.presentedViewController && !presented.presentedViewController.isBeingDismissed) {
            presented = presented.presentedViewController;
        }
        else {
            break;
        }
    }
    
    UIViewController *presentedVC = nil;
    if (wrapNav) {
        presentedVC = [[UINavigationController alloc] initWithRootViewController:vc];
        [[(UINavigationController *)presentedVC navigationBar] setTranslucent:NO];
    }
    else {
        presentedVC = vc;
    }
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        [((UINavigationController *)vc).navigationBar setTranslucent:NO];
    }
    
    [presented presentViewController:presentedVC
                            animated:animated
                          completion:NULL];
    
    [self fixCallDelay];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)pushViewController:(UIViewController *)vc
                  animated:(BOOL)animated
{
    if (!vc || ![vc isKindOfClass:[UIViewController class]]) {
        return;
    }
    
    UINavigationController *nav = [self findLatestNavigationController];
    
    if (!nav) {
        return;
    }
    
    [[(UINavigationController *)nav navigationBar] setTranslucent:NO];
    
    [(UINavigationController *)nav pushViewController:vc animated:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    
    [self fixCallDelay];
}

- (UINavigationController *)findLatestNavigationController
{
    //presenteVC只可能是容器VC或普通VC
    UIViewController *presented= [self containerVC];
    while (presented) {
        if (presented.presentedViewController && !presented.presentedViewController.isBeingDismissed) {
            presented = presented.presentedViewController;
        }
        else {
            break;
        }
    }
    
    UINavigationController *nav = nil;
    
    if (presented == self) {
        //仅判断最近一层是否为Nav
        if ([presented isKindOfClass:[UINavigationController class]]) {
            nav = (UINavigationController *)presented;
        }
        else if ([presented isKindOfClass:[UITabBarController class]]) {
            if ([[(UITabBarController *)presented viewControllers] count] > 1) {
                UIViewController *selectedVC = [(UITabBarController *)presented selectedViewController];
                if ([selectedVC isKindOfClass:[UINavigationController class]]) {
                    nav = (UINavigationController *)selectedVC;
                }
            }
        }
    }
    else {
        if ([presented isKindOfClass:[UINavigationController class]]) {
            nav = (UINavigationController *)presented;
        }
        else if ([presented isKindOfClass:[UITabBarController class]]) {
            if ([[(UITabBarController *)presented viewControllers] count] > 1) {
                UIViewController *selectedVC = [(UITabBarController *)presented selectedViewController];
                if ([selectedVC isKindOfClass:[UINavigationController class]]) {
                    nav = (UINavigationController *)selectedVC;
                }
            }
        }
    }
    
    return nav;
}
@end
