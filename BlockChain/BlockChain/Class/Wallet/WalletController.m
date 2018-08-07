//
//  WalletController.m
//  BlockChain
//
//  Created by nbs on 2018/7/11.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import "WalletController.h"

#define kSubviewWidth (kScreenWidth - 30)

@interface WalletController ()<UIScrollViewDelegate>

@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
@property (nonatomic, strong) UIScrollView *scrollV;

@property (nonatomic, strong) UIView *topSubview;
@property (nonatomic, strong) UIView *middleSubview;
@property (nonatomic, strong) UIView *bottomSubview;

@end

@implementation WalletController


- (UIScrollView *)scrollV {
    if (_scrollV == nil) {
        _scrollV = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollV.backgroundColor = [UIColor whiteColor];
        _scrollV.showsVerticalScrollIndicator = NO;
        _scrollV.showsHorizontalScrollIndicator = NO;
        _scrollV.bounces = NO;
        _scrollV.delegate = self;
      
    }
    return _scrollV;
}

- (UIView *)topSubview {
    if (_topSubview == nil) {
        UIView *topSubview = [[UIView alloc] initWithFrame:CGRectZero];
        topSubview.backgroundColor = [UIColor whiteColor];
        topSubview.layer.cornerRadius = 5;
        topSubview.layer.shadowColor = kHexColor(0xacbffc).CGColor;
        topSubview.layer.shadowOffset = CGSizeMake(2, 3);
        topSubview.layer.shadowOpacity = 0.8f;
        _topSubview = topSubview;
        
        CGFloat ling_y;
        if (kScreenWidth == 320) {
            ling_y = 290;
        } else if(kScreenWidth == 375){
            ling_y = 320;
        } else {
            ling_y = 360;
        }
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        [path moveToPoint:CGPointMake(15, ling_y)];
        [path addLineToPoint:CGPointMake((kScreenWidth - 30) / 2.0 - 6, ling_y)];
        
        [path moveToPoint:CGPointMake((kScreenWidth - 30) / 2.0 - 6, ling_y)];
        [path addLineToPoint:CGPointMake((kScreenWidth - 30) / 2.0, ling_y - 6)];
        
        [path moveToPoint:CGPointMake((kScreenWidth - 30) / 2.0, ling_y - 6)];
        [path addLineToPoint:CGPointMake((kScreenWidth - 30) / 2.0 + 6, ling_y)];
        
        [path moveToPoint:CGPointMake((kScreenWidth - 30) / 2.0 + 6, ling_y)];
        [path addLineToPoint:CGPointMake(kSubviewWidth - 15, ling_y)];

        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = CGRectMake(0, 0, kSubviewWidth, 370);
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = kHexColor(0xadece9).CGColor;
        shapeLayer.lineWidth = 1;
        [topSubview.layer addSublayer:shapeLayer];
        
        
        
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wallet_circle"]];
        [topSubview addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (kScreenWidth == 320) {
                make.size.mas_equalTo(CGSizeMake(kScreenWidth - 60, kScreenWidth - 60));
            } else {
                make.size.mas_equalTo(CGSizeMake(kScreenWidth - 90, kScreenWidth - 90));
            }
            make.centerX.equalTo(topSubview);
            make.top.equalTo(topSubview).mas_offset(20);
        }];
        
        UILabel *l1 = [[UILabel alloc] init];
        l1.text = @"≈3150 RMB";
        l1.textColor = kHexColor(0x949494);
        l1.font = [UIFont systemFontOfSize:15];
        [l1 sizeToFit];
        [topSubview addSubview:l1];
        [l1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(iv);
            make.centerX.equalTo(iv).mas_offset(l1.width / 2.0);
        }];
        
        UILabel *l2 = [[UILabel alloc] init];
        l2.text = @"31500";
        l2.textColor = kHexColor(0x5271f6);
        l2.font = [UIFont systemFontOfSize:26];
        [l2 sizeToFit];
        [topSubview addSubview:l2];
        [l2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(l1.mas_top).mas_offset(-16);
            make.centerX.equalTo(iv);
        }];
    
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"总资产(Token)" forState:UIControlStateNormal];
        [btn setTitleColor:kHexColor(0xffffff) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setBackgroundImage:[UIImage imageNamed:@"wallet_btn_bg"] forState:UIControlStateNormal];
        [topSubview addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (kScreenWidth == 320) {
                make.size.mas_equalTo(CGSizeMake(kScreenWidth - 196, 45));
            } else {
                make.size.mas_equalTo(CGSizeMake(kScreenWidth - 216, 45));
            }
            make.centerX.equalTo(iv);
            make.top.equalTo(l1.mas_bottom).mas_offset(15);
        }];
        
        UILabel *l3 = [[UILabel alloc] init];
        l3.text = @"可用资产";
        l3.textColor = kHexColor(0x333333);
        l3.font = [UIFont systemFontOfSize:16];
        [l3 sizeToFit];
        [topSubview addSubview:l3];
        [l3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topSubview).offset(15);
            make.bottom.equalTo(topSubview).offset(-15);
        }];
        
        UILabel *l4 = [[UILabel alloc] init];
        l4.text = @"1500 Token";
        l4.textColor = kHexColor(0x333333);
        l4.font = [UIFont systemFontOfSize:16];
        [l4 sizeToFit];
        [topSubview addSubview:l4];
        [l4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(topSubview).offset(-32);
            make.bottom.equalTo(topSubview).offset(-15);
        }];
        
        UIImageView *rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_add"]];
        [rightArrow sizeToFit];
        [topSubview addSubview:rightArrow];
        [rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(l4);
            make.left.equalTo(l4.mas_right).mas_offset(6);
        }];
        
        UIButton *assetsBtn = [[UIButton alloc] init];
        assetsBtn.backgroundColor = [UIColor clearColor];
        [topSubview addSubview:assetsBtn];
        [assetsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(l3);
            make.right.centerY.equalTo(rightArrow);
            make.height.mas_equalTo(40);
        }];
        [assetsBtn addTarget:self action:@selector(clickShowAssets:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _topSubview;
}

- (void)clickShowAssets:(UIButton *)sender {
    kReduceButtonFrequency
    
    UIViewController *vc= [[UIStoryboard storyboardWithName:@"AvailableAssetsController" bundle:nil] instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (UIView *)middleSubview {
    if (_middleSubview == nil) {
        UIView *middleSubview = [[UIView alloc] initWithFrame:CGRectZero];
        middleSubview.backgroundColor = [UIColor whiteColor];
        middleSubview.layer.cornerRadius = 5;
        middleSubview.layer.shadowColor = kHexColor(0xacbffc).CGColor;
        middleSubview.layer.shadowOffset = CGSizeMake(2, 3);
        middleSubview.layer.shadowOpacity = 0.8f;
        _middleSubview = middleSubview;
 
 
        CGFloat btn_w = (kSubviewWidth - 16 * 4) / 3.0;
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn1 setImage:[UIImage imageNamed:@"wallet_transfer"] forState:UIControlStateNormal];
        [btn1 setTitle:@"转账" forState:UIControlStateNormal];
        [btn1 setTitleColor:kHexColor(0x333333) forState:UIControlStateNormal];
        btn1.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn1 setImageEdgeInsets:UIEdgeInsetsMake(-28, 0, 0, -39)];
        [btn1 setTitleEdgeInsets:UIEdgeInsetsMake(0, -33, -36, 0)];
        [middleSubview addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(btn_w);
            make.height.mas_equalTo(84);
            make.left.equalTo(middleSubview).mas_offset(16);
            make.top.equalTo(middleSubview).mas_offset(0);
        }];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn2 setImage:[UIImage imageNamed:@"wallet_qrcode"] forState:UIControlStateNormal];
        [btn2 setTitle:@"收款" forState:UIControlStateNormal];
        [btn2 setTitleColor:kHexColor(0x333333) forState:UIControlStateNormal];
        btn2.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn2 setImageEdgeInsets:UIEdgeInsetsMake(-28, 0, 0, -39)];
        [btn2 setTitleEdgeInsets:UIEdgeInsetsMake(0, -33, -36, 0)];
        [middleSubview addSubview:btn2];
        [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(btn_w);
            make.height.mas_equalTo(84);
            make.centerX.equalTo(middleSubview);
            make.top.equalTo(middleSubview).mas_offset(0);
        }];
        
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn3 setImage:[UIImage imageNamed:@"wallet_currency"] forState:UIControlStateNormal];
        [btn3 setTitle:@"换币" forState:UIControlStateNormal];
        [btn3 setTitleColor:kHexColor(0x333333) forState:UIControlStateNormal];
        btn3.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn3 setImageEdgeInsets:UIEdgeInsetsMake(-28, 0, 0, -39)];
        [btn3 setTitleEdgeInsets:UIEdgeInsetsMake(0, -33, -36, 0)];
        [middleSubview addSubview:btn3];
        [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(btn_w);
            make.height.mas_equalTo(84);
            make.right.equalTo(middleSubview).mas_offset(-16);
            make.top.equalTo(middleSubview).mas_offset(0);
        }];
        
        [btn1 addTarget:self action:@selector(clickTransferAassets:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 addTarget:self action:@selector(clickReceivables:) forControlEvents:UIControlEventTouchUpInside];
        [btn3 addTarget:self action:@selector(clickExchangeCurrency:) forControlEvents:UIControlEventTouchUpInside];
   
    }
    return _middleSubview;
}

