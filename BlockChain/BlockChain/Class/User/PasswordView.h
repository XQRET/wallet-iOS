//
//  PasswordView.h
//  BlockChain
//
//  Created by Hugin on 2018/8/9.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

//  PasswordView.h
#import <UIKit/UIKit.h>

@class PasswordView;

@protocol PasswordViewDelegate<NSObject>

-(void)passWordDidChange:(PasswordView *)password;

-(void)passWordCompleteInput:(PasswordView *)password;

-(void)passWordBeginInput:(PasswordView *)password;

@end

@interface PasswordView : UIView<UIKeyInput>

@property (nonatomic, assign) NSInteger passWordNum;        //密码的位数
@property (nonatomic, assign) CGFloat squareWidth;          //密码框的大小
@property (nonatomic, assign) CGFloat pointRadius;          //黑点半径
@property (nonatomic, strong) UIColor *pointColor;          //黑点颜色
@property (nonatomic, strong) UIColor *rectColor;           //边框颜色
@property (nonatomic, strong) NSMutableString *textStore;   //保存密码的字符串
@property (nonatomic, weak) id<PasswordViewDelegate> delegate;
- (void)clearAllText;
@end
