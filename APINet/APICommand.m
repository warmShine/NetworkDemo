//
//  APICommand.m
//  NetworkDemo
//
//  Created by 冯磊 on 2019/3/16.
//  Copyright © 2019年 super. All rights reserved.
//

#import "APICommand.h"
#import "APINetConfig.h"
#import "APINetManager.h"

@interface APICommand ()

@property (nonatomic, strong) APINetConfig *config;

@end

@implementation APICommand

- (void)setNetConfig:(APINetConfig *)config {
    self.config = config;
}

+ (void)sendCommand:(NSString *)path
              param:(NSDictionary *)params
            success:(ResponseFinished)successBlock
               fail:(ResponseFailed)failBlock {
    [self sendCommand:path
                param:params
              options:APIRequestOptions_NET
               method:API_POST
              success:successBlock
                 fail:failBlock];
}

+ (void)sendCommand:(NSString *)path
              param:(NSDictionary *)params
            options:(APIRequestOptions)option
            success:(ResponseFinished)successBlock
               fail:(ResponseFailed)failBlock {
    [self sendCommand:path
                param:params
              options:option
               method:API_POST
              success:successBlock
                 fail:failBlock];
    
}

+ (void)sendCommand:(NSString *)path
              param:(NSDictionary *)params
            options:(APIRequestOptions)option
             method:(APIRequestMethod)method
            success:(ResponseFinished)successBlock
               fail:(ResponseFailed)failBlock {
    APICommand *command = [[self alloc]init];
//    NSString *baseurl = command.config.baseUrl;
    [[APINetManager sharedInstance] addCommand:command];
//    [APINetManager APIRequestUrl:baseurl
//                            path:path
//                           param:params
//                         options:option
//                          method:method
//                         success:successBlock
//                            fail:failBlock];
}

@end
