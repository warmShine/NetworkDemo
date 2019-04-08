//
//  FirstVC.m
//  NetworkDemo
//
//  Created by 冯磊 on 2019/3/16.
//  Copyright © 2019年 super. All rights reserved.
//

#import "FirstVC.h"
#import "APICommand.h"

@interface FirstVC ()

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [APICommand APIRequestPath:@"/zaker/ntptime.php" param:nil success:^(long code, NSString * _Nonnull message, id  _Nonnull data) {
        NSLog(@"message = %@ data = %@",message,data);
    } fail:^(long code, NSString * _Nonnull message) {
        NSLog(@"message = %@",message);
    }];

//    [API2 APIRequest:@"" param:nil success:^(long code, NSString * _Nonnull message, id  _Nonnull data) {
//        NSLog(@"message1 = %@ data1 = %@",message,data);
//    } fail:^(long code, NSString * _Nonnull message) {
//        NSLog(@"message1 = %@",message);
//    }];
    
    
}

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
