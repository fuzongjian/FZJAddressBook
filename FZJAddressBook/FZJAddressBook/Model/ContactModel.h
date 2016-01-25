//
//  ContactModel.h
//  FZJAddressBook
//
//  Created by fdkj0002 on 16/1/25.
//  Copyright © 2016年 FZJ.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject
@property(nonatomic,strong)NSString * contactFirstName;//名（宗建）
@property(nonatomic,strong)NSString * contactLastName;//姓(付)
@property(nonatomic,strong)NSString * contactFullName;//全名（付宗建）
@property(nonatomic,assign)NSInteger contactRecordID;//联系人在通讯录中的ID


@property(nonatomic,strong)NSString * contactPhoneNumber;//联系人号码
@property(nonatomic,strong)NSString * contactEmail;//联系人邮箱
@property(nonatomic,strong)NSString * contactFirstCharacter;//联系人姓的首字母


@property(nonatomic,strong)NSString * contactMiddleName;
@property(nonatomic,strong)NSString * contactPreFix;
@property(nonatomic,strong)NSString * contactSufFix;
@property(nonatomic,strong)NSString * contactNickName;

@end
