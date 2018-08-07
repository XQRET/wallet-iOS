//
//  AvailableAssetsController.m
//  BlockChain
//
//  Created by Hugin on 2018/8/1.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import "AvailableAssetsController.h"

@interface AvailableAssetsController ()

@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
@property (weak, nonatomic) IBOutlet UIView *contentView1;
@property (weak, nonatomic) IBOutlet UIView *contentView2;

@end

@implementation AvailableAssetsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    [self setupNavBar];
    
    [_contentView1.layer setLayerShadow:kHexColor(0xdae1ff) offset:CGSizeMake(0, 0) radius:8.f];
    _contentView1.layer.cornerRadius = 6;
    
    [_contentView2.layer setLayerShadow:kHexColor(0xdae1ff) offset:CGSizeMake(0, 0) radius:8.f];
    _contentView2.layer.cornerRadius = 6;
}

- (void)setupNavBar {
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    [self.view addSubview:self.customNavBar];
    self.customNavBar.title = @"可用资产";
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    [self.customNavBar wr_setBottomLineHidden:YES];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"nav_banck_white"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"nav_bar_bg"];
    [self.customNavBar updateFrame];
}


@end
