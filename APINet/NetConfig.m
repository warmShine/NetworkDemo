//
//  NetConfig.m
//  NetworkDemo
//
//  Created by fenglei on 2019/2/26.
//  Copyright © 2019 super. All rights reserved.
//

#import "NetConfig.h"

@interface NetConfig ()


@end

@implementation NetConfig


- (NSString *)baseUrl {
    return baseUrl;
}

/**
 配置请求通用参数
 @param path 传入path原因：有可能不同的接口会添加不同的通用参数
 @return 通用参数字典
 */
- (NSDictionary *)requestParams:(NSString *)path {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"11111" forKey:@"nb"];
    
    
    return params;
}



@synthesize baseUrl;

@end
