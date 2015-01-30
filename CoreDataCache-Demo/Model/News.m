//
//  News.m
//  CoreDataCache-Demo
//
//  Created by Jakey on 15/1/30.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "News.h"

@implementation News
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.islook = 0;
    }
    return self;
}

+ (AFHTTPRequestOperation *)login:(NSDictionary *)paramDic
                          Success:(void (^)(NSDictionary *result))success
                          Failure:(void (^)(NSError *error))failue{
    
    NSLog(@"paramDic rd:%@",paramDic);
    
    return [[APIManager sharedClient] POST:@"news" parameters:paramDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = responseObject;
        NSLog(@"result=%@",[result description]);
        
        if(result!=nil)
        {
            //User *user =  [User objectFromDictionary:[result objectForKey:KEY_SERVER_RESPONCE_SUCCESS]];
            success(result);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failue(error);
    }];
}

@end
