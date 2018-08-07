//
//  AccountSecurityController.m
//  BlockChain
//
//  Created by nbs on 2018/7/17.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import "AccountSecurityController.h"

@interface AccountSecurityController ()

@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;

@end

@implementation AccountSecurityController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setupUI];
}

- (void)setupUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self setupNavBar];
    

    if (kScreenHeight == 414) {
        self.tableView.tableHeaderView.height = 226.5 + 45;
        self.topImage.image = [UIImage imageNamed:@"security_i7p"];
    } else if (kScreenHeight == 375) {
        if (kScreenHeight == 812) {
            self.tableView.tableHeaderView.height = 227 + 45;
            self.topImage.image = [UIImage imageNamed:@"security_x"];
        } else {
            self.tableView.tableHeaderView.height = 205 + 45;
            self.topImage.image = [UIImage imageNamed:@"security_i7"];
        }
    } else if (kScreenHeight == 320) {
        self.tableView.tableHeaderView.height = 175.5 + 45;
        self.topImage.image = [UIImage imageNamed:@"security_se"];
    }
    
}

- (void)setupNavBar {
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    [self.view addSubview:self.customNavBar];
    self.customNavBar.title = @"账户安全";
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"nav_banck_white"]];
    [self.customNavBar updateFrame];
}

@end