- (void)clickTransferAassets:(UIButton *)sender {
    kReduceButtonFrequency
    UIViewController *vc= [[UIStoryboard storyboardWithName:@"TransferAassetsController" bundle:nil] instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickReceivables:(UIButton *)sender {
    kReduceButtonFrequency
    UIViewController *vc= [[UIStoryboard storyboardWithName:@"ReceivablesController" bundle:nil] instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickExchangeCurrency:(UIButton *)sender {
    kReduceButtonFrequency
    UIViewController *vc= [[UIStoryboard storyboardWithName:@"ExchangeCurrencyController" bundle:nil] instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIView *)bottomSubview {
    if (_bottomSubview == nil) {
        UIView *bottomSubview = [[UIView alloc] initWithFrame:CGRectZero];
        bottomSubview.backgroundColor = [UIColor whiteColor];
        bottomSubview.layer.cornerRadius = 5;
        bottomSubview.layer.shadowColor = kHexColor(0xacbffc).CGColor;
        bottomSubview.layer.shadowOffset = CGSizeMake(2, 3);
        bottomSubview.layer.shadowOpacity = 0.8f;
        _bottomSubview = bottomSubview;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 20, 5, 18)];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = CGRectMake(0, 0, kSubviewWidth, 294);
        shapeLayer.path = path.CGPath;
        shapeLayer.fillColor = kHexColor(0x108ee9).CGColor;
        [bottomSubview.layer addSublayer:shapeLayer];
        
        path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(15, 49.5)];
        [path addLineToPoint:CGPointMake(kSubviewWidth, 49.5)];
        shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = CGRectMake(0, 0, kSubviewWidth, 294);
        shapeLayer.path = path.CGPath;
        shapeLayer.lineWidth = 1;
        shapeLayer.strokeColor = kHexColor(0xe5e7e9).CGColor;
        [bottomSubview.layer addSublayer:shapeLayer];
        
        UILabel *l1 = [[UILabel alloc] init];
        l1.text = @"资产类型";
        l1.textColor = kHexColor(0x333333);
        l1.font = [UIFont systemFontOfSize:16];
        [bottomSubview addSubview:l1];
        [l1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomSubview).mas_offset(15);
            make.top.equalTo(bottomSubview).mas_offset(19);
        }];
        
        UILabel *l2 = [[UILabel alloc] init];
        l2.text = @"固收资产";
        l2.textColor = kHexColor(0x33404e);
        l2.font = [UIFont systemFontOfSize:16];
        [bottomSubview addSubview:l2];
        [l2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(l1);
            make.top.equalTo(l1.mas_bottom).mas_offset(35);
        }];
        
        UILabel *l3 = [[UILabel alloc] init];
        l3.text = @"非固收资产";
        l3.textColor = kHexColor(0x33404e);
        l3.font = [UIFont systemFontOfSize:16];
        [bottomSubview addSubview:l3];
        [l3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(l2);
            make.top.equalTo(l2.mas_bottom).mas_offset(36);
        }];
        
        UILabel *l4 = [[UILabel alloc] init];
        l4.text = @"资产转让";
        l4.textColor = kHexColor(0x33404e);
        l4.font = [UIFont systemFontOfSize:16];
        [bottomSubview addSubview:l4];
        [l4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(l3);
            make.top.equalTo(l3.mas_bottom).mas_offset(36);
        }];
        
        UILabel *r1_1 = [[UILabel alloc] init];
        r1_1.text = @"15000 Token";
        r1_1.textColor = kHexColor(0x333333);
        r1_1.font = [UIFont systemFontOfSize:16];
        [bottomSubview addSubview:r1_1];
        [r1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bottomSubview).mas_offset(-15);
            make.top.equalTo(l2).mas_offset(-12);
        }];
        
        UILabel *r1_2 = [[UILabel alloc] init];
        r1_2.text = @"￥1500";
        r1_2.textColor = kHexColor(0x949494);
        r1_2.font = [UIFont systemFontOfSize:14];
        [bottomSubview addSubview:r1_2];
        [r1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(r1_1);
            make.top.equalTo(r1_1.mas_bottom).mas_offset(5);
        }];
        
        UILabel *r2_1 = [[UILabel alloc] init];
        r2_1.text = @"1500 Token";
        r2_1.textColor = kHexColor(0x333333);
        r2_1.font = [UIFont systemFontOfSize:16];
        [bottomSubview addSubview:r2_1];
        [r2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(r1_1);
            make.top.equalTo(l3).mas_offset(-12);
        }];
     
        UILabel *r2_2 = [[UILabel alloc] init];
        r2_2.text = @"￥150";
        r2_2.textColor = kHexColor(0x949494);
        r2_2.font = [UIFont systemFontOfSize:14];
        [bottomSubview addSubview:r2_2];
        [r2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(r1_1);
            make.top.equalTo(r2_1.mas_bottom).mas_offset(5);
        }];
        
        UILabel *r3_1 = [[UILabel alloc] init];
        r3_1.text = @"15000 Token";
        r3_1.textColor = kHexColor(0x333333);
        r3_1.font = [UIFont systemFontOfSize:16];
        [bottomSubview addSubview:r3_1];
        [r3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(r1_1);
            make.top.equalTo(l4).mas_offset(-12);
        }];
        
        UILabel *r3_2 = [[UILabel alloc] init];
        r3_2.text = @"￥1500";
        r3_2.textColor = kHexColor(0x949494);
        r3_2.font = [UIFont systemFontOfSize:14];
        [bottomSubview addSubview:r3_2];
        [r3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(r1_1);
            make.top.equalTo(r3_1.mas_bottom).mas_offset(5);
        }];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"wallet_btn_border"] forState:UIControlStateNormal];
        [btn setTitle:@"购买合约资产" forState:UIControlStateNormal];
        [btn setTitleColor:kHexColor(0x3181fe) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [bottomSubview addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomSubview).mas_offset(15);
            make.right.equalTo(bottomSubview).mas_offset(-15);
            make.bottom.equalTo(bottomSubview).mas_offset(-15);
            make.height.mas_equalTo(50);
        }];
        
        
    }
    return _bottomSubview;
}

