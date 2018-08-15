
//
//  TransferAassetsController.m
//  BlockChain
//
//  Created by nbs on 2018/7/31.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import "TransferAassetsController.h"


@interface TransferAassetsController ()
@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;

@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *currencyBtn;

@property (assign, nonatomic) CurrencyType currentCurrency;

@end

@implementation TransferAassetsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    
    [_selectView.layer setLayerShadow:kHexColor(0xe4e9ff) offset:CGSizeMake(0, 0) radius:5.f];
    _selectView.layer.borderColor = kHexColor(0xe5e8e8).CGColor;
    _selectView.layer.borderWidth = 1;
    
    _currentCurrency = CurrencyTypeETH;
}

- (void)setupNavBar {
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    [self.view addSubview:self.customNavBar];
    self.customNavBar.title = @"转账";
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"nav_bar_bg"];
    [self.customNavBar wr_setBottomLineHidden:YES];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"nav_banck_white"]];
    [self.customNavBar updateFrame];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (IBAction)clickConversion:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    [self changeView:_selectView willDisplay:sender.selected forHeightConstraint:_selectViewHeightConstraint];
}

- (void)changeView:(UIView *)v willDisplay:(BOOL)display forHeightConstraint:(NSLayoutConstraint *)constraint {
    if (display) {
        constraint.constant = 90;
        [UIView animateWithDuration: 0.25 delay: 0 usingSpringWithDamping: 0.5 initialSpringVelocity: 5 options: UIViewAnimationOptionCurveEaseInOut  animations:^{
            [v layoutIfNeeded];
            v.alpha = 1;
        } completion:nil];
    } else {
        constraint.constant = 0;
        [UIView animateWithDuration: 0.25 delay: 0 usingSpringWithDamping: 0.5 initialSpringVelocity: 5 options: UIViewAnimationOptionCurveEaseInOut  animations:^{
            [v layoutIfNeeded];
            v.alpha = 0;
        } completion:nil];
    }
}

- (IBAction)clickSwitch:(UIButton *)sender {
    switch (sender.tag) {
        case CurrencyTypeETH: {
            _currentCurrency = CurrencyTypeETH;
            [_currencyBtn setTitle:@"ETH" forState:UIControlStateNormal];
        } break;
        case CurrencyTypeRET: {
            _currentCurrency = CurrencyTypeRET;
            [_currencyBtn setTitle:@"RET" forState:UIControlStateNormal];
        } break;
    }
    [self clickConversion:_currencyBtn];
}


@end
