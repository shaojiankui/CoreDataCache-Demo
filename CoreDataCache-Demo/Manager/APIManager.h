//
//  APIManager.h
//  CoreDataCache-Demo
//
//  Created by Jakey on 14-9-26.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import <Foundation/Foundation.h>
#import "Constant.h"
@interface APIManager : AFHTTPRequestOperationManager
+ (instancetype)sharedClient;
@end
