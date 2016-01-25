//
//  NSString+Extension.h
//  FZJAddressBook
//
//  Created by fdkj0002 on 16/1/25.
//  Copyright © 2016年 FZJ.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *  是否包含某字符串
 */
-(BOOL)isContainSubstring:(NSString *)subString;
/**
 *  将电话号码转化为纯正的数字
 */
-(NSString *)initPhoneString;
/**
 *  获取字符串的首字母
 */
-(NSString *)getFirstCharactor;
@end
