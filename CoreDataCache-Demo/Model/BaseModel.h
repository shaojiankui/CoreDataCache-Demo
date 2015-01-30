//
//  BaseModel.h
//  CoreDataCache-Demo
//
//  Created by Jakey on 15/1/30.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
#import "APIManager.h"
#import "NSDictionary+JsonString.h"
#import "NSString+DictionaryValue.h"
#import "Constant.h"
@interface BaseModel : Jastor
- (NSString *)json;
- (NSDictionary *)dictionary;
@end
