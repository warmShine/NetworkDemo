//
//  APIParamsProtocol.h
//  NetworkDemo
//
//  Created by fenglei on 2019/2/26.
//  Copyright © 2019 super. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol APIParamsProtocol <NSObject>

@property (nonatomic, strong) NSString *baseUrl;

/*配置请求通用参数*/
- (NSDictionary *)requestParams:(nullable NSString *)path;


@end

NS_ASSUME_NONNULL_END
