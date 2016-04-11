//
//  XCHttpTool.m
//  hedaAssistant
//
//  Created by bear on 16/3/23.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "XCHttpTool.h"

@implementation XCHttpTool


+(void)GET:(NSString *)URLString
parameters:(id)parameters
success:(void (^)(id responseObject))success
failure:(void (^)(NSError *error))failure{

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSURLRequest *request =[[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:parameters error:nil];


    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            failure(error);
        } else {
            success(responseObject);
        }
    }];
    [dataTask resume];

}



+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure{

    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager=[[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];

    NSURLRequest *request=[[AFHTTPRequestSerializer serializer]requestWithMethod:@"POST" URLString:URLString parameters:parameters error:nil];

    NSURLSessionDataTask *dataTask=[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {

        if (error) {
            failure(error);
        }else{
            success(responseObject);
        }
    }];

    [dataTask resume];

}




@end
