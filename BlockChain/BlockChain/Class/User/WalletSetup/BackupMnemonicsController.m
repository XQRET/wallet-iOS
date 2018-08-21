//
//  BackupMnemonicsController.m
//  BlockChain
//
//  Created by Hugin on 2018/8/16.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import "BackupMnemonicsController.h"

@interface BackupMnemonicsController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
@end

@implementation BackupMnemonicsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((kScreenWidth - 20) / 3, 45);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
    [_collectionView setCollectionViewLayout:layout];
    _collectionView.layer.cornerRadius = 10;
 
    [self setupNavBar];

}

- (void)setupNavBar {
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    [self.view addSubview:self.customNavBar];
    self.customNavBar.title = @"备份助记词";
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"nav_banck_black"]];
    [self.customNavBar updateFrame];
}

#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *arr = @[@"original", @"odor", @"often", @"only", @"opinion", @"oppose", @"other" @"process", @"people", @"popular", @"portion", @"position", @"possible"];
    ((UILabel *)(cell.subviews[0].subviews[0])).text = arr[indexPath.row];
    return cell;
}




@end
