//
//  AssetsViewController.m
//  BlockChain
//
//  Created by nbs on 2018/7/20.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import "AssetsViewController.h"
#import "AssetsTableController.h"

@interface AssetsViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *titleBarView;
@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;


@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topLineCentenX;
@property (weak, nonatomic) IBOutlet UIImageView *topLine;

@property (weak, nonatomic) IBOutlet UIView *fixedAssetsContainer;
@property (weak, nonatomic) IBOutlet UIView *nonFixedAssetsContainer;
@property (weak, nonatomic) IBOutlet UIView *assetsTransferContainer;


@end

@implementation AssetsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupContainer];
    
    self.topLineCentenX.constant = -(kScreenWidth - 32) / 3.0;
}

- (IBAction)clickTopBtn:(UIButton *)sender {
    switch (sender.tag) {
        case 0: {
            [UIView animateWithDuration:0.75 animations:^{
                self.topLineCentenX.constant = -sender.width;
            }];
            [_scrollView scrollToLeft];
        } break;
        case 1: {
            [UIView animateWithDuration:0.75 animations:^{
                self.topLineCentenX.constant = 0;
            }];
            [_scrollView scrollRectToVisible:CGRectMake(kScreenWidth, 0, _scrollView.width, _scrollView.height) animated:YES];
        } break;
        case 2: {
            [UIView animateWithDuration:0.75 animations:^{
                self.topLineCentenX.constant = sender.width;
            }];
            [_scrollView scrollToRight];
        } break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int index = scrollView.contentOffset.x / kScreenWidth;
    switch (index) {
        case 0: {
            [UIView animateWithDuration:0.75 animations:^{
                self.topLineCentenX.constant = -(kScreenWidth - 32) / 3.0;
            }];
        } break;
        case 1: {
            [UIView animateWithDuration:0.75 animations:^{
                self.topLineCentenX.constant = 0;
            }];
        } break;
        case 2: {
            [UIView animateWithDuration:0.75 animations:^{
                self.topLineCentenX.constant = (kScreenWidth - 32) / 3.0;
            }];
        } break;
    }
}

- (void)setupUI {
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self setupNavBar];
    [self.view bringSubviewToFront:self.customNavBar];
}

- (void)setupNavBar {
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    [self.view addSubview:self.customNavBar];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"nav_bar_bg"];
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    self.customNavBar.title = self.title;
    [self.customNavBar wr_setBottomLineHidden:YES];
}

- (void)setupContainer {
    AssetsTableController *vc1 = [[UIStoryboard storyboardWithName:@"AssetsTableController" bundle:nil] instantiateInitialViewController];
    vc1.type = TableTypeFixedAssets;
    [self addChildViewController:vc1];
    [_fixedAssetsContainer addSubview:vc1.view];
    [vc1 willMoveToParentViewController:self];
    
    AssetsTableController *vc2 = [[UIStoryboard storyboardWithName:@"AssetsTableController" bundle:nil] instantiateInitialViewController];
    vc2.type = TableTypeNonFixed;
    [self addChildViewController:vc2];
    [_nonFixedAssetsContainer addSubview:vc2.view];
    [vc2 willMoveToParentViewController:self];
    
    AssetsTableController *vc3 = [[UIStoryboard storyboardWithName:@"AssetsTableController" bundle:nil] instantiateInitialViewController];
    vc3.type = TableTypeAssetsTransfer;
    [self addChildViewController:vc3];
    [_assetsTransferContainer addSubview:vc3.view];
    [vc3 willMoveToParentViewController:self];
}


@end
