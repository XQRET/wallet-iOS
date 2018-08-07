//
//  LoginController.m
//  BlockChain
//
//  Created by nbs on 2018/7/24.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()
@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UITextField *purseName;
@property (weak, nonatomic) IBOutlet UITextField *pursePassword;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    [self setupNavBar];
}

- (void)setupNavBar {
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    [self.view addSubview:self.customNavBar];
 
    self.customNavBar.titleLabelColor = kHexColor(0x333333);
    self.customNavBar.title = @"登录钱包";
    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    [self.customNavBar updateFrame];
}

- (IBAction)clickRegister:(UIButton *)sender {
    kReduceButtonFrequency
    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"RegisterController" bundle:nil] instantiateInitialViewController] animated:YES];
}

- (IBAction)clickLogin:(UIButton *)sender {
    kReduceButtonFrequency
 
    if ([_purseName.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入钱包名称!"];
        return;
    }
    
    if ([_pursePassword.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入钱包密码!"];
        return;
    }
    
    if (!_agreeBtn.selected) {
        [SVProgressHUD showErrorWithStatus:@"请同意协议!"];
        return;
    }
    
    NSDictionary *parameter = @{@"purseName": _purseName.text,
                                @"pursePassword": [_pursePassword.text md5String]};
    [kNetworkManager postWithUrl:kPurseUserPurseUserLogin parameter:parameter success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable response) {
        if ([response[@"code"] intValue] == 0) {
            [[NSUserDefaults standardUserDefaults] setObject:response[@"data"][@"purseToken"] forKey:@"purseToken"];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [SVProgressHUD showErrorWithStatus:response[@"message"]];
        }
    } failure:nil];
}

- (IBAction)clickAgree:(UIButton *)sender {
    kReduceButtonFrequency
    sender.selected = !sender.selected;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


@end
