//
//  Constants.h
//  CoreDataCache-Demo
//
//  Created by Jakey on 14/12/31.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//
#ifdef SYNTHESIZE_CONSTS
# define CONST(name, value) NSString* const name = @ value
#else
# define CONST(name, value) extern NSString* const name
#endif

#import <Foundation/Foundation.h>



//Interface
#pragma --mark Interface

CONST(URI_SERVER_ADDRESS, "");






















































































@interface Constant : NSObject
//@property (readonly) NSString *uri_server_address;
//+ (Constant *)sharedConstant;
@end
