//
//  AuthorizationManager.m
//  NBS_Wallet
//
//  Created by nbs on 2018/5/16.
//  Copyright © 2018年 cn.inbs.wallet. All rights reserved.
//

#import "AuthorizationManager.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <Contacts/Contacts.h>

@implementation AuthorizationManager

+ (void)requestAccessForPhotoLibrary {
    // 请求相册权限
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {}];
}
//+ (void)requestAccessForPhotoLibrary:(void (^)(PHAuthorizationStatus status))handlerBlock {
//    // 请求相册权限
//    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//        handlerBlock ? handlerBlock() : NULL;
//    }];
//}

+ (BOOL)examinePhotoLibraryAuthorizationStatus {
    // 查询相册权限
    if ([PHPhotoLibrary authorizationStatus] != PHAuthorizationStatusAuthorized) {
        return NO;
    }
    return YES;
}

+ (void)requestAccessForVideoMedia {
    // 请求相机权限
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {}];
}

+ (BOOL)examineVideoMediaAuthorizationStatus {
    // 查询相机权限
    if ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] != AVAuthorizationStatusAuthorized) {
        return NO;
    }
    return YES;
}

+ (void)requestAccessForPhotoLibraryAndVideoMedia {
    // 请求相册权限
    [[self class] requestAccessForPhotoLibrary];
    // 请求相机权限
    [[self class] requestAccessForVideoMedia];
}

+ (BOOL)examinePhotoLibraryAndVideoMediaAuthorizationStatus {
    // 查询相册权限
    if (![[self class] examinePhotoLibraryAuthorizationStatus]) {
        return NO;
    }
    // 查询相机权限
    if (![[self class] examineVideoMediaAuthorizationStatus]) {
        return NO;
    }
    return YES;
}

+ (void)requestAccessForContacts {
    // 通讯录权限
    [[self class] requestAccessForContacts:nil];
}

+ (void)requestAccessForContacts:(void (^)(BOOL granted))handlerBlock {
    // 通讯录权限
    [[[CNContactStore alloc] init] requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        handlerBlock ? handlerBlock(granted) : NULL;
    }];
    
}

+ (BOOL)examinerContactsAuthorizationStatus {
    // 查询通讯录权限
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] != CNAuthorizationStatusAuthorized) {
        return NO;
    }
    return YES;
}

@end
