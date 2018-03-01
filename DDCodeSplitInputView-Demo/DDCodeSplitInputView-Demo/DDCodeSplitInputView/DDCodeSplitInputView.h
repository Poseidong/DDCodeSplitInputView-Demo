//
//  DDCodeSplitInputView.h
//  TestCodeTextField
//
//  Created by Poseidon on 2018/2/27.
//  Copyright © 2018年 Poseidon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDCodeSplitInputView;

@protocol DDCodeSplitInputViewDelegate <NSObject>

- (void)codeSplitInputViewTextChanged:(DDCodeSplitInputView *)inputView;

@end

@interface DDCodeSplitInputView : UIView
@property (nonatomic, weak) id<DDCodeSplitInputViewDelegate> delegate;

/**
 长度
 */
@property (nonatomic, assign) NSInteger length; //default is 6;

/**
 键盘类型
 */
@property (nonatomic, assign) UIKeyboardType keyboardType; //default is UIKeyboardTypeNumberPad

/**
 密文显示
 */
@property (nonatomic, assign) BOOL secureTextEntry; //default is NO;

/**
 输入文案
 */
@property (nonatomic, strong) NSString *text;

/**
 字号
 */
@property (nonatomic, strong) UIFont *font; //default is [UIFont systemFontOfSize:14];

/**
 字体颜色
 */
@property (nonatomic, strong) UIColor *textColor; //default is [UIColor blackColor];

/**
 字与底线间距
 */
@property (nonatomic, assign) CGFloat bottomSpace; //default is 10;

/**
 底线间距
 */
@property (nonatomic, assign) CGFloat bottomLineMargin; //default is 10;

/**
 底线高度
 */
@property (nonatomic, assign) CGFloat bottomLineHeight; //default is 2;

/**
 底线颜色
 */
@property (nonatomic, strong) UIColor *bottomLineColor; //default is [UIColor blackColor];


- (void)becomeResponder;

@end
