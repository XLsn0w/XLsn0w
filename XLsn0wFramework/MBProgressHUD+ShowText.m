
#import "MBProgressHUD+ShowText.h"

@implementation MBProgressHUD (ShowText)

+ (void)showText:(NSString *)text imageName:(NSString *)imageName {
    // 显示加载失败
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    // 显示一张图片(mode必须写在customView设置之前)
    hud.mode = MBProgressHUDModeCustomView;
    // 设置一张图片
    imageName = [NSString stringWithFormat:@"%@", imageName];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    
    hud.labelText = text;
    
    // 隐藏的时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒后自动隐藏
    [hud hide:YES afterDelay:1];
}

+ (void)showErrorWithText:(NSString *)text {
    [self showText:text imageName:@"error.png"];
}

+ (void)showSuccessWithText:(NSString *)text {
    [self showText:text imageName:@"success.png"];
}

@end
