//
//  ImportWalletController.m
//  BlockChain
//
//  Created by Hugin on 2018/8/20.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import "ImportWalletController.h"

@interface ImportWalletController ()<UITableViewDataSource>
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *containerViews;

@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
@end

@implementation ImportWalletController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI {
    [_containerViews enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.layer.borderColor = kHexColor(0xfafbff).CGColor;
        obj.layer.borderWidth = 0.5;
        obj.layer.cornerRadius = 6;
        
        obj.layer.shadowColor = kHexColor(0xdae1ff).CGColor;
        obj.layer.shadowOffset = CGSizeMake(0, 0);
        obj.layer.shadowOpacity = 0.5f;
    }];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    if (kScreenHeight == 812) {
        self.tableView.tableHeaderView.height = 133;
    } else {
        self.tableView.tableHeaderView.height = 109;
    }
    
    [self setupNavBar];
}

- (void)setupNavBar {
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    [self.view addSubview:self.customNavBar];
    self.customNavBar.title = @"导入钱包";
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"nav_banck_black"]];
    [self.customNavBar updateFrame];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *vc;
    switch (indexPath.row) {
        case 0: {
            vc = [[UIStoryboard storyboardWithName:@"ImportFormController" bundle:nil] instantiateViewControllerWithIdentifier:@"mnemonic"];
        } break;
        case 1: {
            vc = [[UIStoryboard storyboardWithName:@"ImportFormController" bundle:nil] instantiateViewControllerWithIdentifier:@"keystore"];
        } break;
        case 2: {
            vc = [[UIStoryboard storyboardWithName:@"ImportFormController" bundle:nil] instantiateViewControllerWithIdentifier:@"key"];
        } break;
    }
    
    // 点击效果
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [[tableView visibleCells] enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:cell]) {
            obj.contentView.subviews.firstObject.subviews.firstObject.hidden = NO;
            [(UILabel *)(obj.contentView.subviews.firstObject.subviews[1]) setTextColor:[UIColor whiteColor]];
            [(UILabel *)(obj.contentView.subviews.firstObject.subviews[2]) setTextColor:kHexColor(0xb9befa)];
        } else {
            obj.contentView.subviews.firstObject.subviews.firstObject.hidden = YES;
            [(UILabel *)(obj.contentView.subviews.firstObject.subviews[1]) setTextColor:kHexColor(0x5371f7)];
            [(UILabel *)(obj.contentView.subviews.firstObject.subviews[2]) setTextColor:kHexColor(0x949494)];
        }
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cell.contentView.subviews.firstObject.subviews.firstObject.hidden = YES;
        [(UILabel *)(cell.contentView.subviews.firstObject.subviews[1]) setTextColor:kHexColor(0x5371f7)];
        [(UILabel *)(cell.contentView.subviews.firstObject.subviews[2]) setTextColor:kHexColor(0x949494)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 效果结束后跳转
            [self.navigationController pushViewController:vc animated:YES];
        });
    });
}



@end
