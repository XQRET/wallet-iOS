//
//  NetworkManager.m
//  NBS_Wallet
//
//  Created by nbs on 2018/4/11.
//  Copyright © 2018年 cn.inbs.wallet. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager()
@property(nonatomic, copy) NSString *baseURL;
@end

@implementation NetworkManager

+ (nonnull instancetype)sharedInstance {
    static NetworkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)startMonitoring {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                self.networkStats = NetworkStatusUnknown;
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络");
                self.networkStats = NetworkStatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                self.networkStats = NetworkStatusReachableViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                self.networkStats = NetworkStatusReachableViaWiFi;
                NSLog(@"WIFI");
                break;
        }
    }];
    [manager startMonitoring];
}

- (nonnull instancetype)init {
    self = [super init];
    if (self) {
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl]];
        self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.sessionManager.requestSerializer.timeoutInterval = 15.0;
        self.sessionManager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        
        self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"image/*"]];
    }
    return self;
}

- (nullable NSURLSessionTask *)sendRequestMethod:(HTTPMethod)requestMethod
                                             url:(nonnull NSString *)url
                                      parameters:(nullable id)parameters
                                        progress:(nullable progressBlock)progress
                                         success:(nullable successBlock)success
                                         failure:(nullable failureBlock)failure {
    
    NSLog(@"\n请求地址:%@%@", kBaseUrl, url);
    NSLog(@"\n请求参数:%@", parameters);
    if (self.networkStats == NetworkStatusNotReachable) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"没有网络，请检查网络"];
        return nil;
    }
    
    NSURLSessionTask *task = nil;
    switch (requestMethod) {
        case HTTPMethodGET: {
            task = [self.sessionManager GET:url parameters:parameters progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"\nresponseObject:%@", responseObject);
                success ? success(task, responseObject) : NULL;
//                // 这里登录失效，弹出登录页面
//                if ([responseObject[@"code"] intValue] == -9998) {
//                    [SVProgressHUD dismiss];
//                    [SVProgressHUD showErrorWithStatus:@"当前账号登录新状态已失效!"];
//                    [self resetLoginStatus];
//                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
                [SVProgressHUD showErrorWithStatus:@"服务器维护升级中，请耐心等待!"];
                failure ? failure(task, [self failHandleWithErrorResponse:error task:task]) : NULL;
            }];
        } break;
        case HTTPMethodPOST: {
            task = [self.sessionManager POST:url parameters:parameters progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"\nresponseObject:%@", responseObject);
                success ? success(task, responseObject) : NULL;
//                // 这里登录失效，弹出登录页面
//                if ([responseObject[@"code"] intValue] == -9998) {
//                    [SVProgressHUD dismiss];
//                    [SVProgressHUD showErrorWithStatus:@"当前账号登录新状态已失效!"];
//                    [self resetLoginStatus];
//                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
                [SVProgressHUD showErrorWithStatus:@"服务器维护升级中，请耐心等待!"];
                failure ? failure(task, [self failHandleWithErrorResponse:error task:task]) : NULL;
            }];
        } break;
        default:
            break;
    }

    NSLog(@"task.currentRequest.HTTPBody = %@", [[NSString alloc] initWithData:task.currentRequest.HTTPBody encoding:4]);
    return task;
}

- (nullable NSURLSessionTask *)postWithUrl:(nonnull NSString *)url
                                 parameter:(nullable id)parameter
                                   success:(nullable successBlock)success
                                   failure:(nullable failureBlock)failure {
    return [self sendRequestMethod:HTTPMethodPOST url:url parameters:parameter progress:nil success:success failure:failure];
}

- (nullable NSURLSessionTask *)getWithUrl:(nonnull NSString *)url
                                parameter:(nullable id)parameter
                                  success:(nullable successBlock)success
                                  failure:(nullable failureBlock)failure {
    return [self sendRequestMethod:HTTPMethodPOST url:url parameters:parameter progress:nil success:success failure:failure];
}

