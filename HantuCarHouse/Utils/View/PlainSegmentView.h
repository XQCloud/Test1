//
//  PlainSegmentView.h
//  HantuCarHouse
//
//  Created by Usopp on 2019/4/18.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlainSegmentView : UIView
@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentControl;// 与xib连线，VC也要与xib连线
@property (nonatomic, weak) IBOutlet UIView *indicatorLineView;
@end
