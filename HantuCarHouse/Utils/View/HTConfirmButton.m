//
//  HTConfirmButton.m
//  HantuCarHouse
//
//  Created by Usopp on 2019/4/18.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import "HTConfirmButton.h"

@implementation HTConfirmButton

-(void)awakeFromNib{
    [super awakeFromNib];
    [self loadView];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

- (void)loadView{
    self.backgroundColor = kTextColor_S01;
    self.titleLabel.textColor = [UIColor whiteColor];
    
    self.layer.cornerRadius = self.bounds.size.height/2;
    self.layer.borderColor = kTextColor_S01.CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.masksToBounds = YES;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.alpha = 0.8f;
    } else {
        self.alpha = 1.0f;
    }
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (enabled) {
        self.backgroundColor = kTextColor_S01;
        self.layer.borderColor = kTextColor_S01.CGColor;
    } else {
        self.backgroundColor = kTextColor_S03;
        self.layer.borderColor = kTextColor_S03.CGColor;
    }
}

@end
