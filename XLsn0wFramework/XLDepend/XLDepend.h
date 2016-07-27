
/*! Third-Party Framework */
#import <AFNetworking.h>
#import <FMDB.h>
#import <MBProgressHUD.h>
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import <MJRefresh.h>

/* Apple Framework */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*! 当前设备屏幕 宽/高 */
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

/*! 屏幕比率 以iPhone6为基准 */
#define kFitWidth  ([UIScreen mainScreen].bounds.size.width / 375)
#define kFitHeight ([UIScreen mainScreen].bounds.size.height / 667)

/*! Masonry相关比率 以iPhone6为基准 */
#define kFitLeft   ([UIScreen mainScreen].bounds.size.width / 375)
#define kFitRight  ([UIScreen mainScreen].bounds.size.width / 375)
#define kFitTop    ([UIScreen mainScreen].bounds.size.height / 667)
#define kFitBottom ([UIScreen mainScreen].bounds.size.height / 667)

/*! 根据屏幕高度判断真机设备 */
#define iPhone4s    ([[UIScreen mainScreen] bounds].size.height == 480)
#define iPhone5     ([[UIScreen mainScreen] bounds].size.height == 568)
#define iPhone6     ([[UIScreen mainScreen] bounds].size.height == 667)
#define iPhone6Plus ([[UIScreen mainScreen] bounds].size.height == 736)