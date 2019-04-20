//
//  HTCenterTabBar.h
//
//  Created by Usopp on 2019/4/16.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTCenterTabBar;

@protocol HTCenterTabBarDelegate;

@interface HTCenterTabBar : UITabBar

@property (nonatomic, weak) id<HTCenterTabBarDelegate> centerTabBarDelegate;

@end

@protocol HTCenterTabBarDelegate<NSObject>

/**
 TabBar中间按钮被点击

 @param tabBar TabBar
 */
- (void)tabBarDidClickCenterButton:(HTCenterTabBar *)tabBar;

@end
