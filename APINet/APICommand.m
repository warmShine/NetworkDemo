//
//  APICommand.m
//  NetworkDemo
//
//  Created by 冯磊 on 2019/4/8.
//  Copyright © 2019 super. All rights reserved.
//

#import "APICommand.h"

@implementation APICommand

- (id<APIParamsProtocol>)APINetConfig {
    APINetConfig *config1 = [[APINetConfig alloc]initWithBaseUrl:@"http://zkres.myzaker.com"];
    return config1;
}

@end
