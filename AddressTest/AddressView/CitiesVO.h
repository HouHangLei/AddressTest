//
//  CitiesVO.h
//  AddressTest
//
//  Created by weizhongming on 2017/2/15.
//  Copyright © 2017年 航磊_. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CitiesVO : NSObject

/**
 存着县的名称的数组
 */
@property (nonatomic, strong) NSArray *areas;


/**
 城市名称
 */
@property (nonatomic, copy) NSString *city;

@end
