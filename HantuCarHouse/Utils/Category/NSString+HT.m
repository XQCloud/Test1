//
//  NSString+HT.m
//  HantuCarHouse
//
//  Created by Usopp on 2019/4/18.
//  Copyright © 2019 HanTu. All rights reserved.
//

#import "NSString+HT.h"

static NSCharacterSet* VariationSelectors = nil;

@implementation NSString (HT)


+ (void)load {
    VariationSelectors = [NSCharacterSet characterSetWithRange:NSMakeRange(0xFE00, 16)];
}

- (NSString *)ht_filterNotContainCharacterInString:(NSString *)containInString
{
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:containInString] invertedSet];
    return [self ht_filterCharacterWithCharacterSet:set];
}

- (NSString *)ht_filterCharacterWithCharacterSet:(NSCharacterSet *)characterSet
{
    NSString *filterString = [self copy];
    if (![characterSet isKindOfClass:[NSCharacterSet class]]) {
        return filterString;
    }
    filterString = [[filterString componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
    return filterString;
}

- (BOOL)isEmoji {
    if ([self rangeOfCharacterFromSet: VariationSelectors].location != NSNotFound) {
        return YES;
    }
    
    const unichar high = [self characterAtIndex: 0];
    
    // Surrogate pair (U+1D000-1F9FF)
    if (0xD800 <= high && high <= 0xDBFF) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
        
        return (0x1D000 <= codepoint && codepoint <= 0x1F9FF);
        
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27BF);
    }
}

- (BOOL)ht_isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)ht_includeChinese
{
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

- (BOOL)ht_containNumAlphabetAndChinese
{
    if ([self rangeOfCharacterFromSet:[NSCharacterSet characterSetWithRange:NSMakeRange(0x4e00, 0x9fff)]].location != NSNotFound) {
        return YES;
    }
    NSUInteger lengthOfString = self.length;
    for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
        unichar character = [self characterAtIndex:loopIndex]; //将输入的值转化为ASCII值（即内部索引值），可以参考ASCII表
        //48-57;{0,9};65-90;{A..Z};97-122:{a..z}
        if (character < 48) return NO; // 48 unichar for 0
        if (character > 57 && character < 65) return NO; //
        if (character > 90 && character < 97) return NO;
        if (character > 122) return NO;
    }
    return YES;
}

- (instancetype)ht_stringBySiftNumAlphabetAndChinese
{
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([substring ht_containNumAlphabetAndChinese]) ? substring:@""];
                          }];
    
    return buffer;
}

+ (BOOL)isBlankString:(NSString *)string {
    
    if ( ![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    if (string == nil || self == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([string isEqualToString:@"null"]) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    return NO;
}


+ (NSString*)ht_jsonStringWithObject:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+(id) ht_objectWithJsonString:(NSString *) jsonString{
    @try {
        NSError *error;
        id object = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        if(!object){
            NSLog(@"Got an error: %@", error);
        }
        return object;
    } @catch (NSException *e) {
        return nil;
    }
}

// 将传入的特殊字符 attributeString 标成指定颜色 color
+ (NSMutableAttributedString *)setAttributeWithString:(NSString *)string attributeString:(NSString *)attributeString color:(UIColor *)color {
    NSRange range = [string rangeOfString:attributeString];
    NSMutableAttributedString *newStringAtt = [[NSMutableAttributedString alloc] initWithString:string];
    if (range.location != NSNotFound && range.length > 0) {
        [newStringAtt addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    return newStringAtt;
}

+ (BOOL)stringContainsEmoji:(NSString *)string {
    
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

+ (NSString *)filterCharactor:(NSString *)string withRegex:(NSString *)regexStr {
    NSString *searchText = string;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:searchText options:NSMatchingReportCompletion range:NSMakeRange(0, searchText.length) withTemplate:@""];
    return result;
}
+ (BOOL)isMobile:(NSString *)mobileNumbel {
    NSString *regex = @"^1[0-9]{10}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:mobileNumbel];
    return isValid;
}
+ (BOOL)isPureNum:(NSString *)numStr {
    numStr = [numStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *pureNumberRegex = @"^[0-9]\\d*$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pureNumberRegex];
    return [passWordPredicate evaluateWithObject:numStr];
}
@end
