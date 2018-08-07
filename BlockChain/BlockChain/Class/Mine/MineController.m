//
//  MineController.m
//  BlockChain
//
//  Created by nbs on 2018/7/16.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import "MineController.h"
#import "AppConfigController.h"
#import "AuthorizationManager.h"
#import <YYWebImage.h>

@interface MineController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *top_right_btn;
@property (weak, nonatomic) IBOutlet UIButton *top_login_btn;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *avatarBtn;

@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UIAlertController *cameraAlertController;
@property (nonatomic, strong) UIAlertController *settingsAlertController;

@end

@implementation MineController

- (UIImagePickerController *)imagePickerController {
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
    }
    return _imagePickerController;
}

- (UIAlertController *)cameraAlertController {
    if (_cameraAlertController == nil) {
        __weak typeof(self) weakSelf = self;
        _cameraAlertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [weakSelf presentViewController:weakSelf.imagePickerController animated:YES completion:nil];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [weakSelf presentViewController:weakSelf.imagePickerController animated:YES completion:nil];
        }];
        
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [_cameraAlertController addAction:action1];
        [_cameraAlertController addAction:action2];
        [_cameraAlertController addAction:action3];
    }
    return _cameraAlertController;
}

- (UIAlertController *)settingsAlertController {
    if (_settingsAlertController == nil) {
        _settingsAlertController = [UIAlertController alertControllerWithTitle:@"App需要您的同意, 才能访问相机和相册!" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                // 过期的方法
                IgnoreDeprecatedWarning([[UIApplication sharedApplication] openURL:url])
            }
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [_settingsAlertController addAction:action1];
        [_settingsAlertController addAction:action2];
    }
    return _settingsAlertController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self setupNavBar];
    
    
    if (kScreenHeight == 812) {
        self.tableView.tableHeaderView.height = 189;
    } else {
        self.tableView.tableHeaderView.height = 165;
    }
    
    self.top_right_btn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.top_right_btn.layer.borderWidth = 1;
    self.top_right_btn.layer.cornerRadius = 5;
    
    self.top_login_btn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.top_login_btn.layer.borderWidth = 1;
    self.top_login_btn.layer.cornerRadius = 5;
    self.top_login_btn.hidden = YES;
    
    self.avatarBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.avatarBtn.layer.borderWidth = 1;
    self.avatarBtn.layer.cornerRadius = 35;
    self.avatarBtn.layer.masksToBounds = YES;
}

- (void)setupNavBar {
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    [self.view addSubview:self.customNavBar];
    self.customNavBar.title = @"个人中心";
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    [self.customNavBar wr_setRightButtonWithTitle:@"语言" titleColor:[UIColor whiteColor]];
    __weak typeof(self) weakSelf = self;
    [self.customNavBar setOnClickRightButton:^{
        AppConfigController *vc = [[AppConfigController alloc] init];
        vc.type = AppConfigTypeCurrency;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [self.customNavBar updateFrame];
}

#pragma mark - UITableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.row) {
        case 0:{
            
        } break;
        case 1:{
            AppConfigController *vc = [[AppConfigController alloc] init];
            vc.type = AppConfigTypeLanguage;
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 2:{
            UIViewController *vc = [[UIStoryboard storyboardWithName:@"AccountSecurityController" bundle:nil] instantiateInitialViewController];
            
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 3:{
            
        } break;
        case 4:{
            
        } break;
    }
    
   
}


#pragma mark - UIImagePickerControllerDelegate

- (IBAction)clickAvatar:(UIButton *)sender {
    kReduceButtonFrequency
    BOOL flag = [AuthorizationManager examinePhotoLibraryAndVideoMediaAuthorizationStatus];
    if (!flag) {
        [self presentViewController:self.settingsAlertController animated:YES completion:nil];
        return;
    }
    [self presentViewController:self.cameraAlertController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    __weak typeof(self) weakSelf = self;
    UIImage *originalImage = info[@"UIImagePickerControllerOriginalImage"];
    NSData *data = UIImageJPEGRepresentation(originalImage, 0.2);
    // 这里图片没有放大效果，所以用缩小图进行显示，节约内存
    originalImage = [UIImage imageWithData:data];
    
    [_avatarBtn setBackgroundImage:originalImage forState:UIControlStateNormal];
    //
    [self dismissViewControllerAnimated:YES completion:^{
        //        [kNetworkManager uploadImageWithUrl:kPurseUserUploadUserPhoto imageData:data imageFileName:@"avatar.png" imageParameterName:@"headPhotoFile" parameter:nil progress:nil success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable response) {
        //            if ([response[@"code"] intValue] == 0) {
        //
        //            } else {
        ////                [weakSelf.avatar yy_setImageWithURL:[NSURL URLWithString:@""] placeholder:[UIImage imageNamed:@"mine_top_icon"]];
        ////                [SVProgressHUD showErrorWithStatus:@"头像上传失败，请重新上传!"];
        //            }
        //        } failure:nil];
    }];
}

@end
