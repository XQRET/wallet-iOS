//
//  AssetsTableController.m
//  BlockChain
//
//  Created by Hugin on 2018/8/2.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import "AssetsTableController.h"
#import "AssetsDetailsController.h"

@interface AssetsTableController ()

@end

@implementation AssetsTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.tableView.rowHeight = 135;
    switch (_type) {
        case TableTypeFixedAssets: {
            
        } break;
        case TableTypeNonFixed: {
            
        } break;
        case TableTypeAssetsTransfer: {
            self.tableView.tableHeaderView = [UIView new];
        } break;
    }
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (_type) {
        case TableTypeFixedAssets: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"fixed_nonFixed" forIndexPath:indexPath];
        } break;
        case TableTypeNonFixed: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"fixed_nonFixed" forIndexPath:indexPath];
        } break;
        case TableTypeAssetsTransfer: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"transfer" forIndexPath:indexPath];
        } break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AssetsDetailsController *vc = [[UIStoryboard storyboardWithName:@"AssetsDetailsController" bundle:nil] instantiateInitialViewController];
    switch (_type) {
        case TableTypeFixedAssets: {
            vc.type = AssetsTpyeFixedAssets;
        } break;
        case TableTypeNonFixed: {
            vc.type = AssetsTpyeNonFixed;
        } break;
        case TableTypeAssetsTransfer: {
            vc.type = AssetsTpyeAssetsTransfer;
        } break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

@end
