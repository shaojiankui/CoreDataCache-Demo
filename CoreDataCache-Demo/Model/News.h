//
//  News.h
//  CoreDataCache-Demo
//
//  Created by Jakey on 15/1/30.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "BaseModel.h"

@interface News : BaseModel
@property (nonatomic, strong) NSString *newsid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, strong) NSString *imgurl;
@property (nonatomic, strong) NSString *islook;//0未查看1已查看

+ (NSURLSessionDataTask *)login:(NSDictionary *)paramDic
                        Success:(void (^)(NSDictionary *result))success
                        Failure:(void (^)(NSError *error))failue;
@end
