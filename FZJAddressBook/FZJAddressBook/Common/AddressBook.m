//
//  AddressBook.m
//  FZJAddressBook
//
//  Created by fdkj0002 on 16/1/25.
//  Copyright © 2016年 FZJ.com. All rights reserved.
//

#import "AddressBook.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <MessageUI/MessageUI.h>

#import "ContactModel.h"
#import "NSString+Extension.h"


@implementation AddressBook


+(void)getAllContacts:(void(^)(NSArray * contacts))completion error:(void(^)(NSString * error))error{
    
    NSMutableArray * addArr = [NSMutableArray array];
    /**
     *  创建addressBook对象 用于访问通讯录
     */
    ABAddressBookRef addressBooks = ABAddressBookCreate();
    
    /**
     *  访问通讯录的状态
     */
    int status = ABAddressBookGetAuthorizationStatus();
    /**
     *  kABAuthorizationStatusNotDetermined  0  未进行授权
     *  kABAuthorizationStatusRestricted     1  未授权，且用户无法更新，如家长控制情况下
     *  kABAuthorizationStatusDenied         2 用户拒绝应用访问通讯录
     *  kABAuthorizationStatusAuthorized     3 已授权可以使用
     */
    
    if (status == 0 || status == 1 || status == 2) {
        NSLog(@"可以提醒用户");
    }
    
    if (status == 2) {
        return;
    }
    NSLog(@"----%d",status);
    
    dispatch_semaphore_t singal = dispatch_semaphore_create(0);//发出访问通讯录的请求
    
    ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error) {
        dispatch_semaphore_signal(singal);
    });
    
    dispatch_semaphore_wait(singal, DISPATCH_TIME_FOREVER);
    
    /**
     *  获取所有的联系人（联系人的所有属性）
     */
    CFArrayRef allContacts = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    /**
     *  联系人的数量
     */
   // CFIndex contactIndex = ABAddressBookGetPersonCount(addressBooks);
    /**
     *  遍历所有联系人
     */
    for (int i = 0; i < CFArrayGetCount(allContacts); i ++) {
        /**
         *  对每一个联系人操作
         */
        ABRecordRef contact = CFArrayGetValueAtIndex(allContacts, i);
        [self transformContact:contact completion:^(ContactModel *model) {
            [addArr addObject:model];
        }];
    }
    completion(addArr);
}

+(void)getAllGroupContact:(void(^)(NSArray * contacts,NSArray * subtitle))completion error:(void(^)(NSString * error))error;
{
    NSMutableArray * allContact = [NSMutableArray array];
    NSMutableArray * subtitleArr = [NSMutableArray array];
    
    [self getAllContacts:^(NSArray *contacts) {
        
        for (ContactModel * model in contacts) {//取到所有的首字母
            if (![subtitleArr containsObject:model.contactFirstCharacter]) {//
                [subtitleArr addObject:model.contactFirstCharacter];
            }
        }
        
        for (NSString * title in subtitleArr) {//首字母相同的联系人放到同一个数组中
            NSMutableArray * arr = [NSMutableArray array];
            for (ContactModel * model in contacts) {
                if ([model.contactFirstCharacter isEqualToString:title]) {
                    [arr addObject:model];
                }
            }
            [allContact addObject:arr];
        }
        
        completion(allContact,subtitleArr);
        
    } error:^(NSString *error) {
        
    }];
    
}
/**
 *  获取所有的联系人电话号码
 *
 *  @param completion 结果
 *  @param error      错误提示
 */
+(void)getAllPhoneNumber:(void(^)(NSArray * phoneNumbers))completion error:(void(^)(NSString * error))error{
    NSMutableArray * numberArr = [NSMutableArray array];
    [self getAllContacts:^(NSArray *contacts) {
        for (ContactModel * model in contacts) {
            [numberArr addObject:model.contactPhoneNumber];
        }
        completion(numberArr);
    } error:^(NSString *error) {
        
    }];
}
/**
 *  获取所有的联系人姓名
 *
 *  @param completion 结果
 *  @param error      错误提示
 */
+(void)getAllContactsName:(void(^)(NSArray * contactsNames))completion error:(void(^)(NSString * error))error{
    NSMutableArray * contactArr = [NSMutableArray array];
    [self getAllContacts:^(NSArray *contacts) {
        for (ContactModel * model in contacts ) {
            [contactArr addObject:model.contactFullName];
        }
        completion(contactArr);
    } error:^(NSString *error) {
        
    }];
}

/**
 *  对每一个联系人进行操作
 *
 *  @param contact    单个联系人
 *  @param completion 传回数据模型
 */
+(void)transformContact:(ABRecordRef)contact completion:(void(^)(ContactModel * model))completion{
    /**
     *  对每一个联系人操作
     */
    ContactModel * model = [[ContactModel alloc] init];
    /**
     *  取到名字（宗建）
     */
    model.contactFirstName = (__bridge NSString *)(ABRecordCopyValue(contact, kABPersonFirstNameProperty));//桥接转换
    /**
     *  取到姓（付）
     */
    model.contactLastName = (__bridge NSString *)(ABRecordCopyValue(contact, kABPersonLastNameProperty));
    /**
     *  姓的首字母（字符串形式）
     */
    model.contactFirstCharacter = [model.contactLastName getFirstCharactor];
    /**
     *  取到全名（付宗建）
     */
    model.contactFullName = (__bridge NSString *)(ABRecordCopyCompositeName(contact));
    
    model.contactRecordID = (NSInteger)ABRecordGetRecordID(contact);
    
    model.contactMiddleName = (__bridge NSString *)(ABRecordCopyValue(contact, kABPersonMiddleNameProperty));//取出来为空（可能是水土不服）
    
    model.contactPreFix = (__bridge NSString *)(ABRecordCopyValue(contact, kABPersonPrefixProperty));//取出来为空（可能是水土不服）
    
    model.contactSufFix = (__bridge NSString *)(ABRecordCopyValue(contact, kABPersonSuffixProperty));//取出来为空（可能是水土不服）
    
    model.contactNickName = (__bridge NSString *)(ABRecordCopyValue(contact, kABPersonNicknameProperty));//取出来为空（可能是水土不服）
    /**
     *  联系人的属性比较多 就不一一列举了
     */
    
    /**
     *  取到联系人的联系电话和邮箱
     */
    ABPropertyID properties[] = {
        kABPersonPhoneProperty,//电话
        kABPersonEmailProperty//邮箱
    };
    
    NSInteger total = sizeof(properties) / sizeof(ABPropertyID);
    for (NSInteger j = 0; j < total; j ++) {
        ABPropertyID property = properties[j];
        ABMultiValueRef valueRef = ABRecordCopyValue(contact, property);
        NSInteger value = 0;
        if (valueRef != nil) {
            value = ABMultiValueGetCount(valueRef);
        }
        if (value == 0) {
            CFRelease(valueRef);
            continue;
        }
        
        for (NSInteger k = 0; k < value; k ++) {
            CFStringRef stringRef = ABMultiValueCopyValueAtIndex(valueRef, k);
            switch (j) {
                case 0:
                    model.contactPhoneNumber = [(__bridge NSString *)stringRef initPhoneString];
                    break;
                case 1:
                    model.contactEmail = [(__bridge NSString *)stringRef initPhoneString];
                    break;
                default:
                    break;
            }
        }
        
    }
    completion(model);
}

@end
