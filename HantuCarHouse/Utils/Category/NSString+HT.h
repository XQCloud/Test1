//
//  NSString+HT.h
//  HantuCarHouse
//
//  Created by Usopp on 2019/4/18.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HT)
/**
 过滤参数内不包含的字符
 
 @param containInString 字符集
 @return 过滤后字符串
 */
- (NSString *)ht_filterNotContainCharacterInString:(NSString *)containInString;

/**
 过滤字符集中的字符
 
 @param characterSet 字符集
 @return 过滤后字符串
 */
- (NSString *)ht_filterCharacterWithCharacterSet:(NSCharacterSet *)characterSet;

/**
 判断是否是包含数字中文英文
 
 @return 是否是
 */
- (BOOL)ht_containNumAlphabetAndChinese;

/**
 移除字符串中非数字中文英文
 
 @return 去除之后的实例化字符串
 */
- (instancetype)ht_stringBySiftNumAlphabetAndChinese;
/**
 判断是否是空字符串
 */
+ (BOOL)isBlankString:(NSString *)string;

/**
 未知类型（仅限字典/数组/字符串）
 
 @param object 字典/数组/字符串
 @return 字符串
 */
+(NSString *) ht_jsonStringWithObject:(id) object;

/**
 @return object 字典/数组/字符串
 */
+(id) ht_objectWithJsonString:(NSString *) jsonString;

/**
 * 将指定的特殊字符 标成指定颜色
 @param attributeString 指定的特殊字符
 @param color 指定颜色
 @return 富文本
 */
+ (NSMutableAttributedString *)setAttributeWithString:(NSString *)string attributeString:(NSString *)attributeString color:(UIColor *)color;

/**
 *  判断字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

/**
 根据正则，过滤特殊字符
 
 @param string 字符串
 @param regexStr 正则表达式
 @return 过滤后的字符串
 */
+ (NSString *)filterCharactor:(NSString *)string withRegex:(NSString *)regexStr;


/**
 验证手机号

 @param mobileNumbel 手机号
 */
+ (BOOL)isMobile:(NSString *)mobileNumbel;
/**
 验证是否为纯数字
 
 @param numStr 验证码
 */
+ (BOOL)isPureNum:(NSString *)numStr;
@end

NS_ASSUME_NONNULL_END
