//
//  MainTabBarController.m
//  BlockChain
//
//  Created by nbs on 2018/7/11.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"
#import "WalletController.h"
#import "AssetsViewController.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self initMaintController];
}

- (void)initMaintController {
    
    UIViewController *vc1 = [WalletController new];
    [self addChildController:vc1 Title:@"钱包" imageName:@"tabbar_wallet"];
    
    UIViewController *vc2 = [[UIStoryboard storyboardWithName:@"AssetsViewController" bundle:nil] instantiateInitialViewController];
    [self addChildController:vc2 Title:@"资产" imageName:@"tabbar_assets"];
    
    UIViewController *vc3 = [[UIStoryboard storyboardWithName:@"MineController" bundle:nil] instantiateInitialViewController];
    [self addChildController:vc3 Title:@"个人中心" imageName:@"tabbar_center"]; 
}

- (void)addChildController:(UIViewController *)childController Title:(NSString *)title imageName:(NSString *)imageName {
    
    childController.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_select", imageName]];
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}


@end
