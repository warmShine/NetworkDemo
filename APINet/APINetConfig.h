//
//  APINetConfig.h
//  NetworkDemo
//
//  Created by fenglei on 2019/2/26.
//  Copyright © 2019 super. All rights reserved.
//

#import "NetConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface APINetConfig : NetConfig <APIParamsProtocol>

- (instancetype)initWithBaseUrl:(NSString *)baseUrl;

@end

NS_ASSUME_NONNULL_END
