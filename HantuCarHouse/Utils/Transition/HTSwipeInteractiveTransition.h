//
//  HTSwipeInteractiveTransition.h
//
//  Created by Usopp on 2019/4/16.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HTSwipeInteractiveTransition : UIPercentDrivenInteractiveTransition

@property(nonatomic, assign) BOOL interacting; // 是否使用交互转场

/**
 设置PresentingVC
 
 用于确定手势位置
 
 @param viewController PresentingVC
 */
- (void)setPresentingViewController:(UIViewController*)viewController;

@end