- (void)viewDidLoad {
    [super viewDidLoad]; 
    [self setupUI];
}

- (void)setupUI {
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.scrollV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self setupScrollUI];
    [self setupNavBar];
}

- (void)setupScrollUI {
    
    [self.view addSubview:self.scrollV];
    [self.scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view); 
        make.bottom.equalTo(self.view).mas_offset(-self.tabBarController.tabBar.height);
    }];
    
   
    
//    kScreenWidth * 250.0 / 375.0;
//    -60;
//    kScreenWidth * (kSubviewWidth) * 370 / 345;
//    15;
//    kScreenWidth * (kSubviewWidth) * 110 / 345;
//    15;
//    kScreenWidth * (kSubviewWidth) * 294 / 345;
//    15;
//
//    250.0;
//    -60;
//    370;
//    15;
//    110;
//    15;
//    294;
//    15;
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_top_bg"]];
    [self.scrollV addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.scrollV);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(250);
    }];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    v.backgroundColor = kHexColor(0xf2f8fb);
    [self.scrollV addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollV);
        make.top.equalTo(iv.mas_bottom);
        make.width.mas_equalTo(kScreenWidth);
 
        if (kScreenWidth == 320) {
            make.height.mas_equalTo(676);
        } else if(kScreenWidth == 375){
            make.height.mas_equalTo(706);
        } else {
            make.height.mas_equalTo(746);
        }
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (kScreenWidth == 320) {
            self.scrollV.contentSize = CGSizeMake(kScreenWidth, 955);
        } else if(kScreenWidth == 375){
            self.scrollV.contentSize = CGSizeMake(kScreenWidth, 985);
        } else {
            self.scrollV.contentSize = CGSizeMake(kScreenWidth, 1025);
        }
    });
    
    UILabel *l1 = [[UILabel alloc] init];
    l1.text = @"让你的不动产流动起来";
    l1.textColor = kHexColor(0xffffff);
    l1.font = [UIFont systemFontOfSize:26];
    [self.scrollV addSubview:l1];
    [l1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollV);
        make.top.equalTo(self.scrollV).mas_offset(64 + 35);
        
    }];
    
    UILabel *l2 = [[UILabel alloc] init];
    l2.text = @"1 Token = 0.1 RMB";
    l2.textColor = kHexColor(0xffffff);
    l2.font = [UIFont systemFontOfSize:16];
    [self.scrollV addSubview:l2];
    [l2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(l1);
        make.top.equalTo(l1.mas_bottom).mas_offset(16);
    }];
    
    // setup topSubview
    [self.scrollV addSubview:self.topSubview];
    [self.topSubview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(v).offset(-58);
        make.left.equalTo(self.scrollV).offset(15);
        make.width.mas_equalTo(kSubviewWidth);
        if (kScreenWidth == 320) {
            make.height.mas_equalTo(340);
        } else if(kScreenWidth == 375){
            make.height.mas_equalTo(370);
        } else {
            make.height.mas_equalTo(410);
        }
    }];
    
    // setup middleSubview
    [self.scrollV addSubview:self.middleSubview];
    [self.middleSubview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topSubview.mas_bottom).offset(15);
        make.left.equalTo(self.scrollV).offset(15);
        make.width.mas_equalTo(kSubviewWidth);
        make.height.mas_equalTo(84);
    }];

    // setup bottomSubview
    [self.scrollV addSubview:self.bottomSubview];
    [self.bottomSubview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleSubview.mas_bottom).offset(15);
        make.left.equalTo(self.scrollV).offset(15);
        make.width.mas_equalTo(kSubviewWidth);
        make.height.mas_equalTo(294);
    }];
    
}

- (void)setupNavBar {
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    [self.view addSubview:self.customNavBar];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"nav_bar_bg"];
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    self.customNavBar.title = self.title;
    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%lf", scrollView.contentOffset.y);
    if (scrollView.contentOffset.y <= 128) {
        [self.customNavBar wr_setBackgroundAlpha:0];
    } else {
        CGFloat alpha = scrollView.contentOffset.y / 128.0;
        [self.customNavBar wr_setBackgroundAlpha:alpha];
    }
}

@end
