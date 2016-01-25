//
//  FZJViewController.m
//  FZJAddressBook
//
//  Created by fdkj0002 on 16/1/25.
//  Copyright © 2016年 FZJ.com. All rights reserved.
//

#import "FZJViewController.h"
#import "AddressBook.h"
@interface FZJViewController ()

@end

@implementation FZJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configFZJViewControllerUI];
}
#pragma mark --
#pragma mark 初始化UI
-(void)configFZJViewControllerUI{
    
    [AddressBook getAllContacts:^(NSArray *contacts) {
        
    } error:^(NSString *error) {
        
    }];
    
    [AddressBook getAllGroupContact:^(NSArray *contacts, NSArray *subtitle) {
        
    } error:^(NSString *error) {
        
    }];
    
    [AddressBook getAllContactsName:^(NSArray *contactsNames) {
        [contactsNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%@",obj);
        }];
    } error:^(NSString *error) {
        
    }];
    
    [AddressBook getAllPhoneNumber:^(NSArray *phoneNumbers) {
        NSLog(@"%@",phoneNumbers);
    } error:^(NSString *error) {
        
    }];
    
}
#pragma mark--
#pragma mark 数据请求

#pragma mark--
#pragma mark 数据加载

#pragma mark--
#pragma mark 事件

#pragma mark--
#pragma mark  代理

#pragma mark--
#pragma mark 通知注册及销毁

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
