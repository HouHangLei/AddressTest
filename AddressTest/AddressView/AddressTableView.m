//
//  AddressTableView.m
//  AddressTest
//
//  Created by weizhongming on 2017/2/15.
//  Copyright © 2017年 航磊_. All rights reserved.
//
#define RGB(r, g, b)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#import "AddressTableView.h"
#import "CityVO.h"
#import "CitiesVO.h"

@implementation AddressTableView

- (instancetype)initWithFrame:(CGRect)frame withParmas:(id)params{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.datas = params;
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

        [self addSubview:_tableView];
    }
    
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellName];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if ([self.datas[indexPath.row] isKindOfClass:[CityVO class]]) {
        
        CityVO *cityVO = self.datas[indexPath.row];
        cell.textLabel.text = cityVO.state;
    }else if ([self.datas[indexPath.row] isKindOfClass:[CitiesVO class]]){
    
        CitiesVO *citiesVO = self.datas[indexPath.row];
        cell.textLabel.text = citiesVO.city;
    }else if ([self.datas[indexPath.row] isKindOfClass:[NSString class]]){
    
        cell.textLabel.text = self.datas[indexPath.row];
    }
    
    if (self.indexRow && self.indexRow.integerValue == indexPath.row) {
        
        cell.textLabel.textColor = RGB(242, 36, 36);
    }else{
    
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:15.f];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    self.indexRow = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    [tableView reloadData];
    
    if (self.block) {
            
        self.block(indexPath.row);
    }
    
}

@end
