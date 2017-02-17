//
//  AddressView.h
//  AddressTest
//
//  Created by weizhongming on 2017/2/15.
//  Copyright © 2017年 航磊_. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressTableView.h"

typedef void(^returnBlock)(NSString *addressStr);
@interface AddressView : UIView <UIScrollViewDelegate>

@property (nonatomic, copy) returnBlock block;

@property (nonatomic, strong) UIView *fatherView;

@property (nonatomic, strong) NSArray *datasArr, *datasArr1, *datasArr2;

/**
 弹出选择地址view

 @param supView 父view
 */
- (void) showView:( UIView * _Nonnull )supView;

@property (nonatomic, strong) UIView *myView;


/**
 请选择label
 */
@property (nonatomic, strong) UILabel *selectLabel;


/**
 红色的线
 */
@property (nonatomic, strong) UIView *redLineView;


@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) AddressTableView *tableView1;
@property (nonatomic, strong) AddressTableView *tableView2;
@property (nonatomic, strong) AddressTableView *tableView3;


/**
 省份label
 */
@property (nonatomic, strong) UILabel *stateLabel;

/**
 市label
 */
@property (nonatomic, strong) UILabel *cityLabel;

@end
