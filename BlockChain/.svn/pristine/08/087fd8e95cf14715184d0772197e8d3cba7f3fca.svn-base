//
//  ReceivablesController.m
//  BlockChain
//
//  Created by Hugin on 2018/8/1.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import "ReceivablesController.h"

@interface ReceivablesController ()

@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@end

@implementation ReceivablesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    [self setupNavBar];
    
    [_contentView.layer setLayerShadow:kHexColor(0xacbffc) offset:CGSizeMake(0, 0) radius:5.f];
    _contentView.layer.cornerRadius = 6;
}

- (void)setupNavBar {
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    [self.view addSubview:self.customNavBar];
    self.customNavBar.title = @"收款";
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"nav_banck_white"]];
    [self.customNavBar wr_setRightButtonWithTitle:@"分享" titleColor:[UIColor whiteColor]];
    [self.customNavBar updateFrame];
}

 
@end
