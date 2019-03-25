//
//  APINetConfig.m
//  NetworkDemo
//
//  Created by fenglei on 2019/2/26.
//  Copyright © 2019 super. All rights reserved.
//

#import "APINetConfig.h"

@implementation APINetConfig

- (instancetype)initWithBaseUrl:(NSString *)baseUrl{
    self = [super init];
    if (self) {
        self.baseUrl = baseUrl;
    }
    return self;
}


@end
