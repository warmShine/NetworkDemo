//
//  APIDefine.h
//  NetworkDemo
//
//  Created by 冯磊 on 2019/3/16.
//  Copyright © 2019年 super. All rights reserved.
//

#ifndef APIDefine_h
#define APIDefine_h

typedef NS_ENUM(NSInteger, APIRequestOptions){
    APIRequestOptions_NET,  //来自于网络接口不缓存
    APIRequestOptions_UseCache, //优先来源于缓存，无缓存 取接口
};
typedef NS_ENUM(NSInteger, APIRequestMethod){
    API_Get,//get
    API_POST,//post
    API_DELET,
    API_PUT,
    API_PATH_GET,//path/{xxx}
};

#endif /* APIDefine_h */
