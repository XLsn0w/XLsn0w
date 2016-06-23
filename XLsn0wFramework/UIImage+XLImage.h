//
//  UIImage+XLImage.h
//  runtime
//
//  Created by XLsn0w on 16/5/30.
//  Copyright © 2016年 XLsn0w. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XLImage)

// 声明方法
// 如果跟系统方法差不多功能,可以采取添加前缀,与系统方法区分
+ (UIImage *)wg_imageWithName:(NSString *)imageName;

@end
