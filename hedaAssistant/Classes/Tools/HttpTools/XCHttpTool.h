//
//  XCHttpTool.h
//  hedaAssistant
//
//  Created by bear on 16/3/23.
//  Copyright © 2016年 bear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface XCHttpTool : NSObject

+(void)GET:(NSString *)URLString
parameters:(id)parameters
   success:(void (^)(id responseObject))success
   failure:(void (^)(NSError *error))failure;


+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;



@end
