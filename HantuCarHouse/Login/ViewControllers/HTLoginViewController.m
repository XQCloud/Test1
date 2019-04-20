//
//  HTLoginViewController.m
//  HantuCarHouse
//
//  Created by Usopp on 2019/4/16.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import "HTLoginViewController.h"
#import "HTForgetPwdViewController.h"
#import "HTConfirmButton.h"
#import "NSString+HT.h"
#import "HTCountDownTimerTool.h"

typedef NS_ENUM(int, LoginType) {
    LoginTypeVerifyCode   = 0,  //验证码登录
    LoginTypePassword  = 1,     //账号密码登录
};

@interface HTLoginViewController ()<HTCountDownTimerDelegate>
@property (weak, nonatomic) IBOutlet UIView *segmentBGView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UILabel *topLbl;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;     // 账号输入框
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;  // 验证码输入框
@property (weak, nonatomic) IBOutlet UIButton *timerBtn;                // 定时器按钮
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UIButton *exchangeBtn;             // 切换登录按钮
@property (nonatomic, assign) LoginType loginType;
@property (weak, nonatomic) IBOutlet HTConfirmButton *loginBtn;         // 登录按钮
@property (nonatomic,strong)HTCountDownTimerTool *countDownTool;        // 倒计时
@property (nonatomic,strong)NSString *valideBtnTitle;                   // 倒计时数字
@property (weak, nonatomic) IBOutlet UILabel *bottomLbl;
@property (weak, nonatomic) IBOutlet UIView *bottomBgView;

// UI约束适配
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *totalHeight;   // 登录=106 注册=212
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint; // 登录=-53 注册=0
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;// 登录=-53 注册=0


@end

@implementation HTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.segmentControl addTarget:self action:@selector(segmentedChange) forControlEvents:UIControlEventValueChanged];
    
    self.valideBtnTitle = @"发送验证码";
    [self.loginBtn setEnabled:NO];
    [self.accountTextField addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
    [self.verifyCodeTextField addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textChange {
    if([NSString isMobile:self.accountTextField.text] && [NSString isPureNum:self.verifyCodeTextField.text] && self.verifyCodeTextField.text.length == 6) {
        [self.loginBtn setEnabled:YES];
    } else {
        [self.loginBtn setEnabled:NO];
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
    [self textChange];
    kWeakSelf;
    // TODO 调接口获取验证码
    
    
}
// 切换登录方式：账号密码登录---免密登录
- (IBAction)exchangeLoginAction:(id)sender {
    self.accountTextField.text = @"";
    self.verifyCodeTextField.text = @"";
    if (self.loginType == LoginTypeVerifyCode) {
        [self.exchangeBtn setTitle:@"免密码登录" forState:UIControlStateNormal];
        self.loginType = LoginTypePassword;
        self.accountTextField.placeholder = @"手机号/用户ID";
        self.verifyCodeTextField.placeholder = @"请输入密码";
        self.timerBtn.hidden = YES;
        self.forgetBtn.hidden = NO;
        self.topLbl.hidden = NO;
    } else {
        [self.exchangeBtn setTitle:@"账号密码登录" forState:UIControlStateNormal];
        self.loginType = LoginTypeVerifyCode;
        self.accountTextField.placeholder = @"请输入手机号";
        self.verifyCodeTextField.placeholder = @"验证码";
        self.timerBtn.hidden = NO;
        self.forgetBtn.hidden = YES;
        self.topLbl.hidden = YES;
    }
}
// 忘记密码
- (IBAction)forgetPwdAction:(id)sender {
    HTForgetPwdViewController *vc = [[HTForgetPwdViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
}


#pragma mark - segmentView选项点击
- (void)segmentedChange {
    if (self.segmentControl.selectedSegmentIndex == 0) {
        // 登录
        self.totalHeight.constant = 106;    // 登录=106 注册=212
        self.topConstraint.constant = -53;  // 登录=-53 注册=0
        self.bottomConstraint.constant = -53;
        
        [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        self.bottomLbl.hidden = YES;
        self.bottomBgView.hidden = NO;
    } else {
        // 注册
        self.totalHeight.constant = 212;    // 登录=106 注册=212
        self.topConstraint.constant = 0;    // 登录=-53 注册=0
        self.bottomConstraint.constant = 0;
        
        [self.loginBtn setTitle:@"注册" forState:UIControlStateNormal];
        self.bottomLbl.hidden = NO;
        self.bottomBgView.hidden = YES;
    }
    self.accountTextField.text = @"";
    self.verifyCodeTextField.text = @"";
    [self textChange];
}
#pragma mark -- HTCountDownTimerDelegate
- (void)countDownTimer:(HTCountDownTimerTool *)tool currentValue:(NSInteger)value {
    self.valideBtnTitle = [NSString stringWithFormat:@"%zds",value];
    if (value == 0) {
        self.valideBtnTitle = @"重新发送";
    }
    [self.timerBtn setTitle:self.valideBtnTitle forState:UIControlStateNormal];
}
- (IBAction)loginAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 微信登录
- (IBAction)wx_login:(id)sender {
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
