//
//  ViewController.m
//  DDCodeSplitInputView-Demo
//
//  Created by Poseidon on 2018/3/1.
//  Copyright © 2018年 Poseidon. All rights reserved.
//

#import "ViewController.h"
#import "DDCodeSplitInputView.h"

@interface ViewController ()<DDCodeSplitInputViewDelegate>

@end

@implementation ViewController

- (void)codeSplitInputViewTextChanged:(DDCodeSplitInputView *)inputView
{
    NSLog(@"%@",inputView.text);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DDCodeSplitInputView *inputView = [[DDCodeSplitInputView alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, 50)];
    inputView.showCursor = YES;
    inputView.delegate = self;
    [self.view addSubview:inputView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