- (nullable NSURLSessionTask *)uploadImageWithUrl:(nonnull NSString *)url
                                        imageData:(nonnull NSData *)imageData
                                    imageFileName:(nonnull NSString *)imageFileName
                               imageParameterName:(nonnull NSString *)imageParameterName
                                        parameter:(nullable id)parameter
                                         progress:(nullable progressBlock)progress
                                          success:(nullable successBlock)success
                                          failure:(nullable failureBlock)failure {
    
    
    NSLog(@"\n请求地址:%@%@", kBaseUrl, url);
    NSLog(@"\n请求参数:%@", parameter);
    if (self.networkStats == NetworkStatusNotReachable) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"没有网络，请检查网络"];
        return nil;
    }
    
    NSURLSessionTask *task = nil;
    
    task = [self.sessionManager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:imageParameterName fileName:imageFileName mimeType:@"image/jpeg"];
    } progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\nresponseObject:%@", responseObject);
        success ? success(task, responseObject) : NULL;
        // 这里登录失效，弹出登录页面
        if ([responseObject[@"code"] intValue] == -9998) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"当前账号登录新状态已失效!"];
            [self resetLoginStatus];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"服务器维护升级中，请耐心等待!"];
        failure ? failure(task, [self failHandleWithErrorResponse:error task:task]) : NULL;
    }];
    
    return task;
}

- (nullable NSURLSessionTask *)uploadMultipleImageWithUrl:(nonnull NSString *)url
                                            AddImageBlock:(void (^)(id <AFMultipartFormData> formData))block
                                                parameter:(nullable id)parameter
                                                 progress:(nullable progressBlock)progress
                                                  success:(nullable successBlock)success
                                                  failure:(nullable failureBlock)failure {
    
    NSLog(@"\n请求地址:%@%@", kBaseUrl, url);
    NSLog(@"\n请求参数:%@", parameter);
    if (self.networkStats == NetworkStatusNotReachable) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"没有网络，请检查网络"];
        return nil;
    }
    
    NSURLSessionTask *task = nil;
    
    task = [self.sessionManager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        block ? block(formData) : NULL;
    } progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\nresponseObject:%@", responseObject);
        success ? success(task, responseObject) : NULL;
        // 这里登录失效，弹出登录页面
        if ([responseObject[@"code"] intValue] == -9998) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"当前账号登录新状态已失效!"];
            [self resetLoginStatus];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"服务器维护升级中，请耐心等待!"];
        failure ? failure(task, [self failHandleWithErrorResponse:error task:task]) : NULL;
    }];
    
    return task;
}

- (nullable NSURLSessionTask *)uploadFileWithUrl:(nonnull NSString *)url
                                        fileData:(nonnull NSData *)fileData
                                        fileName:(nonnull NSString *)fileName
                               fileParameterName:(nonnull NSString *)fileParameterName
                                       parameter:(nullable id)parameter
                                        progress:(nullable progressBlock)progress
                                         success:(nullable successBlock)success
                                         failure:(nullable failureBlock)failure {
    
    NSLog(@"\n请求地址:%@%@", kBaseUrl, url);
    NSLog(@"\n请求参数:%@", parameter);
    if (self.networkStats == NetworkStatusNotReachable) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"没有网络，请检查网络"];
        return nil;
    }
    
    NSURLSessionTask *task = nil;
    
    task = [self.sessionManager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:fileParameterName fileName:fileName mimeType:@"text/plain"];
    } progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\nresponseObject:%@", responseObject);
        success ? success(task, responseObject) : NULL;
        // 这里登录失效，弹出登录页面
        if ([responseObject[@"code"] intValue] == -9998) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"当前账号登录新状态已失效!"];
            [self resetLoginStatus];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"服务器维护升级中，请耐心等待!"];
        NSLog(@"服务器维护中，请耐心等待");
        failure ? failure(task, [self failHandleWithErrorResponse:error task:task]) : NULL;
    }];
    
    return task;
}

- (NSString *)failHandleWithErrorResponse:(NSError * _Nullable)error task:(NSURLSessionDataTask * _Nullable)task {
    
    __block NSString *message = nil;
    NSData *af_errorMsg = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseErrorKey];
    NSLog(@"af_errorMsg == %@", af_errorMsg);
    
    if (!af_errorMsg) {
        message = @"网络连接失败";
        NSLog(@"网络连接失败");
    }
    
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSInteger responseStatue = response.statusCode;
    
    if (responseStatue >= 500) {
        message = @"服务器维护升级中，请耐心等待";
    } else if(responseStatue >= 400) {
        message = @"请求出现问题";
    }
    NSLog(@"%@", [NSString stringWithFormat:@"请求出错 code: %ld", (long)responseStatue]);
    return message;
}

- (void)resetLoginStatus {
    
    UITabBarController *vc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    // 弹出登录界面
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[UIStoryboard storyboardWithName:@"LoginController" bundle:nil] instantiateInitialViewController]];
        [vc.selectedViewController presentViewController:nav animated:YES completion:^{
            [vc.selectedViewController popToRootViewControllerAnimated:NO];
            vc.selectedIndex = 0;
        }];
    });
}

@end
