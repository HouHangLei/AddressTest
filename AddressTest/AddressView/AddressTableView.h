//
//  AddressTableView.h
//  AddressTest
//
//  Created by weizhongming on 2017/2/15.
//  Copyright © 2017年 航磊_. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Block)(NSInteger row);

@interface AddressTableView : UIView <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, copy) NSString *indexRow;

/**
 初始化

 @param frame frame
 @param params 数据
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame withParmas:(id)params;

@property (nonatomic, strong) NSArray *datas;

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic, copy) Block block;

@end
