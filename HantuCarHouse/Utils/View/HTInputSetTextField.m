//
//  HTInputSetTextField.m
//  BLGCourier
//
//  Created by Usopp on 2019/4/18.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import "HTInputSetTextField.h"

#import "NSString+HT.h"

@interface HTInputSetTextField ()
@property (nonatomic, assign) HTInputSetTextFieldAllowType allowType;
@property (nonatomic, copy) NSString *allowCharactersInString;
@property (nonatomic, assign) NSUInteger maxInputLength;

@property (nonatomic, copy) HTInputSetTextFieldTextChangeBlock textDidChangeBlock;

@end

@implementation HTInputSetTextField

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textFieldTextDidChangeNotification:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textFieldTextDidChangeNotification:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (void)setAllowType:(HTInputSetTextFieldAllowType)allowType
allowCharactersInString:(NSString *)allowCharactersInString
      maxInputLength:(NSUInteger)maxInputLength
  textDidChangeBlock:(HTInputSetTextFieldTextChangeBlock)textDidChangeBlock {
    
    self.allowType = allowType;
    self.allowCharactersInString = allowCharactersInString;
    self.maxInputLength = maxInputLength;
    self.textDidChangeBlock = textDidChangeBlock;
    
    if (self.allowType == HTInputSetTextFieldAllowTypeNumber) {
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    else if (self.allowType == HTInputSetTextFieldAllowTypeLetterAndNumber) {
        self.keyboardType = UIKeyboardTypeASCIICapable;
    }
}

- (void)textFieldTextDidChangeNotification:(NSNotification *)info {
    UITextField *textField = (UITextField *)info.object;
    if (self == textField) {
        NSString *toBeString = textField.text;
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        BOOL isContainNotAllowString = NO;
        BOOL isExceedMaxLength = NO;
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            // 过滤非允许字符
            NSString *filterString = toBeString;
            switch (self.allowType) {
                case HTInputSetTextFieldAllowTypeAll:
                    break;
                case HTInputSetTextFieldAllowTypeLetterAndNumber:{
                    NSString *allowString = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
                    filterString = [toBeString ht_filterNotContainCharacterInString:allowString];
                }
                    break;
                case HTInputSetTextFieldAllowTypeNumber:{
                    filterString = [toBeString ht_filterCharacterWithCharacterSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
                }
                    break;
                case HTInputSetTextFieldAllowTypeOther:{
                    filterString = [toBeString ht_filterNotContainCharacterInString:self.allowCharactersInString];
                }
                    break;
                    
                default:
                    break;
            }
            if (filterString.length != toBeString.length) {
                toBeString = [filterString copy];
                textField.text = toBeString;
                isContainNotAllowString = YES;
            }
       
            if (toBeString.length > self.maxInputLength)
            {
                // 防止中文字符截取问题
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.maxInputLength];
                if (rangeIndex.length == 1)
                {
                    textField.text = [toBeString substringToIndex:self.maxInputLength];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.maxInputLength)];
                    textField.text = [toBeString substringWithRange:rangeRange];
                }
                isExceedMaxLength = YES;
            }
            
            if (self.textDidChangeBlock) {
                self.textDidChangeBlock(textField.text, isExceedMaxLength, isContainNotAllowString);
            }
        }
    }
}

- (NSString *)allowCharactersInString {
    if (!_allowCharactersInString) {
        
    }
    return _allowCharactersInString;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextFieldTextDidChangeNotification
                                                  object:nil];
}

@end
