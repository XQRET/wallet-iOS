//
//  RegisterController.m
//  BlockChain
//
//  Created by nbs on 2018/7/24.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import "RegisterController.h"

@interface RegisterController ()
@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;

@property (weak, nonatomic) IBOutlet UITextField *purseName;
@property (weak, nonatomic) IBOutlet UITextField *pursePassword;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;
@property (weak, nonatomic) IBOutlet UITextField *invitationCode;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;


@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];  
    self.navigationController.navigationBar.hidden = YES;
    [self setupNavBar];
}

- (void)setupNavBar {
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    [self.view addSubview:self.customNavBar];
    
    self.customNavBar.titleLabelColor = kHexColor(0x333333);
    self.customNavBar.title = @"创建钱包";
    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"nav_banck_black"]];
    [self.customNavBar updateFrame];
}

- (IBAction)clickAgree:(UIButton *)sender {
    kReduceButtonFrequency
    sender.selected = !sender.selected;
}

- (IBAction)clickRegister:(UIButton *)sender {
    kReduceButtonFrequency
    
    if ([_purseName.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入钱包名称!"];
        return;
    }
    
    if ([_pursePassword.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入登录密码!"];
        return;
    }
    
    if ([_confirmPassword.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入登录密码!"];
        return;
    }
    
    if (![_pursePassword.text isEqualToString:_confirmPassword.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次密码输入不一致!"];
        return;
    }
    
    if (!_agreeBtn.selected) {
        [SVProgressHUD showErrorWithStatus:@"请同意协议!"];
        return;
    }
    NSDictionary *parameter = @{@"purseName": _purseName.text,
                                @"pursePassword": [_pursePassword.text md5String],
                                @"invitationCode": _invitationCode.text,
                                @"imei": [[[UIDevice currentDevice] identifierForVendor] UUIDString]};
    [kNetworkManager postWithUrl:kPurseUserPurseUserRegister parameter:parameter success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable response) {
        if ([response[@"code"] intValue] == 0) { 
            RegisterSuccessController *vc = [[UIStoryboard storyboardWithName:@"RegisterController" bundle:nil] instantiateViewControllerWithIdentifier:@"RegisterSuccessController"];
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:response[@"data"]];
            [dic setObject:[self.pursePassword.text md5String] forKey:@"pursePassword"];
            vc.data = [dic copy];
            
            [self.navigationController setViewControllers:@[self.navigationController.viewControllers.firstObject, vc] animated:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:response[@"message"]];
        }
    } failure:nil];
    
}

@end


@interface RegisterSuccessController ()
@property (weak, nonatomic) IBOutlet UITextView *privateKeyTextView;
@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
@end

@implementation RegisterSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    _privateKeyTextView.text = _data[@"privateKey"];
    [self setupNavBar];
}

- (void)setupNavBar {
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    [self.view addSubview:self.customNavBar];
    
    self.customNavBar.titleLabelColor = kHexColor(0x333333);
    self.customNavBar.title = @"创建成功";
    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"nav_banck_black"]];
    [self.customNavBar updateFrame];
}

- (IBAction)loginClick:(UIButton *)sender {
    kReduceButtonFrequency
    
    NSDictionary *parameter = @{@"purseName": _data[@"purseName"],
                                @"pursePassword": _data[@"pursePassword"]};
    [kNetworkManager postWithUrl:kPurseUserPurseUserLogin parameter:parameter success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable response) {
        if ([response[@"code"] intValue] == 0) {
            [[NSUserDefaults standardUserDefaults] setObject:response[@"data"][@"purseToken"] forKey:@"purseToken"];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [SVProgressHUD showErrorWithStatus:response[@"message"]];
        }
    } failure:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
@end

