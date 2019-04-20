//
//  UINavigationItem+BarButtonItem.m
//  SuYunTong
//
//  Created by sfit0194 on 15/9/23.
//  Copyright (c) 2015年 顺丰科技. All rights reserved.
//

#import "UINavigationItem+BarButtonItem.h"

#import "HTTransitionManager.h"

@implementation UINavigationItem (BarButtonItem)

- (void)xsg_addLeftBarButtonItemWithTarget:(id)target action:(SEL)action
{
    [self setLeftBarButtonItem:nil];
    [self setLeftBarButtonItems:nil];
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                  target:nil
                                  action:nil];
    leftSpace.width = -19;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0f, 0.0f, 60.0f, 44.0f);
    button.imageEdgeInsets = UIEdgeInsetsMake(11.0f, 10.0f, 11.0f, 29.0f);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"Back"]
            forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"Back"]
            forState:UIControlStateHighlighted];
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self setLeftBarButtonItems:@[leftSpace,cancelBarButtonItem]
                       animated:YES];
    [self setLeftItemsSupplementBackButton:NO];
}

- (void)xsg_addLeftBarButtonItemWithTarget:(id)target action:(SEL)action imageName:(NSString *)imageName
{
    UIBarButtonItem *toolsBarItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:target action:action];
    toolsBarItem.tintColor = [UIColor clearColor];
    [self setLeftBarButtonItem:toolsBarItem];
}

- (void)xsg_addRightBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action textColor:(UIColor *)textColor
{
    [self setRightBarButtonItem:nil];
    [self setRightBarButtonItems:nil];
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                  target:nil
                                  action:nil];
    leftSpace.width = -10;
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 44.0f)];
    lable.text = title;
    lable.textColor = textColor;
    lable.textAlignment = NSTextAlignmentRight;
    lable.font = [UIFont systemFontOfSize:15.0f];
    lable.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target
                                                                          action:action];
    [lable addGestureRecognizer:tap];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lable];
    
    [self setRightBarButtonItems:@[leftSpace, barButtonItem]
                        animated:YES];
}

- (void)xsg_addLeftBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
{
    
    
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                  target:nil
                                  action:nil];
    leftSpace.width = -10;
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 75.0f, 44.0f)];
    lable.text = title;
    lable.textColor = [UIColor blackColor];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.font = [UIFont systemFontOfSize:18.0f];
    lable.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target
                                                                          action:action];
    [lable addGestureRecognizer:tap];
    
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lable];
    
    barButtonItem.tintColor = [UIColor blackColor];
    [self setLeftBarButtonItems:@[leftSpace, barButtonItem] animated:YES];
    [self setLeftItemsSupplementBackButton:NO];
}

- (void)xsg_addBackToBeforeBarButtonItem
{
    [self setLeftBarButtonItem:nil];
    [self setLeftBarButtonItems:nil];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0f, 0.0f, 60.0f, 44.0f);
    button.imageEdgeInsets = UIEdgeInsetsMake(11.0f, -4.0f, 11.0f, 43.0f);
                                                                                                                  
    [button addTarget:[HTTransitionManager shareManager]
               action:@selector(backToBeforeController)
     forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"Back"]
            forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"Back"]
            forState:UIControlStateHighlighted];
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self setLeftItemsSupplementBackButton:NO];
    [self setLeftBarButtonItems:@[cancelBarButtonItem] animated:NO];
}

- (void)xsg_addBackToRootBarButtonItem
{
    [self setLeftBarButtonItem:nil];
    [self setLeftBarButtonItems:nil];
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                  target:nil
                                  action:nil];
    leftSpace.width = -19;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0f, 0.0f, 60.0f, 44.0f);
    button.imageEdgeInsets = UIEdgeInsetsMake(11.0f, 10.0f, 11.0f, 29.0f);
    [button addTarget:[HTTransitionManager shareManager] action:@selector(backToRootControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"Back"]
            forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"Back"]
            forState:UIControlStateHighlighted];
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self setLeftBarButtonItems:@[leftSpace,cancelBarButtonItem]
                       animated:YES];
    [self setLeftItemsSupplementBackButton:NO];
}

