//
//  DDCodeSplitInputView.m
//  TestCodeTextField
//
//  Created by Poseidon on 2018/2/27.
//  Copyright © 2018年 Poseidon. All rights reserved.
//

#import "DDCodeSplitInputView.h"

@interface DDCodeSplitInputView ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) NSString *inputStr;

@end

@implementation DDCodeSplitInputView

- (void)becomeResponder
{
    [self.textField becomeFirstResponder];
}

- (NSString *)text
{
    return self.inputStr;
}

#pragma mark - setMethod
- (void)setInputStr:(NSString *)inputStr
{
    _inputStr = inputStr;
    [self setNeedsDisplay];
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    _keyboardType = keyboardType;
    self.textField.keyboardType = keyboardType;
}

#pragma mark - useMethod
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //画线
    [self drawBottomLineWithRect:rect];
    //画字
    if (self.secureTextEntry) {
        [self drawSecureTextWithRect:rect];
    } else {
        [self drawTextWithRect:rect];
    }
}
//文案
- (void)drawTextWithRect:(CGRect)rect
{
    CGFloat width = floor((rect.size.width-self.bottomLineMargin*(self.length-1))/self.length);
    for (int i = 0; i < self.inputStr.length; i++) {
        NSString *cStr = [NSString stringWithFormat:@"%c",[self.inputStr characterAtIndex:i]];
        NSMutableDictionary *attributes = @{NSFontAttributeName:self.font, NSForegroundColorAttributeName:self.textColor}.mutableCopy;
        CGSize cSize = [cStr sizeWithAttributes:attributes];
        CGPoint point = CGPointMake(i*(width+self.bottomLineMargin)+(width-cSize.width)/2.0, rect.size.height-self.bottomLineHeight-self.bottomSpace-cSize.height);
        [cStr drawAtPoint:point withAttributes:attributes];
    }
}
//密文
- (void)drawSecureTextWithRect:(CGRect)rect
{
    CGFloat width = floor((rect.size.width-self.bottomLineMargin*(self.length-1))/self.length);
    for (int i = 0; i < self.inputStr.length; i++) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGRect drawRect = CGRectMake(i*(width+self.bottomLineMargin)+(width-8)/2.0, rect.size.height-self.bottomLineHeight-self.bottomSpace-8, 8, 8);
        CGContextAddEllipseInRect(context, drawRect);
        CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextFillPath(context);
    }
}
//底线
- (void)drawBottomLineWithRect:(CGRect)rect
{
    CGFloat width = floor((rect.size.width-self.bottomLineMargin*(self.length-1))/self.length);
    for (int i = 0; i < self.length; i++) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGRect drawRect = CGRectMake(i*(width+self.bottomLineMargin), rect.size.height-self.bottomLineHeight, width, self.bottomLineHeight);
        CGContextAddRect(context, drawRect);
        CGContextSetFillColorWithColor(context, self.bottomLineColor.CGColor);
        CGContextSetLineJoin(context, kCGLineJoinRound);
        CGContextFillPath(context);
    }
}

#pragma mark - UIEvent
- (void)tapAction
{
    [self.textField becomeFirstResponder];
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (void)textChanged
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(codeSplitInputViewTextChanged:)]) {
        [self.delegate codeSplitInputViewTextChanged:self];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *temp = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (temp.length > self.length) {
        return NO;
    }
    self.inputStr = temp;
    return YES;
}

#pragma mark - init
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
        [self initState];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self initState];
    }
    return self;
}

- (void)initUI
{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.textField];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
}

- (void)initState
{
    self.inputStr = @"";
    self.length = 6;
    self.secureTextEntry = NO;
    self.font = [UIFont systemFontOfSize:14];
    self.textColor = [UIColor blackColor];
    self.bottomSpace = 10;
    self.bottomLineMargin = 10;
    self.bottomLineHeight = 2;
    self.bottomLineColor = [UIColor blackColor];
}

#pragma mark - lazyLoad
- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.delegate = self;
        _textField.hidden = YES;
        [_textField addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

@end
