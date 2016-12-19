/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *******************************加载动画视图,不带百分比显示视图*************************************/

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSInteger, XLsn0wLoadViewStyle) {
    XLsn0wLoadViewStyleSqureClockWise = 0,  //正方形顺时针旋转类型,起始位置在中心
    XLsn0wLoadViewStyleSqureCornersClockWise//正方形顺时针旋转类型,起始位置在4个边角
};

@interface XLsn0wLoadView : UIView

/**
 *  全能初始化，默认初始值frame
 *
 *  @param style 加载动画类型
 *
 *  @return self
 */
- (instancetype)initWithXLsn0wLoadViewStyle:(XLsn0wLoadViewStyle)style;

/**
 *  全能初始化
 *
 *  @param style 加载动画类型
 *  @param frame 视图大小
 *
 *  @return self
 */
- (instancetype)initWithXLsn0wLoadViewStyle:(XLsn0wLoadViewStyle)style frame:(CGRect)frame;

/**
 *  中间过程，从中间起始位置，到扩展延伸到正方形四边的过渡过程
 *
 *  @param percent 百分比，范围[0.0,1.0],0.0时，处于正方形中间，1.0时，处于正方形四角
 */
- (void)updateReadytoClockwiseAnimationWithPercent:(float)percent;

/**
 *  开始正方形顺时针旋转动画
 */
- (void)startSquareClcokwiseAnimation;
/**
 *  停止正方形顺时针旋转动画
 */
- (void)stopSquareClockwiseAnimation;


@end
