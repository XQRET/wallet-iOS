//
//  ImportFormController.m
//  BlockChain
//
//  Created by Hugin on 2018/8/20.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import "ImportFormController.h"

#pragma mark - ImportFormThroughMnemonicController
@interface ImportFormThroughMnemonicController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *inputMnemonicTextView;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;

@end

@implementation ImportFormThroughMnemonicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    _inputMnemonicTextView.layer.borderWidth = 0.5;
    _inputMnemonicTextView.layer.borderColor = kHexColor(0xe5e7e9).CGColor;
    _inputMnemonicTextView.layer.cornerRadius = 6;
    _inputMnemonicTextView.autocorrectionType = UITextAutocorrectionTypeNo;
    
    _inputMnemonicTextView.delegate = self;
    
    [self setupNavBar];
}

- (void)setupNavBar {
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    [self.view addSubview:self.customNavBar];
    self.customNavBar.title = @"导入钱包";
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"nav_banck_black"]];
    [self.customNavBar updateFrame];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [_inputMnemonicTextView endEditing:YES];
}

#pragma mark UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    _placeholderLabel.hidden = YES;
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    textView.text = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([textView.text isEqualToString:@""]) {
        _placeholderLabel.hidden = NO;
    }
    return YES;
}
@end


#pragma mark - ImportFormThroughKeystoreController
@interface ImportFormThroughKeystoreController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *inputMnemonicTextView;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
@end

@implementation ImportFormThroughKeystoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    _inputMnemonicTextView.layer.borderWidth = 0.5;
    _inputMnemonicTextView.layer.borderColor = kHexColor(0xe5e7e9).CGColor;
    _inputMnemonicTextView.layer.cornerRadius = 6;
    _inputMnemonicTextView.autocorrectionType = UITextAutocorrectionTypeNo;
    
    _inputMnemonicTextView.delegate = self;
    
    [self setupNavBar];
}

- (void)setupNavBar {
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    [self.view addSubview:self.customNavBar];
    self.customNavBar.title = @"导入钱包";
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"nav_banck_black"]];
    [self.customNavBar updateFrame];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [_inputMnemonicTextView endEditing:YES];
}

#pragma mark UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    _placeholderLabel.hidden = YES;
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    textView.text = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([textView.text isEqualToString:@""]) {
        _placeholderLabel.hidden = NO;
    }
    return YES;
}
@end


#pragma mark - ImportFormThroughKeyController
@interface ImportFormThroughKeyController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *inputMnemonicTextView;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
@end

@implementation ImportFormThroughKeyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    _inputMnemonicTextView.layer.borderWidth = 0.5;
    _inputMnemonicTextView.layer.borderColor = kHexColor(0xe5e7e9).CGColor;
    _inputMnemonicTextView.layer.cornerRadius = 6;
    _inputMnemonicTextView.autocorrectionType = UITextAutocorrectionTypeNo;
    
    _inputMnemonicTextView.delegate = self;
    
    [self setupNavBar];
}

- (void)setupNavBar {
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    [self.view addSubview:self.customNavBar];
    self.customNavBar.title = @"导入钱包";
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"nav_banck_black"]];
    [self.customNavBar updateFrame];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [_inputMnemonicTextView endEditing:YES];
}

#pragma mark UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    _placeholderLabel.hidden = YES;
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    textView.text = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([textView.text isEqualToString:@""]) {
        _placeholderLabel.hidden = NO;
    }
    return YES;
}
@end
