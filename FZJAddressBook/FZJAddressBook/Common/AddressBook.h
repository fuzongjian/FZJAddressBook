//
//  AddressBook.h
//  FZJAddressBook
//
//  Created by fdkj0002 on 16/1/25.
//  Copyright © 2016年 FZJ.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AddressBook : NSObject
/**
 *  取到多有的联系人 并没有分组
 */
+(void)getAllContacts:(void(^)(NSArray * contacts))completion error:(void(^)(NSString * error))error;
/**
 *  取到所有的联系人并分组
 *  subtitle 所有联系人的字母     contacts已经分组的联系人   subtitle与contacts一一对应
 */
+(void)getAllGroupContact:(void(^)(NSArray * contacts,NSArray * subtitle))completion error:(void(^)(NSString * error))error;

/**
 *  获取所有的联系人电话号码
 *
 *  @param completion 结果
 *  @param error      错误提示
 */
+(void)getAllPhoneNumber:(void(^)(NSArray * phoneNumbers))completion error:(void(^)(NSString * error))error;
/**
 *  获取所有的联系人姓名
 *
 *  @param completion 结果
 *  @param error      错误提示
 */
+(void)getAllContactsName:(void(^)(NSArray * contactsNames))completion error:(void(^)(NSString * error))error;

@end
