/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface XLsn0wLoadViewItem : NSObject

/**
 *  图像图层
 */
@property (nonatomic, strong) CALayer *colorCirculeLayer;
/**
 *  全能初始化
 *
 *  @param image 图片名称
 *
 *  @return 包含layer的item
 */
+ (instancetype)initWithImage:(UIImage*)image;


/**
 *  设置position
 *
 *  @param position 坐标
 */
- (void)setPosition:(CGPoint)position;

@end


