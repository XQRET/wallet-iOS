//
//  ExchangeCurrencyController.m
//  BlockChain
//
//  Created by nbs on 2018/7/30.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import "ExchangeCurrencyController.h"

@interface ExchangeCurrencyController ()
@property (weak, nonatomic) IBOutlet UIView *selectView1;
@property (weak, nonatomic) IBOutlet UIView *selectView2;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn1;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectViewHeightConstraint1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectViewHeightConstraint2;

@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
@end

@implementation ExchangeCurrencyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    
    [_selectView1.layer setLayerShadow:kHexColor(0xe4e9ff) offset:CGSizeMake(0, 0) radius:5.f];
    _selectView1.layer.borderColor = kHexColor(0xe5e8e8).CGColor;
    _selectView1.layer.borderWidth = 1;
    _selectView1.alpha = 1;
    
    [_selectView2.layer setLayerShadow:kHexColor(0xe4e9ff) offset:CGSizeMake(0, 0) radius:5.f];
    _selectView2.layer.borderColor = kHexColor(0xe5e8e8).CGColor;
    _selectView2.layer.borderWidth = 1;
    _selectView2.alpha = 0;
    
}

- (void)setupNavBar {
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    [self.view addSubview:self.customNavBar];
    self.customNavBar.title = @"换币";
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
    switch (sender.tag) {
        case 10: {
            [self changeView:_selectView1 willDisplay:sender.selected forHeightConstraint:_selectViewHeightConstraint1];
        } break;
        case 20: {
            [self changeView:_selectView2 willDisplay:sender.selected forHeightConstraint:_selectViewHeightConstraint2];
        } break;
    }
}

- (void)changeView:(UIView *)v willDisplay:(BOOL)display forHeightConstraint:(NSLayoutConstraint *)constraint {
    if (display) {
        if ([v isEqual:_selectView1]) {
            if (self.selectBtn2.selected) {
                [self clickConversion:self.selectBtn2];
            }
        } else {
            if (self.selectBtn1.selected) {
                [self clickConversion:self.selectBtn1];
            }
        }
        constraint.constant = 90;
        [UIView animateWithDuration: 0.75 delay: 0 usingSpringWithDamping: 0.5 initialSpringVelocity: 5 options: UIViewAnimationOptionCurveEaseInOut  animations:^{
            [v layoutIfNeeded];
            v.alpha = 1;
        } completion:nil];
    } else {
        constraint.constant = 0;
        [UIView animateWithDuration: 0.75 delay: 0 usingSpringWithDamping: 0.5 initialSpringVelocity: 5 options: UIViewAnimationOptionCurveEaseInOut  animations:^{
            [v layoutIfNeeded];
            v.alpha = 0;
        } completion:nil];
    }
    
}

@end
