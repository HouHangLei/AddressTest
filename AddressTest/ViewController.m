//
//  ViewController.m
//  AddressTest
//
//  Created by weizhongming on 2017/2/15.
//  Copyright © 2017年 航磊_. All rights reserved.
//
//屏幕宽度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "AddressView.h"
@interface ViewController ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    self.btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, SCREEN_WIDTH -200, 50)];
    self.btn.backgroundColor = [UIColor grayColor];
    [self.btn setTitle:@"点击选择地址" forState:UIControlStateNormal];
    self.btn.titleLabel.numberOfLines = 0;
    self.btn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [self.btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
}

- (void)btnClick{

    AddressView *addressView = [[AddressView alloc] initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.frame.size.width, [UIApplication sharedApplication].keyWindow.frame.size.height)];
    addressView.block = ^(NSString *addressStr){
    
        [self.btn setTitle:addressStr forState:UIControlStateNormal];
    };
    [addressView showView:self.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
