//
//  AppUtils.m
//  AddressTest
//
//  Created by weizhongming on 2017/2/15.
//  Copyright © 2017年 航磊_. All rights reserved.
//

#import "AppUtils.h"
@implementation AppUtils

+ (CGFloat) widthOfString:(NSString *)string font:(int)font height:(CGFloat)height{
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject: [UIFont systemFontOfSize:font] forKey:NSFontAttributeName];
    CGRect rect=[string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.width;
}

@end
