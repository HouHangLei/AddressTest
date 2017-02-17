//
//  AddressView.m
//  AddressTest
//
//  Created by weizhongming on 2017/2/15.
//  Copyright © 2017年 航磊_. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define IPHONE6_SIZE SCREEN_WIDTH/375
#define RGB(r, g, b)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#import "AddressView.h"
#import "MJExtension.h"
#import "CityVO.h"
#import "CitiesVO.h"
#import "AppUtils.h"
@implementation AddressView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5f];
        
        UIView *tapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -400 *IPHONE6_SIZE)];
        tapView.userInteractionEnabled = YES;
        [self addSubview:tapView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [tapView addGestureRecognizer:tap];
        
//      获取数据源
        NSArray *arr = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];

        NSLog(@"%@",arr);
        
        self.datasArr = [CityVO mj_objectArrayWithKeyValuesArray:arr];

        self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 400 *IPHONE6_SIZE)];
        self.myView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.myView];
        
        [self addTitleView];
    }
    return self;
}



- (void)addTitleView{

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55 *IPHONE6_SIZE)];
    titleLabel.text = @"所在地区";
    titleLabel.textColor = RGB(142, 143, 148);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.myView addSubview:titleLabel];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH -55 *IPHONE6_SIZE, 0, 55 *IPHONE6_SIZE, 55 *IPHONE6_SIZE)];
    [button setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
    [self.myView addSubview:button];
    
    self.selectLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), 75, 30 *IPHONE6_SIZE)];
    self.selectLabel.textColor = RGB(242, 36, 36);
    self.selectLabel.text = @"请选择";
    self.selectLabel.font = [UIFont systemFontOfSize:15.f];
    self.selectLabel.textAlignment = NSTextAlignmentCenter;
    self.selectLabel.userInteractionEnabled = YES;
    [self.myView addSubview:self.selectLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectLabelTapClick)];
    [self.selectLabel addGestureRecognizer:tap];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.selectLabel.frame), SCREEN_WIDTH, 1)];
    lineView.backgroundColor = RGB(229, 229, 229);
    [self.myView addSubview:lineView];
    
    self.redLineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.selectLabel.frame) +15, CGRectGetMaxY(self.selectLabel.frame), 45, 1)];
    self.redLineView.backgroundColor = RGB(242, 36, 36);
    [self.myView addSubview:self.redLineView];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.redLineView.frame), SCREEN_WIDTH, self.myView.frame.size.height - CGRectGetMaxY(self.redLineView.frame))];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.scrollView.frame.size.height);
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    [self.myView addSubview:self.scrollView];
    
    self.tableView1 = [[AddressTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.scrollView.frame.size.height) withParmas:self.datasArr];
   
    __weak __typeof(self)weakSelf = self;

 
    self.tableView1.block = ^(NSInteger row){
    
        [weakSelf.cityLabel removeFromSuperview];
        weakSelf.cityLabel = nil;
        
        CityVO *cityVO = weakSelf.datasArr[row];
        weakSelf.stateLabel.frame = CGRectMake(0, 55 *IPHONE6_SIZE, 30 + [AppUtils widthOfString:cityVO.state font:15 height:30 *IPHONE6_SIZE], 30 *IPHONE6_SIZE);
        
        [UIView animateWithDuration:0.5 animations:^{
            
            weakSelf.selectLabel.frame = CGRectMake(CGRectGetMaxX(weakSelf.stateLabel.frame), CGRectGetMaxY(titleLabel.frame), 75, 30 *IPHONE6_SIZE);
            weakSelf.redLineView.frame = CGRectMake(CGRectGetMinX(weakSelf.selectLabel.frame) +15, CGRectGetMaxY(weakSelf.selectLabel.frame), 45, 1);
        } completion:^(BOOL finished) {
            
            weakSelf.stateLabel.text = cityVO.state;
        }];
        
        weakSelf.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *2, weakSelf.scrollView.frame.size.height);
       
        [weakSelf.tableView2 removeFromSuperview];
        weakSelf.tableView2 = nil;
        
        weakSelf.datasArr1 = cityVO.cities;
        weakSelf.tableView2.hidden = NO;
        
        [weakSelf.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
    };
    [self.scrollView addSubview:self.tableView1];
}

#pragma mark -- UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSLog(@"%f",scrollView.contentOffset.x /SCREEN_WIDTH);
    
    if (scrollView.contentOffset.x /SCREEN_WIDTH == 0) {
        
        [UIView animateWithDuration:0.5f animations:^{
        
            self.redLineView.frame = CGRectMake(15, CGRectGetMaxY(self.selectLabel.frame), [AppUtils widthOfString:self.stateLabel.text font:15 height:30 *IPHONE6_SIZE], 1);

        }];
        
    }else if (scrollView.contentOffset.x /SCREEN_WIDTH ==1){
    
        if (_cityLabel) {
            
            
            [UIView animateWithDuration:0.5f animations:^{
                
                self.redLineView.frame = CGRectMake(CGRectGetMaxX(self.stateLabel.frame) +15, CGRectGetMaxY(self.selectLabel.frame), [AppUtils widthOfString:self.cityLabel.text font:15 height:30 *IPHONE6_SIZE], 1);
            }];
        }else{
            
            
            [UIView animateWithDuration:0.5f animations:^{
                
                self.redLineView.frame = CGRectMake(CGRectGetMaxX(self.stateLabel.frame) +15, CGRectGetMaxY(self.selectLabel.frame), 45, 1);
            }];
        }
    }else{
    
        [UIView animateWithDuration:0.5f animations:^{

            self.redLineView.frame = CGRectMake(CGRectGetMinX(self.selectLabel.frame) +15, CGRectGetMaxY(self.selectLabel.frame), 45, 1);
        }];
    }
}

