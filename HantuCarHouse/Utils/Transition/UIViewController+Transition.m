//
//  UIViewController+Transition.m
//
//  Created by Usopp on 2019/4/16.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import "UIViewController+Transition.h"

#import "objc/runtime.h"

#import "HTPresentAnimation.h"
#import "HTDismissAnimation.h"
#import "HTSwipeInteractiveTransition.h"

static char UIViewControllerPresentAnimation;
static char UIViewControllerDismissAnimation;
static char UIViewControllerpercentDrivenTransition;

@implementation UIViewController (Transition)

- (void)xsg_backToRootControllerAnimated:(BOOL)animated
{
    [[HTTransitionManager shareManager] backToRootControllerAnimated:animated];
}

- (void)xsg_backToBeforeController
{
    [[HTTransitionManager shareManager] backToBeforeController];
}

- (void)xsg_pushViewController:(UIViewController *)vc
                      animated:(BOOL)animated
{
    [[HTTransitionManager shareManager] pushViewController:vc
                                                   animated:animated];
}

- (void)xsg_popViewControllerAnimated:(BOOL)animated
{
    [[HTTransitionManager shareManager] popViewControllerAnimated:animated];
}

- (void)xsg_dismissViewControllerAnimated:(BOOL)animated
{
    [[HTTransitionManager shareManager] dismissViewControllerAnimated:animated];
}

- (void)xsg_presentViewController:(UIViewController *)vc
                         animated:(BOOL)animated
{
    [self xsg_presentViewController:vc
                           animated:animated
                            options:0];
}

- (void)xsg_presentViewController:(UIViewController *)vc
                         animated:(BOOL)animated
                          options:(XSGTransitionOption)options
{
    if (!vc) {
        return;
    }
    
    BOOL wrapNav = options & XSGTransitionOptionWrapNav;
    BOOL swipeAnimated = options & XSGTransitionOptionSwipeTrasition;
    
    if (animated) {
        if (!self.presentAnimation) {
            self.presentAnimation = [HTPresentAnimation new];
        }
        
        if (!self.dismissAnimation) {
            self.dismissAnimation = [HTDismissAnimation new];
        }
        
        if (swipeAnimated && !self.swipeInteractiveTransition) {
            self.swipeInteractiveTransition = [HTSwipeInteractiveTransition new];
        }
    }
    
    UIViewController *presentedVC = vc;
    
    if (wrapNav &&
        ![presentedVC isKindOfClass:[UINavigationController class]] &&
        !presentedVC.navigationController) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        if (animated) {
            nav.transitioningDelegate = self;
        }
        
        if (swipeAnimated && self.swipeInteractiveTransition) {
            [(HTSwipeInteractiveTransition *)self.swipeInteractiveTransition setPresentingViewController:vc];
        }
        
        presentedVC = nav;
    }
    else {
        if (animated) {
            vc.transitioningDelegate = self;
        }
        
        if (swipeAnimated && self.swipeInteractiveTransition) {
            [(HTSwipeInteractiveTransition *)self.swipeInteractiveTransition setPresentingViewController:vc];
        }
        
        presentedVC = vc;
    }
    
    [[HTTransitionManager shareManager] presentViewController:presentedVC
                                                      animated:animated];
}

- (void)xsg_pushViewController:(UIViewController *)vc
                      animated:(BOOL)animated
                       options:(XSGTransitionOption)options
{
    [[HTTransitionManager shareManager] pushViewController:vc
                                                   animated:animated];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.presentAnimation;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.dismissAnimation;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.swipeInteractiveTransition && ((HTSwipeInteractiveTransition *)self.swipeInteractiveTransition).interacting ? self.swipeInteractiveTransition : nil;
}

#pragma mark - Accessorise

- (id<UIViewControllerAnimatedTransitioning>)presentAnimation
{
    return objc_getAssociatedObject(self, &UIViewControllerPresentAnimation);
}

- (void)setPresentAnimation:(id<UIViewControllerAnimatedTransitioning>)presentAnimation
{
    objc_setAssociatedObject(self, &UIViewControllerPresentAnimation, presentAnimation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<UIViewControllerAnimatedTransitioning>)dismissAnimation
{
    return objc_getAssociatedObject(self, &UIViewControllerDismissAnimation);
}

- (void)setDismissAnimation:(id<UIViewControllerAnimatedTransitioning>)dismissAnimation
{
    objc_setAssociatedObject(self, &UIViewControllerDismissAnimation, dismissAnimation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIPercentDrivenInteractiveTransition *)swipeInteractiveTransition
{
    return objc_getAssociatedObject(self, &UIViewControllerpercentDrivenTransition);
}

- (void)setSwipeInteractiveTransition:(UIPercentDrivenInteractiveTransition *)swipeInteractiveTransition
{
    objc_setAssociatedObject(self, &UIViewControllerpercentDrivenTransition, swipeInteractiveTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
