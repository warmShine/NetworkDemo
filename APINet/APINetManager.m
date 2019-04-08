//
//  APINetManager.m
//  NetworkDemo
//
//  Created by fenglei on 2019/2/20.
//  Copyright © 2019 super. All rights reserved.
//

#import "APINetManager.h"
#import <AFNetworking/AFNetworking.h>

static NSString *const requestError = @"网络请求失败，请稍后重试";
static NSString *const networkError = @"无网络，请检查设备网络连接";

@interface APINetManager ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation APINetManager

+ (instancetype)sharedInstance {
    static APINetManager *netManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netManager = [[self alloc]init];
    });
    return netManager;
}

/**
 请求超时时长

 @return NSTimeInterval
 */
- (NSTimeInterval)requestTimeoutInterval {
    NSTimeInterval ret = 45.f;
    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
        ret = 30.f;
    }else if (status == AFNetworkReachabilityStatusReachableViaWiFi)
    {
        ret = 45.f;
    }
    return ret;
}

/**
 设置网络配置器

 */
- (id<APIParamsProtocol>)APINetConfig {
    //需要子类重写
    return nil;
}

/**
 请求默认缓存类型为NET 请求类型为POST方法

 @param path url path
 @param params url params
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)APIRequestPath:(NSString *)path
                 param:(nullable NSDictionary *)params
               success:(ResponseFinished)success
                  fail:(ResponseFailed)fail {
    [self APIRequestPath:path
               param:params
             options:APIRequestOptions_NET
              method:API_POST
             success:success
                fail:fail];
}

/**
 请求默认类型为POST类型

 @param path url path
 @param params url params
 @param option 请求缓存类型
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)APIRequest:(NSString *)path
             param:(nullable NSDictionary *)params
           options:(APIRequestOptions)option
           success:(ResponseFinished)successBlock
              fail:(ResponseFailed)failBlock {
        [self APIRequestPath:path
                   param:params
                 options:option
                  method:API_POST
                 success:successBlock
                    fail:failBlock];
}

/**
 请求的基类方法 （所有请求最后都是实现此方法）

 @param path url path
 @param params url params
 @param option 请求缓存类型
 @param method 请求类型
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)APIRequestPath:(NSString *)path
                param:(NSDictionary *)params
              options:(APIRequestOptions)option
               method:(APIRequestMethod)method
              success:(void (^)(long, NSString * _Nonnull, id _Nonnull))successBlock
                 fail:(void (^)(long, NSString * _Nonnull))failBlock{
    
    APINetManager *manager = [APINetManager sharedInstance];
    [manager setSuccessBlock:successBlock failBlock:failBlock];
    [manager startRequest:path param:params options:option method:method];
}

/**
 设置请求回调

 @param successBlock 成功回调
 @param failBlock 失败回调
 */
- (void)setSuccessBlock:(ResponseFinished)successBlock failBlock:(ResponseFailed)failBlock{
    self.responseSuccessBlock = successBlock;
    self.responseFailBlock = failBlock;
}

/**
 请求实际方法

 @param path URL path
 @param params URL params
 @param option 缓存类型
 @param method 请求类型
 */
- (void)startRequest:(NSString *)path
                    param:(nonnull NSDictionary *)params
                  options:(APIRequestOptions)option
                   method:(APIRequestMethod)method {
    [APINetManager networkReachableWithBlock:^(BOOL isReachable) {
        if (!isReachable) {
            if (self.responseFailBlock) {
                self.responseFailBlock(-1, networkError);
                return ;
            }
        }
    }];
    NSString *baseUrl = [self APINetConfig].baseUrl;
    NSMutableString *url = [baseUrl mutableCopy];
    if ([baseUrl hasSuffix:@"/"]) {
        if ([path hasPrefix:@"/"]) {
            [url deleteCharactersInRange:NSMakeRange(url.length-1, 1)];
            [url appendString:path];
        }else {
            [url appendString:path];
        }
    }else {
        if ([path hasPrefix:@"/"]) {
            [url appendString:path];
        }else {
            [url appendFormat:@"/%@",path];
        }
    }
    NSMutableDictionary *dic = [[[self APINetConfig] requestParams:path] mutableCopy];
    if (params) {
        [dic addEntriesFromDictionary:params];
    }
    switch (option) {
        case APIRequestOptions_NET:
            
            break;
        case APIRequestOptions_UseCache:
            
            break;
            
        default:
            break;
    }
    __weak typeof(self) weakSelf = self;
    switch (method) {
        case API_Get:
        {
            [self.manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf handleSuccessResponse:responseObject];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (strongSelf.responseFailBlock) {
                    strongSelf.responseFailBlock(-1, requestError);
                }
            }];
        }
            break;
        case API_POST:
        {
            [self.manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf handleSuccessResponse:responseObject];

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (strongSelf.responseFailBlock) {
                    strongSelf.responseFailBlock(-1, requestError);
                }

            }];
        }
            break;
        case API_PUT:
        {
            [self.manager PUT:url parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf handleSuccessResponse:responseObject];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (strongSelf.responseFailBlock) {
                    strongSelf.responseFailBlock(-1, requestError);
                }
            }];
        }
            break;
        case API_DELET:
        {
            [self.manager DELETE:url parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf handleSuccessResponse:responseObject];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (strongSelf.responseFailBlock) {
                    strongSelf.responseFailBlock(-1, requestError);
                }
            }];
        }
            
            break;
        case API_PATH_GET:
        {
            [self.manager PATCH:url parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf handleSuccessResponse:responseObject];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (strongSelf.responseFailBlock) {
                    strongSelf.responseFailBlock(-1, requestError);
                }
            }];
        }
            
            break;
        default:
            break;
    }
}

/**
 网络数据处理

 @param responseObj response
 */
- (void)handleSuccessResponse:(id)responseObj {
    if (responseObj && [responseObj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *obj = [responseObj copy];
        long code = [[obj objectForKey:@"code"] longValue];
        NSString *message = [obj objectForKey:@"message"];
        if (self.responseSuccessBlock) {
            self.responseSuccessBlock(code, message, obj);
        }
    }else if (responseObj && [responseObj isKindOfClass:[NSArray class]]) {
        NSArray *obj = [responseObj copy];
        if (self.responseSuccessBlock) {
            self.responseSuccessBlock(2, @"请求成功", obj);
        }
    }
}

// 网络状态监听，应用当前是否有网络
+ (void)networkReachableWithBlock:(void(^)(BOOL isReachable))block {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                if (block) {
                    block(YES);
                }
                break;
            }
            case AFNetworkReachabilityStatusNotReachable: {
                if (block) {
                    block(NO);
                }
                break;
            }
            default:
                break;
        }
    }];
    
    //结束监听
    //[[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer.timeoutInterval = [self requestTimeoutInterval];
        _manager.requestSerializer     = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer    = [AFJSONResponseSerializer serializer];
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        _manager.responseSerializer = responseSerializer;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"application/x-www-form-urlencodem", nil];
    }
    return _manager;
}

@end
