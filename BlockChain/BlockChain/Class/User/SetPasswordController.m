//
//  SetPasswordController.m
//  BlockChain
//
//  Created by Hugin on 2018/8/9.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import "SetPasswordController.h"
#import "PasswordView.h"

@interface SetPasswordController ()<PasswordViewDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet PasswordView *passwordView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (copy, nonatomic) NSString *passwordStr;
@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
@end

@implementation SetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    _passwordView.delegate = self;
    [self setupNavBar];
}

- (void)setupNavBar {
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    [self.view addSubview:self.customNavBar];
    self.customNavBar.title = @"设置密码";
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    [self.customNavBar wr_setBottomLineHidden:YES];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"nav_banck_white"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"nav_bar_bg"];
    [self.customNavBar updateFrame];
}

#pragma mark PasswordView Delegate
-(void)passWordDidChange:(PasswordView *)password
{
    NSLog(@"改变%@",password.textStore);
}

-(void)passWordBeginInput:(PasswordView *)password
{
    NSLog(@"开始输入%@",password.textStore);
    _label.text = @"设置钱包交易密码";
    _passwordStr = nil;
    [_passwordView clearAllText];
}

-(void)passWordCompleteInput:(PasswordView *)password
{
    NSLog(@"输入完成%@",password.textStore);
    __weak typeof(self) weakSelf = self;
    if (password.textStore.length == 6) {
        //延迟执行
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (!weakSelf.passwordStr) {
                weakSelf.passwordStr = password.textStore;
                [weakSelf.passwordView clearAllText];
                weakSelf.label.text = @"再次确认钱包交易密码";
            } else {
                if ([weakSelf.passwordStr isEqualToString:password.textStore]) {
                    [weakSelf.passwordView endEditing:YES];
                } else {
                    weakSelf.label.text = @"两次输入的密码不一致，请重新设置密码";
                    weakSelf.passwordStr = nil;
                    [weakSelf.passwordView clearAllText];
                }
            }
        });
    }
}

@end
