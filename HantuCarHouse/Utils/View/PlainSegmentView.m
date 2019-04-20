//
//  PlainSegmentView.m
//  HantuCarHouse
//
//  Created by Usopp on 2019/4/18.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import "PlainSegmentView.h"
#import "Masonry.h"

@implementation PlainSegmentView

//- (void)dealloc {
//     [self.segmentControl removeObserver:self forKeyPath:@"selectedSegmentIndex"];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIFont *normalFont = kTextFont_23;
    UIFont *selectedFont = normalFont;
    NSDictionary *attrNormal = @{NSFontAttributeName:normalFont,NSForegroundColorAttributeName:kTextColor_S06};
    NSDictionary *attrSelected = @{NSFontAttributeName:selectedFont,NSForegroundColorAttributeName:kTextColor_S01};
    NSDictionary *attrDisable = @{NSFontAttributeName:normalFont,NSForegroundColorAttributeName:kTextColor_S06};
    [self.segmentControl setTitleTextAttributes:attrNormal forState:UIControlStateNormal];
    [self.segmentControl setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
    [self.segmentControl setTitleTextAttributes:attrDisable forState:UIControlStateDisabled];
    self.segmentControl.tintColor = [UIColor whiteColor];
    self.segmentControl.backgroundColor = [UIColor clearColor];
    
    if (self.indicatorLineView) {
        [self.segmentControl addObserver:self forKeyPath:@"selectedSegmentIndex" options:NSKeyValueObservingOptionNew context:nil];
        [self layoutIndicator];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"selectedSegmentIndex"]) {
        [self layoutIndicator];
    }
}

- (void)layoutIndicator {
    [self.indicatorLineView removeFromSuperview];
    [self addSubview:self.indicatorLineView];
    self.indicatorLineView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSInteger idx = self.segmentControl.selectedSegmentIndex;
    double w = self.segmentControl.bounds.size.width/self.segmentControl.numberOfSegments;
    [self.indicatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.height.equalTo(@3);
        make.width.equalTo(self.segmentControl.mas_width).multipliedBy(1.0/self.segmentControl.numberOfSegments);
        make.leading.equalTo(@(idx*w));
    }];
}

@end
