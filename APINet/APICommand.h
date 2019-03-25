//
//  APICommand.h
//  NetworkDemo
//
//  Created by 冯磊 on 2019/3/16.
//  Copyright © 2019年 super. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APINetConfig.h"
#import "APIDefine.h"
#import "APICommandProtocol.h"

/**接口成功block
 *code 接口返回code
 *message 接口提示信息
 *data 接口返回内容
 */
typedef void(^ResponseFinished)(long code,NSString *message,id data);

/**接口失败block
 *code 接口返回code
 *message 接口提示信息
 */
typedef void(^ResponseFailed)(long code, NSString *message);

@interface APICommand : NSObject <APICommandProtocol>

@property (nonatomic, copy) ResponseFinished responseSuccessBlock;
@property (nonatomic, copy) ResponseFailed responseFailBlock;

- (void)setNetConfig:(APINetConfig *)config;

+ (void)sendCommand:(NSString *)path
              param:(nullable NSDictionary *)params
            success:(ResponseFinished)successBlock
               fail:(ResponseFailed)failBlock;

+ (void)sendCommand:(NSString *)path
              param:(nullable NSDictionary *)params
            options:(APIRequestOptions)option
            success:(ResponseFinished)successBlock
               fail:(ResponseFailed)failBlock;

/**发送请求方法
 * path     url
 * params   参数
 * option   缓存策略
 * method   请求类型
 * success  成功回调
 * fail     失败回调
 */
+ (void)sendCommand:(NSString *)path
              param:(nullable NSDictionary *)params
            options:(APIRequestOptions)option
             method:(APIRequestMethod)method
            success:(ResponseFinished)successBlock
               fail:(ResponseFailed)failBlock;
@end
