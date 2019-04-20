//
//  Created by Usopp on 2019/4/16.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIViewClickHandle)(UIView *view);

@interface UIView (KBUIViewAdditions)

/**
 *  center.X
 */
@property (nonatomic, assign) CGFloat centerX;

/**
 *  center.y
 */
@property (nonatomic, assign) CGFloat centerY;

/**
 *  orgin.x
 */
@property (nonatomic, assign) CGFloat left;
/**
 *  origin.y
 */
@property (nonatomic, assign) CGFloat top;
/**
 *  origin.x+width
 */
@property (nonatomic, assign) CGFloat right;
/**
 *  y+height
 */
@property (nonatomic, assign) CGFloat bottom;
/**
 *  view.frame.size.width 宽
 */
@property (nonatomic, assign) CGFloat width;
/**
 *  view.frame.size.height 高
 */
@property (nonatomic, assign) CGFloat height;
/**
 *  view.frame.origin
 */
@property (nonatomic, assign) CGPoint origin;
/**
 *  view.frame.size
 */
@property (nonatomic, assign) CGSize  size;

/**
 *  清空所有子view
 */
-(void)removeAllSubviews;
/**
 *  增加UIView的点击事件
 */
-(void)viewClick:(UIViewClickHandle)handle;

//增加一根线
- (UIView*)addLineWithY:(CGFloat)originY;

//当前view截图
- (UIImage*)createImageWithScale:(CGFloat)scale;

@end
