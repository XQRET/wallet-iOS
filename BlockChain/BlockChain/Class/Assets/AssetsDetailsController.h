//
//  AssetsDetailsController.h
//  BlockChain
//
//  Created by Hugin on 2018/8/2.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, AssetsTpye) {
    AssetsTpyeFixedAssets,
    AssetsTpyeNonFixed,
    AssetsTpyeAssetsTransfer,
};
@interface AssetsDetailsController : UIViewController

@property (nonatomic, assign) AssetsTpye type;

@end
