//
//  AppConfigController.h
//  BlockChain
//
//  Created by nbs on 2018/7/19.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AppConfigType) {
    AppConfigTypeLanguage,
    AppConfigTypeCurrency
};

@interface AppConfigController : UIViewController

@property (nonatomic, assign) AppConfigType type;

@end
