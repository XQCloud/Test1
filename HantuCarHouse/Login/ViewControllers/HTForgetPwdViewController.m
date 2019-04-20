//
//  HTForgetPwdViewController.m
//  HantuCarHouse
//
//  Created by Usopp on 2019/4/19.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import "HTForgetPwdViewController.h"
#import "HTConfirmButton.h"
#import "NSString+HT.h"
#import "HTCountDownTimerTool.h"

@interface HTForgetPwdViewController ()<HTCountDownTimerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;     // 账号输入框
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;  // 验证码输入框
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;         // 新密码输入框
@property (weak, nonatomic) IBOutlet UIButton *timerBtn;                // 定时器按钮
@property (weak, nonatomic) IBOutlet HTConfirmButton *confirmBtn;       // 确定按钮
@property (nonatomic,strong)HTCountDownTimerTool *countDownTool;        // 倒计时
@property (nonatomic,strong)NSString *valideBtnTitle;                   // 倒计时数字

@end

@implementation HTForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.valideBtnTitle = @"发送验证码";
    [self.confirmBtn setEnabled:NO];
    [self.accountTextField addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
    [self.verifyCodeTextField addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwdTextField addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textChange {
    if([NSString isMobile:self.accountTextField.text] && [NSString isPureNum:self.verifyCodeTextField.text] && self.verifyCodeTextField.text.length == 6 && self.pwdTextField.text.length >= 6) {
        [self.confirmBtn setEnabled:YES];
    } else {
        [self.confirmBtn setEnabled:NO];
    }
}

//value改变
- (void)valueChange:(UITextField *)textField {
    if (textField == self.accountTextField && textField.text.length > 11) {
        textField.text = [textField.text substringToIndex:textField.text.length - 1];
        return;
    }
    if(textField == self.verifyCodeTextField && textField.text.length > 6) {
        textField.text = [textField.text substringToIndex:textField.text.length - 1];
        return;
    }
    if(textField == self.pwdTextField && textField.text.length > 18) {
        textField.text = [textField.text substringToIndex:textField.text.length - 1];
        return;
    }
    [self textChange];
}

#pragma mark - Action
- (IBAction)timerBtnAction:(UIButton *)sender {
    // 获取验证码
    if (![NSString isMobile:self.accountTextField.text]) {
        return;
    }
    if(!([self.timerBtn.titleLabel.text isEqualToString:@"发送验证码"] || [self.timerBtn.titleLabel.text isEqualToString:@"重新发送"])) {
        return;
    }
    [self.countDownTool startTimer];
    
    kWeakSelf;
    // TODO 调接口获取验证码
    
    
}
- (IBAction)confirmBtnAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- HTCountDownTimerDelegate
- (void)countDownTimer:(HTCountDownTimerTool *)tool currentValue:(NSInteger)value {
    self.valideBtnTitle = [NSString stringWithFormat:@"%zds",value];
    if (value == 0) {
        self.valideBtnTitle = @"重新发送";
    }
    [self.timerBtn setTitle:self.valideBtnTitle forState:UIControlStateNormal];
}
#pragma mark -- setter&&getter
- (HTCountDownTimerTool *)countDownTool {
    if (!_countDownTool) {
        self.countDownTool = [HTCountDownTimerTool new];
        self.countDownTool.delegate = self;
    }
    return _countDownTool;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
