//
//  HTSwipeInteractiveTransition.m
//
//  Created by Usopp on 2019/4/16.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import "HTSwipeInteractiveTransition.h"

@interface HTSwipeInteractiveTransition()<UIGestureRecognizerDelegate>

@property(nonatomic, assign) BOOL shouldComplete;
@property(nonatomic, weak) UIViewController *presentingVC;

@end

@implementation HTSwipeInteractiveTransition

- (void)setPresentingViewController:(UIViewController*)viewController
{
    self.presentingVC = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
}

- (void)prepareGestureRecognizerInView:(UIView*)view {
  UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
  gesture.delegate = self;
  [view addGestureRecognizer:gesture];
}

- (CGFloat)completionSpeed
{
  return 1 - self.percentComplete;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
  
  CGPoint point = [gestureRecognizer locationInView:self.presentingVC.view];
  if(point.x <= 45.0f){
    return YES;
  }
  
  return NO;
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer {
  CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
  switch (gestureRecognizer.state) {
    case UIGestureRecognizerStateBegan:
      // 1. Mark the interacting flag. Used when supplying it in delegate.
      self.interacting = YES;
      [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
      break;
    case UIGestureRecognizerStateChanged: {
      // 2. Calculate the percentage of guesture
      CGFloat fraction = translation.x / CGRectGetWidth([[UIScreen mainScreen]bounds]);
      //Limit it between 0 and 1
      fraction = fminf(fmaxf(fraction, 0.0), 1.0);
      self.shouldComplete = (fraction > 0.15);
      [self updateInteractiveTransition:fraction];
      break;
    }
    case UIGestureRecognizerStateEnded:
    case UIGestureRecognizerStateCancelled: {
      // 3. Gesture over. Check if the transition should happen or not
      self.interacting = NO;
      if (!self.shouldComplete || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        [self cancelInteractiveTransition];
      } else {
        [self finishInteractiveTransition];
      }
      break;
    }
    default:
      break;
  }
}

- (BOOL)interacting
{
    if (!_presentingVC) return NO;
    return _interacting;
}

@end
