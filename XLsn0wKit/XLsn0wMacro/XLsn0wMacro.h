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
/* Apple Framework */
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <Photos/Photos.h>
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

/*!
 *1. iPhone 5      分辨率: 320x568，像素640x1136， @2x
 *2. iPhone 6      分辨率: 375x667，像素750x1334， @2x
 *3. iPhone 6 Plus 分辨率: 414x736，像素1242x2208，@3x
 
 iPhone 7 设备渲染后分辨率为 750 x 1334，逻辑分辨率只有 375 x 667。
 
 iPhone X 设备渲染后分辨率为 1125 x 2436，逻辑分辨率是为 375 x 812。 竖屏尺寸：1125px × 2436px(375pt × 812pt @3x)
 */

/*! 当前设备屏幕 宽/高 */
#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height

/*! 屏幕比率 以iPhone 7 | 375x667为基准 */
#define scale_width  ([UIScreen mainScreen].bounds.size.width  / 375)
#define scale_height ([UIScreen mainScreen].bounds.size.height / 667)

/*********************************************************************************************/
/*********************************************************************************************/
#define WeakSelf __weak typeof(self) weakSelf = self;
/*********************************************************************************************
 Xcode CodeSnippet
 @WeakObj(<#obj#>);
 @WeakObj(< #obj# >);
*********************************************************************************************/
#define XLsn0wWeakObj(obj)    try{}@finally{}   __weak typeof(obj) obj##Weak = obj;
#define WeakObj(obj)          autoreleasepool{} __weak typeof(obj) obj##Weak = obj;
#define StrongObj(obj)        autoreleasepool{} __strong typeof(obj) obj = obj##Weak;
#define XLsn0wStrongObj(obj)  try{}@finally{}   __strong typeof(obj) obj = obj##Weak;
//@WeakObj(self);
//[selfWeak methodName];
/*********************************************************************************************/
/*********************************************************************************************/
/*********************************************************************************************/

//layer= (__bridge id)image.CGImage;
//使用(__bridge id) 在ARC状态下，转换为id类型
#define bridge_id     (__bridge id)

//----------------------Directory--------------------------

#define XLsn0wCachesDirectory    ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject])
#define XLsn0wDocumentDirectory  ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject])
#define XLsn0wBundleID           ([[NSBundle mainBundle] bundleIdentifier])

//单例化一个类
#define XLsn0wSharedClass(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}

/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *   \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *    \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/
