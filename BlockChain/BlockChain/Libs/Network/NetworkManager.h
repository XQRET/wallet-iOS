//
//  NetworkManager.h
//  NBS_Wallet
//
//  Created by nbs on 2018/4/11.
//  Copyright © 2018年 cn.inbs.wallet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

#define kNetworkManager [NetworkManager sharedInstance]

typedef NS_ENUM(NSUInteger, HTTPMethod) {
    HTTPMethodGET = 1,
    HTTPMethodPOST,
    HTTPMethodPUT,
    HTTPMethodPATCH,
    HTTPMethodDELETE
};

typedef NS_ENUM(NSUInteger, NetworkStatus) {
    NetworkStatusUnknown = 1,
    NetworkStatusNotReachable,
    NetworkStatusReachableViaWWAN,
    NetworkStatusReachableViaWiFi
};

typedef void(^progressBlock)(NSProgress * _Nonnull progress);
typedef void(^successBlock)(NSURLSessionDataTask * _Nullable task, id _Nullable response);
typedef void(^failureBlock)(NSURLSessionDataTask * _Nullable task, NSString * _Nullable error);

@interface NetworkManager : NSObject

@property (nonatomic, assign) NetworkStatus networkStats;

@property(nonatomic, strong) AFHTTPSessionManager *sessionManager;

+ (nonnull instancetype)sharedInstance;
- (void)startMonitoring;

- (nullable NSURLSessionTask *)sendRequestMethod:(HTTPMethod)requestMethod
                                             url:(nonnull NSString *)url
                                       parameter:(nullable id)parameter
                                        progress:(nullable progressBlock)progress
                                         success:(nullable successBlock)success
                                         failure:(nullable failureBlock)failure;

- (nullable NSURLSessionTask *)postWithUrl:(nonnull NSString *)url
                                 parameter:(nullable id)parameter
                                   success:(nullable successBlock)success
                                   failure:(nullable failureBlock)failure;

- (nullable NSURLSessionTask *)getWithUrl:(nonnull NSString *)url
                                parameter:(nullable id)parameter
                                  success:(nullable successBlock)success
                                  failure:(nullable failureBlock)failure;


- (nullable NSURLSessionTask *)uploadImageWithUrl:(nonnull NSString *)url
                                        imageData:(nonnull NSData *)imageData
                                    imageFileName:(nonnull NSString *)imageFileName
                               imageParameterName:(nonnull NSString *)imageParameterName
                                        parameter:(nullable id)parameter
                                         progress:(nullable progressBlock)progress
                                          success:(nullable successBlock)success
                                          failure:(nullable failureBlock)failure;

- (nullable NSURLSessionTask *)uploadMultipleImageWithUrl:(nonnull NSString *)url
                                            AddImageBlock:(void (^)(id <AFMultipartFormData> formData))block
                                                parameter:(nullable id)parameter
                                                 progress:(nullable progressBlock)progress
                                                  success:(nullable successBlock)success
                                                  failure:(nullable failureBlock)failure;

- (nullable NSURLSessionTask *)uploadFileWithUrl:(nonnull NSString *)url
                                        fileData:(nonnull NSData *)fileData
                                   fileName:(nonnull NSString *)fileName
                              fileParameterName:(nonnull NSString *)fileParameterName
                                       parameter:(nullable id)parameter
                                        progress:(nullable progressBlock)progress
                                         success:(nullable successBlock)success
                                         failure:(nullable failureBlock)failure;

- (void)resetLoginStatus;

@end
