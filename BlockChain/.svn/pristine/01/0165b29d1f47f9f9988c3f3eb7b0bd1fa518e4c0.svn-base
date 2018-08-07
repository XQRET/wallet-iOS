//
//  AuthorizationManager.h
//  NBS_Wallet
//
//  Created by nbs on 2018/5/16.
//  Copyright © 2018年 cn.inbs.wallet. All rights reserved.
//

#pragma mark - /**************** Clang ****************/

// 这里把 参数macro 转换成字符串 "macro"
#define ArgumentToString(macro) #macro
//// 这里把 clang diagnostic ignored warning_name 转换成 "clang diagnostic ignored warning_name"
//#define ClangWarningConcat(warning_name) ArgumentToString(clang diagnostic ignored warning_name)
//
//// 参数可直接传入 clang 的 warning 名，warning 列表参考：http://fuckingclangwarnings.com/
//// 这里把 warningName 转换成 _Pragma("clang diagnostic push") _Pragma(clang diagnostic ignored "#warningName")
//// _Pragma(参数) 转换成字符串 #pragma 参数
//#define BeginIgnoreClangWarning(warningName) _Pragma("clang diagnostic push") _Pragma(ClangWarningConcat(#warningName))
//// 这里代表 #pragma clang diagnostic pop
//#define EndIgnoreClangWarning _Pragma("clang diagnostic pop")

#define IgnoreDeprecatedWarning(codeBlock) _Pragma("clang diagnostic push")\
_Pragma(ArgumentToString(clang diagnostic ignored "-Wdeprecated-declarations"))\
codeBlock;\
_Pragma("clang diagnostic pop")\

// 方法弃用警告
//#define BeginIgnoreDeprecatedWarning BeginIgnoreClangWarning(-Wdeprecated-declarations)
//#define EndIgnoreDeprecatedWarning EndIgnoreClangWarning

#pragma mark 

#import <Foundation/Foundation.h>

@interface AuthorizationManager : NSObject


/** 向系统请求相机权限 */
+ (void)requestAccessForPhotoLibrary;
//+ (void)requestAccessForPhotoLibrary:(void (^)(PHAuthorizationStatus status))handlerBlock;
/** 返回相册是否授权 */
+ (BOOL)examinePhotoLibraryAuthorizationStatus;

/** 向系统请求相机权限 */
+ (void)requestAccessForVideoMedia;
/** 返回相机是否授权 */
+ (BOOL)examineVideoMediaAuthorizationStatus;

/** 向系统请求相册和相机权限 */
+ (void)requestAccessForPhotoLibraryAndVideoMedia;
/** 返回相册和相机是否全部授权 */
+ (BOOL)examinePhotoLibraryAndVideoMediaAuthorizationStatus;

/** 向系统请求通讯录权限 */
+ (void)requestAccessForContacts;
+ (void)requestAccessForContacts:(void (^)(BOOL granted))handlerBlock;

/** 返回通讯录是否授权 */
+ (BOOL)examinerContactsAuthorizationStatus;

@end
