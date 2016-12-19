
/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 **********************************带有百分比的加载动画视图****************************************/ 

#import <UIKit/UIKit.h>

@interface XLsn0wLoadPercentView : UIView

@property (strong, nonatomic, readonly) NSString *percentStr;
/**
 *  初始化函数
 *
 *  @param frame      视图大小
 *  @param percentStr 初始值，可为nil
 *
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame percentStr:(NSString *)percentStr;

/**
 *  初始化函数
 *
 *  @param frame      视图大小
 *  @param percentStr 初始值，可为nil
 *  @param color      字体颜色
 *
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame percentStr:(NSString *)percentStr percentColor:(UIColor *)color;

/**
 *  显示提示
 *
 *  @param content 提示
 */
- (void)setShowContent:(NSString *)content;

/**
 *  开始百分比动画
 */
- (void)showPercentAnimation;

/**
 *  隐藏并移除动画
 */
- (void)hideRemovePercentAnimation;

@end









