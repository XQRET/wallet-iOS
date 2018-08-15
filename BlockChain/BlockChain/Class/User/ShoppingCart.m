//
//  ShoppingCart.m
//  BlockChain
//
//  Created by Hugin on 2018/8/14.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import "ShoppingCart.h"
#import "PasswordView.h"

@interface ShoppingCart()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pwdLeftConstraint;
@property (weak, nonatomic) IBOutlet PasswordView *pwdView;

@end

@implementation ShoppingCart

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _pwdLeftConstraint.constant = kScreenWidth;
    [self layoutIfNeeded];
}
- (IBAction)clickBack:(UIButton *)sender {
    kReduceButtonFrequency
    
    [_pwdView endEditing:YES];
    _pwdLeftConstraint.constant = kScreenWidth;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
        [self layoutIfNeeded];
    } completion:nil];
}

- (IBAction)clickBuy:(UIButton *)sender {
    kReduceButtonFrequency
    
    [_pwdView becomeFirstResponder];
    _pwdLeftConstraint.constant = 0;
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
        [self layoutIfNeeded];
    } completion:nil];
    
}

@end
