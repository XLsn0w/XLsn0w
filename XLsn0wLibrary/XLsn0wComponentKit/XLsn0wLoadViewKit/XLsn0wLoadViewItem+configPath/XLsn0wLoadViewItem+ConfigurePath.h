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

#import "XLsn0wLoadViewItem.h"

typedef NS_ENUM(NSInteger, XLsn0wLoadViewStartLoadingSyle) {
    XLsn0wLoadViewStartFromLeftTop     = 0,//初始位置正方形左上角，做顺时针正方形运动
    XLsn0wLoadViewStartFromRightTop    = 1,//初始位置正方形右上角，做顺时针正方形运动
    XLsn0wLoadViewStartFromRightBottom = 2,//初始位置正方形右下角，做顺时针正方形运动
    XLsn0wLoadViewStartFromLeftBottom      //初始位置正方形左下角，做顺时针正方形运动
};

@interface XLsn0wLoadViewItem (ConfigurePath)
/**
 *  根据路径起始位置，初始化正方形顺时针路径，并返回keyFrameAnimation
 *
 *  @param style 起始位置
 */
- (void)configKeyFrameAnimationForColorLayerWithStartLoadingStyle:(XLsn0wLoadViewStartLoadingSyle)style;

/**
 *  设置modelLayer的position为当前preseterLayer的positon
 *
 */
- (void)stayOnPresentationLayerPosition;

@end
