//
//  HTCenterTabBar.m
//
//  Created by Usopp on 2019/4/16.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import "HTCenterTabBar.h"
#import "KBUIViewAdditions.h"

@interface HTCenterTabBar ()

@property (nonatomic, strong) UIButton *centerButton;

@end

@implementation HTCenterTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadViews];
    }
    return self;
}

/*
- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize sizeThatFits = [super sizeThatFits:size];
    sizeThatFits.height = 54;
    
    return sizeThatFits;
}
 */

- (void)loadViews
{
    UIImage *img = [UIImage imageNamed:@"tab_add"];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 , 0, img.size.width, img.size.height)];
//    button.adjustsImageWhenHighlighted = NO;
    button.layer.masksToBounds = YES;
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setImage:img forState:UIControlStateNormal];
    [self addSubview:button];
    [self bringSubviewToFront:button];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH, 40)];
    lbl.text = @"发布询价";
    lbl.font = kTextFont_10;
    lbl.textColor = kTextColor_S02;
    lbl.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lbl];
    [self bringSubviewToFront:lbl];
    
    [button addTarget:self action:@selector(clickBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    _centerButton = button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //默认存在中间按钮
    NSInteger tabBarItemCount = 1;
    
    self.centerButton.centerX = self.width * 0.5;
    self.centerButton.centerY = self.height * 0.1;
    
    for (UIView *childView in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([childView isKindOfClass:class]) {
            tabBarItemCount++;
        }
    }
    
    //设置其他tabbarButton的frame 仅限于左右对称，btn居中
    CGFloat tabBarButtonW = self.width / tabBarItemCount;
    CGFloat tabBarButtonIndex = 0;
    NSInteger centerButtonIndex = tabBarItemCount / 2;
    
    for (UIView *childView in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([childView isKindOfClass:class]) {
            childView.left = tabBarButtonIndex * tabBarButtonW;
            childView.width = tabBarButtonW;
            // 设置索引
            tabBarButtonIndex++;
            if (tabBarButtonIndex == centerButtonIndex) {
                tabBarButtonIndex++;
            }
        }
    }
}

/**
 *  按钮点击
 */
- (void)clickBtnAction
{
    if (self.centerTabBarDelegate && [self.centerTabBarDelegate respondsToSelector:@selector(tabBarDidClickCenterButton:)]) {
        [self.centerTabBarDelegate tabBarDidClickCenterButton:self];
    }
}

/**
 *  解决按钮超出范围部分依然可触发点击
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (!self.isHidden) {
        CGPoint newP = [self convertPoint:point toView:self.centerButton];
        if ([self.centerButton pointInside:newP withEvent:event]) {
            return self.centerButton;
        } else {
            return [super hitTest:point withEvent:event];
        }
    } else {
        return [super hitTest:point withEvent:event];
    }
    
}

@end
