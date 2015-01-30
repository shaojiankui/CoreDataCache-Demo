//
//  APIManager.m
//  CoreDataCache-Demo
//
//  Created by Jakey on 14-9-26.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "APIManager.h"

static dispatch_once_t onceToken;
static APIManager *_sharedClient = nil;

@implementation APIManager
+ (instancetype)sharedClient {
    
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[APIManager alloc] initWithBaseURL:[NSURL URLWithString:URI_SERVER_ADDRESS]];
        
        [_sharedClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
        
        [_sharedClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"3G网络已连接");
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"WiFi网络已连接");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"网络连接失败");
                    break;
                    
                default:
                    break;
            }
        }];
        [_sharedClient.reachabilityManager startMonitoring];
    });

   // _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
    //响应json数据
    _sharedClient.responseSerializer  = [AFJSONResponseSerializer serializer];
    
    //发送二进制数据
    _sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
    //响应二进制数据
    //_sharedClient.responseSerializer  = [AFHTTPResponseSerializer serializer];
    
    //设置响应内容格式
    _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    return _sharedClient;
}
@end