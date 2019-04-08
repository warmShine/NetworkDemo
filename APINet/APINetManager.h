//
//  APINetManager.h
//  NetworkDemo
//
//  Created by fenglei on 2019/2/20.
//  Copyright © 2019 super. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIDefine.h"
#import "APINetConfig.h"
#import "APICommandProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@protocol APIResponseDelegate <NSObject>
@optional
/** 接口请求成功代理
 *code 接口返回code码
 *message 接口提示信息
 *data 接口返回内容
 */
- (void)requestWithSuccess:(long)code message:(NSString *)message data:(id)data;

/** 接口请求失败代理
 *code 接口返回code码
 *message 接口提示信息
 */
- (void)requestWithFailure:(long)code message:(NSString *)message;
@end

/**接口成功block
 *code 接口返回code
 *message 接口提示信息
 *data 接口返回内容
 */
typedef void(^ResponseFinished)(long code,NSString * _Nullable message,id data);

/**接口失败block
 *code 接口返回code
 *message 接口提示信息
 */
typedef void(^ResponseFailed)(long code, NSString *message);


@interface APINetManager : NSObject


@property (nonatomic, copy) ResponseFinished responseSuccessBlock;
@property (nonatomic, copy) ResponseFailed responseFailBlock;


/* method */

+ (instancetype)sharedInstance;

- (NSTimeInterval)requestTimeoutInterval;/*超时时间*/

- (id<APIParamsProtocol>)APINetConfig;/*挂载配置器*/



+ (void)APIRequestPath:(NSString *)path
                 param:(nullable NSDictionary *)params
               success:(ResponseFinished)success
                  fail:(ResponseFailed)fail;

/**发送请求方法
 * path     url
 * params   参数
 * option   缓存策略
 * method   请求类型
 * success  成功回调
 * fail     失败回调
 */
+ (void)APIRequestPath:(NSString *)path
                param:(nullable NSDictionary *)params
              options:(APIRequestOptions)option
               method:(APIRequestMethod)method
              success:(void (^)(long code, NSString *message, id response))successBlock
                 fail:(void (^)(long code, NSString *message))failBlock;

@end

NS_ASSUME_NONNULL_END