- (UILabel *)stateLabel{

    if (!_stateLabel) {
        
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.font = [UIFont systemFontOfSize:15.f];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.userInteractionEnabled = YES;
        [self.myView addSubview:_stateLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateLabelTapClick)];
        [_stateLabel addGestureRecognizer:tap];
    }
    return _stateLabel;
}

- (void)stateLabelTapClick{

    [UIView animateWithDuration:0.5f animations:^{
        
        self.redLineView.frame = CGRectMake(15, CGRectGetMaxY(self.selectLabel.frame), [AppUtils widthOfString:self.stateLabel.text font:15 height:30 *IPHONE6_SIZE], 1);
        
    }];
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (UILabel *)cityLabel{

    if (!_cityLabel) {
        
        _cityLabel = [[UILabel alloc] init];
        _cityLabel.font = [UIFont systemFontOfSize:15.f];
        _cityLabel.textAlignment = NSTextAlignmentCenter;
        _cityLabel.userInteractionEnabled = YES;
        [self.myView addSubview:_cityLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cityLabelTapClick)];
        [_cityLabel addGestureRecognizer:tap];
    }
    return _cityLabel;
}

- (void)cityLabelTapClick{

    [UIView animateWithDuration:0.5f animations:^{
        
        self.redLineView.frame = CGRectMake(CGRectGetMaxX(self.stateLabel.frame) +15, CGRectGetMaxY(self.selectLabel.frame), [AppUtils widthOfString:self.cityLabel.text font:15 height:30 *IPHONE6_SIZE], 1);
    }];
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
}

- (void)selectLabelTapClick{

    
    [UIView animateWithDuration:0.5f animations:^{
        
        self.redLineView.frame = CGRectMake(CGRectGetMinX(self.selectLabel.frame) +15, CGRectGetMaxY(self.selectLabel.frame), 45, 1);
    }];

    if (_cityLabel) {
        
        
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH *2, 0) animated:YES];
    }else if (_stateLabel){
    
        
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
    }
}

- (AddressTableView *)tableView2{

    if (!_tableView2) {
        
        __weak __typeof(self)weakSelf = self;

        _tableView2 = [[AddressTableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollView.frame.size.height) withParmas:self.datasArr1];
        _tableView2.block = ^(NSInteger row){
        
            CitiesVO *citiesVO = weakSelf.datasArr1[row];
            
            weakSelf.cityLabel.frame = CGRectMake(CGRectGetMaxX(weakSelf.stateLabel.frame), 55 *IPHONE6_SIZE, 30 + [AppUtils widthOfString:citiesVO.city font:15 height:30 *IPHONE6_SIZE], 30 *IPHONE6_SIZE);

            [UIView animateWithDuration:0.5 animations:^{
                
                weakSelf.selectLabel.frame = CGRectMake(CGRectGetMaxX(weakSelf.cityLabel.frame), CGRectGetMinY(weakSelf.stateLabel.frame), 75, 30 *IPHONE6_SIZE);
                weakSelf.redLineView.frame = CGRectMake(CGRectGetMinX(weakSelf.selectLabel.frame) +15, CGRectGetMaxY(weakSelf.selectLabel.frame), 45, 1);
            } completion:^(BOOL finished) {
                
                weakSelf.cityLabel.text = citiesVO.city;
            }];
            
            weakSelf.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *3, weakSelf.scrollView.frame.size.height);
            [weakSelf.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH *2, 0) animated:YES];
           

            weakSelf.datasArr2 = citiesVO.areas;
            
            [weakSelf.tableView3 removeFromSuperview];
            weakSelf.tableView3 = nil;

            weakSelf.tableView3.hidden = NO;

        };
        [self.scrollView addSubview:_tableView2];
    }
    
    return _tableView2;
}

- (AddressTableView *)tableView3{

    if (!_tableView3) {
        
        __weak __typeof(self)weakSelf = self;

        _tableView3 = [[AddressTableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH *2, 0, SCREEN_WIDTH, self.scrollView.frame.size.height) withParmas:self.datasArr2];
        _tableView3.block = ^(NSInteger row){
            
            weakSelf.block([NSString stringWithFormat:@"%@ %@ %@",weakSelf.stateLabel.text,weakSelf.cityLabel.text,weakSelf.datasArr2[row]]);
        };
        [self.scrollView addSubview:_tableView3];
    }
    
    return _tableView3;
}

#pragma mark -- 点击空白处触发
- (void)tapClick{

    [UIView animateWithDuration:0.5f animations:^{
        
        self.myView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 400 *IPHONE6_SIZE);
//        [self.fatherView.layer setTransform:[self firstTransform]];
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
//        [UIView animateWithDuration:0.5 animations:^{
//            self.fatherView.transform = CGAffineTransformMakeScale(1, 1);
//        }];
    }];
}

#pragma mark -- 弹出选择地址view
- (void)showView:(UIView *)supView{

    self.fatherView = supView;
    
    [UIView animateWithDuration:0.5f animations:^{
        
        self.myView.frame = CGRectMake(0, SCREEN_HEIGHT -400 *IPHONE6_SIZE, SCREEN_WIDTH, 400 *IPHONE6_SIZE);
//        [supView.layer setTransform:[self firstTransform]];
        
    } completion:^(BOOL finished) {
        
//        [UIView animateWithDuration:0.5 animations:^{
//            supView.transform = CGAffineTransformMakeScale(0.9, 0.9);
//        }];
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

// 后靠效果
- (CATransform3D)firstTransform{
    
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-900;
    //带点缩小的效果
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    //绕x轴旋转
    t1 = CATransform3DRotate(t1, 15.0 * M_PI/180.0, 1, 0, 0);
    return t1;
}

@end
