//
//  XLRefreshAutoGifFooter.m
//  JoyHelper
//
//  Created by XLsn0w on 16/7/18.
//  Copyright © 2016年 XLsn0w. All rights reserved.
//

#import "XLRefreshAutoGifFooter.h"

@implementation XLRefreshAutoGifFooter

- (void)prepare {
    [super prepare];
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