- (void)xsg_addBackToBeforeBarButtonItemWithTitle:(NSString *)title
{
    [self setLeftBarButtonItem:nil];
    [self setLeftBarButtonItems:nil];
    
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                  target:nil
                                  action:nil];
    leftSpace.width = -10;
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 75.0f, 44.0f)];
    lable.text = title;
    lable.textColor = [UIColor blackColor];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.font = [UIFont systemFontOfSize:18.0f];
    lable.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:[HTTransitionManager shareManager]
                                                                          action:@selector(backToBeforeController)];
    [lable addGestureRecognizer:tap];
    
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lable];
    
    barButtonItem.tintColor = [UIColor blackColor];
    [self setLeftBarButtonItems:@[leftSpace, barButtonItem] animated:YES];
    [self setLeftItemsSupplementBackButton:NO];
}

- (void)xsg_addBackToRootBarButtonItemWithTitle:(NSString *)title
{
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                  target:nil
                                  action:nil];
    leftSpace.width = -10;
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 75.0f, 44.0f)];
    lable.text = title;
    lable.textColor = [UIColor blackColor];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.font = [UIFont systemFontOfSize:18.0f];
    lable.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:[HTTransitionManager shareManager]
                                                                          action:@selector(backToRootControllerAnimated:)];
    [lable addGestureRecognizer:tap];
    
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lable];
    
    barButtonItem.tintColor = [UIColor blackColor];
    [self setLeftBarButtonItems:@[leftSpace, barButtonItem] animated:YES];
    [self setLeftItemsSupplementBackButton:NO];
}

- (void)xsg_addBackButtonItemWithTarget:(id)target action:(SEL)action
{
    [self setLeftBarButtonItem:nil];
    [self setLeftBarButtonItems:nil];
    
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                  target:nil
                                  action:nil];
    leftSpace.width = -19;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0f, 0.0f, 60.0f, 44.0f);
    button.imageEdgeInsets = UIEdgeInsetsMake(11.0f, 10.0f, 11.0f, 29.0f);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"Back"]
            forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"Back"]
            forState:UIControlStateHighlighted];
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self setLeftBarButtonItems:@[leftSpace,cancelBarButtonItem]
                       animated:YES];
    [self setLeftItemsSupplementBackButton:NO];
}

- (void)xsg_addRightBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    [self xsg_addRightBarButtonItemWithTitle:title titleColor:[UIColor blackColor] target:target action:action];
}

- (void)xsg_addRightBarButtonItemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action
{
    [self setRightBarButtonItem:nil];
    [self setRightBarButtonItems:nil];
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                  target:nil
                                  action:nil];
    leftSpace.width = -10;
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 44.0f)];
    lable.text = title;
    lable.textColor = titleColor;
    lable.textAlignment = NSTextAlignmentRight;
    lable.font = [UIFont systemFontOfSize:15.0f];
    lable.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target
                                                                          action:action];
    [lable addGestureRecognizer:tap];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lable];
    
    [self setRightBarButtonItems:@[leftSpace, barButtonItem]
                        animated:YES];
}

- (void)xsg_updateRightBarButtonItemStatusWithTitle:(NSString *)title titleColor:(UIColor *)titleColor tapEnable:(BOOL)tapEnable
{
    NSArray *rightBarButtons = [self rightBarButtonItems];
    if(rightBarButtons && [rightBarButtons count] == 2){
        UIBarButtonItem *barButtonItem = rightBarButtons[1];
        UILabel *lable = (UILabel *)barButtonItem.customView;
        lable.text = title;
        lable.textColor = titleColor;
        lable.userInteractionEnabled = tapEnable;
    }
}

- (void)xsg_addRightBarButtonItemWithTarget:(id)target action:(SEL)action imageName:(NSString *)imageName
{
    UIBarButtonItem *toolsBarItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:target action:action];
    toolsBarItem.tintColor = [UIColor clearColor];
    [self setRightBarButtonItem:toolsBarItem];
}

- (void)xsg_setTitleViewWithImageName:(NSString *)imageName
{
    if (!imageName) return;
    UIImage *image = [UIImage imageNamed:imageName];
    if (!image) return;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    [self setTitleView:imageView];
}

- (void)xsg_setTitleView:(UIView *)view
{
    [self setTitleView:view];
}

@end
