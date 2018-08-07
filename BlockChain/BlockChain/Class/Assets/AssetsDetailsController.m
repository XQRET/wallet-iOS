//
//  AssetsDetailsController.m
//  BlockChain
//
//  Created by Hugin on 2018/8/2.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import "AssetsDetailsController.h"

@interface AssetsDetailsController ()

@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *topWarningView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topWarningViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UIView *bottomBuyView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomBuyViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *bottomBuyLabel1;
@property (weak, nonatomic) IBOutlet UILabel *bottomBuyLabel2;
@property (weak, nonatomic) IBOutlet UIButton *bottomBuyBtn;

@end

@implementation AssetsDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI { 
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self setupNavBar];
    
    switch (_type) {
        case AssetsTpyeFixedAssets: {
            self.customNavBar.title = @"固收资产详情";
            
            _topWarningView.hidden = YES;
            _topWarningViewHeightConstraint.constant = 0;
            
            _bottomBuyViewHeightConstraint.constant = 65;
            _bottomBuyLabel1.hidden = YES;
            _bottomBuyLabel2.hidden = YES;
        } break;
        case AssetsTpyeNonFixed: {
            self.customNavBar.title = @"非固收资产详情";
        } break;
        case AssetsTpyeAssetsTransfer: {
            self.customNavBar.title = @"固收转让详情";
            
            _topWarningView.hidden = YES;
            _topWarningViewHeightConstraint.constant = 0;
            
            _bottomBuyViewHeightConstraint.constant = 65;
            _bottomBuyLabel1.hidden = YES;
            _bottomBuyLabel2.hidden = YES;
            [_bottomBuyBtn setTitle:@"立即转让" forState:UIControlStateNormal];
        } break;
    }
    [self.view layoutIfNeeded];
}

- (void)setupNavBar {
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    [self.view addSubview:self.customNavBar];
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    [self.customNavBar wr_setBottomLineHidden:YES];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"nav_banck_white"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"nav_bar_bg"];
    [self.customNavBar updateFrame];
}

- (IBAction)clickBuy:(UIButton *)sender {
    kReduceButtonFrequency
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"AssetsBuyController" bundle:nil] instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
