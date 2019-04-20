//
//  HTInputSetTextField.h
//
//  Created by Usopp on 2019/4/18.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HTInputSetTextFieldAllowType) {
    // 允许任意内容输入
    HTInputSetTextFieldAllowTypeAll,
    // 允许数字和字母输入
    HTInputSetTextFieldAllowTypeLetterAndNumber,
    // 允许数字输入
    HTInputSetTextFieldAllowTypeNumber,
    // 允许其它特殊输入设定
    HTInputSetTextFieldAllowTypeOther
};

/*
 输入内容变化后进行的回调，
 text：表示当前输入框内容（该内容为已做非允许字符串过滤和长度限制）
 isExceedMaxLength：表示用户在键盘输入时 超出最大允许字符长度
 isContainNotAllowString：表示用户在键盘输入时，输入了非允许字符串
 */
typedef void(^HTInputSetTextFieldTextChangeBlock)(NSString *text, BOOL isExceedMaxLength, BOOL isContainNotAllowString);

@interface HTInputSetTextField : UITextField

/**
 设置带过滤功能的TextField

 @param allowType 允许TextField的输入类型 当allowType 为 非 HTInputSetTextFieldAllowTypeOther 时，allowCharactersInString 传 nil
 @param allowCharactersInString 允许输入的自定义内容。 当allowType == HTInputSetTextFieldAllowTypeOther时， 不能为nil或空字符串
 @param maxInputLength 允许最大输入长度
 @param textDidChangeBlock 输入变化后回调
 */
- (void)setAllowType:(HTInputSetTextFieldAllowType)allowType
allowCharactersInString:(NSString *)allowCharactersInString
      maxInputLength:(NSUInteger)maxInputLength
  textDidChangeBlock:(HTInputSetTextFieldTextChangeBlock)textDidChangeBlock;

@end
