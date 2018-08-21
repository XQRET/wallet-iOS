//
//  ConfirmMnemonicsController.m
//  BlockChain
//
//  Created by Hugin on 2018/8/16.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import "ConfirmMnemonicsController.h"

@interface ConfirmMnemonicsController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *confirmCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *selectCollectionView;

@property (strong, nonatomic) NSMutableArray *confirmArr;
@property (strong, nonatomic) NSMutableArray *selectArr;

@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
@end

@implementation ConfirmMnemonicsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    _confirmArr = [NSMutableArray arrayWithCapacity:6];
    
    _selectArr = [NSMutableArray arrayWithCapacity:6];
    [_selectArr addObjectsFromArray:@[@"original", @"odor", @"often", @"only", @"opinion", @"oppose", @"other", @"process", @"people", @"popular", @"portion", @"positions"]];
}

- (void)setupUI {
    
    UICollectionViewFlowLayout *layout1 = [[UICollectionViewFlowLayout alloc] init];
    layout1.itemSize = CGSizeMake((kScreenWidth - 20) / 3, 45);
    layout1.minimumLineSpacing = 0;
    layout1.minimumInteritemSpacing = 0;
    layout1.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [_confirmCollectionView setCollectionViewLayout:layout1];
    _confirmCollectionView.layer.cornerRadius = 10;
    
    
    UICollectionViewFlowLayout *layout2 = [[UICollectionViewFlowLayout alloc] init];
    layout2.minimumLineSpacing = 6;
    layout2.minimumInteritemSpacing = 16;
    
    [_selectCollectionView setCollectionViewLayout:layout2];
    
    [self setupNavBar];
 
}

- (void)setupNavBar {
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    [self.view addSubview:self.customNavBar];
    self.customNavBar.title = @"确认助记词";
    self.customNavBar.titleLabelColor = [UIColor blackColor]; 
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"nav_banck_black"]];
    [self.customNavBar updateFrame];
}

#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_confirmCollectionView == collectionView) {
        return _confirmArr.count;
    } else {
        return _selectArr.count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    
    if (_confirmCollectionView == collectionView) {
         cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"confirmCell" forIndexPath:indexPath];
        ((UILabel *)(cell.subviews[0].subviews[0])).text = _confirmArr[indexPath.row];
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"selectCell2" forIndexPath:indexPath];
        ((UILabel *)(cell.subviews[0].subviews[0])).text = _selectArr[indexPath.row];
        
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (_confirmCollectionView == collectionView) {
        NSString *str = [_confirmArr objectAtIndex:indexPath.row];
        [_confirmArr removeObject:str];
        [_selectArr addObject:str];
    } else {
        NSString *str = [_selectArr objectAtIndex:indexPath.row];
        [_selectArr removeObject:str];
        [_confirmArr addObject:str];
    }
    [_confirmCollectionView reloadData];
    [_selectCollectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_confirmCollectionView == collectionView) {
        return CGSizeMake((kScreenWidth - 20) / 3, 45);
    } else {
        CGSize size = [_selectArr[indexPath.row] sizeWithFont:[UIFont boldSystemFontOfSize:14.0f] constrainedToSize:CGSizeMake(self.view.frame.size.width, 300) lineBreakMode:NSLineBreakByWordWrapping];
        NSLog(@"%@", NSStringFromCGSize(size));
        return CGSizeMake(size.width + 16, size.height + 12);
    }
}


@end


