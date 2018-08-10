//
//  PasswordView.m
//  BlockChain
//
//  Created by Hugin on 2018/8/9.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import "PasswordView.h"  
IB_DESIGNABLE
@implementation PasswordView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.textStore = [NSMutableString string];
    self.squareWidth = (kScreenWidth - 40) / 6.0;
    self.passWordNum = 6;
    self.pointRadius = 6;
    self.rectColor = kHexColor(0x949494);
    self.pointColor = [UIColor blackColor];
    [self becomeFirstResponder];
    
    self.layer.borderColor = kHexColor(0x949494).CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5;
    self.backgroundColor = [UIColor whiteColor];
}


/** 设置密码框边长 */
-(void)setSquareWidth:(CGFloat)squareWidth
{
    _squareWidth = squareWidth;
    [self setNeedsDisplay];
}

/**  设置键盘类型 */
-(UIKeyboardType)keyboardType
{
    return UIKeyboardTypeNumberPad;
}

/** 设置密码位数 */
-(void)setPassWordNum:(NSInteger)passWordNum
{
    _passWordNum = passWordNum;
    [self setNeedsDisplay];
}

-(BOOL)becomeFirstResponder
{
    if ([self.delegate respondsToSelector:@selector(passWordBeginInput:)]) {
        [self.delegate passWordBeginInput:self];
    }
    
    return [super becomeFirstResponder];
}

/**
 *  是否成为第一响应者
 *
 */
-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![self isFirstResponder]) {
        [self becomeFirstResponder];
    }
}

#pragma mark - UIKeyInput
/**
 * 用于显示的文本对象是否有任何文本
 */
-(BOOL)hasText
{
    return self.textStore.length > 0;
}

/**
 *插入文本
 */
-(void)insertText:(NSString *)text
{
    if (self.textStore.length < self.passWordNum) {
        
        //判断是否有数字
        NSCharacterSet *character = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        
        NSString *filter = [[text componentsSeparatedByCharactersInSet:character] componentsJoinedByString:@""];
        
        BOOL basicTest = [text isEqualToString:filter];
        if (basicTest) {
            [self.textStore appendString:text];
            if ([self.delegate respondsToSelector:@selector(passWordDidChange:)]) {
                [self.delegate passWordDidChange:self];
            }
            
            if (self.textStore.length == self.passWordNum) {
                if ([self.delegate respondsToSelector:@selector(passWordCompleteInput:)]) {
                    [self.delegate passWordCompleteInput:self];
                }
            }
            [self setNeedsDisplay];
            
        }
        
    }
}

//删除文本
- (void)deleteBackward {
    if (self.textStore.length > 0) {
        [self.textStore deleteCharactersInRange:NSMakeRange(self.textStore.length - 1, 1)];
        if ([self.delegate respondsToSelector:@selector(passWordDidChange:)]) {
            [self.delegate passWordDidChange:self];
        }
    }
    
    [self setNeedsDisplay];
}

- (void)clearAllText {
    [self.textStore setString:@""];
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    CGFloat height = rect.size.height;
    CGFloat width = rect.size.width;
    
    CGFloat x = (width - self.squareWidth * self.passWordNum)/2.0;
    CGFloat y = (height - self.squareWidth)/2.0;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 画外框
 
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, self.rectColor.CGColor);
 
    // 画竖条
    for (int i = 1; i < self.passWordNum; i ++) {
        CGContextMoveToPoint(context, x + self.squareWidth * i, y);
        CGContextAddLineToPoint(context, x + self.squareWidth * i, y + self.squareWidth);
        CGContextClosePath(context);
    }
    
    CGContextDrawPath(context, kCGPathStroke);
    CGContextSetFillColorWithColor(context, self.pointColor.CGColor);
    
    //画黑点
    for (int i = 1; i <= self.textStore.length; i++) {
        CGContextAddArc(context, x + self.squareWidth * i - self.squareWidth/2.0, y + self.squareWidth/2.0, self.pointRadius, 0, M_PI * 2, YES);
        CGContextDrawPath(context, kCGPathFill);
    }
}

@end
