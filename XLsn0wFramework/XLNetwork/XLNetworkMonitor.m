
#import "XLNetworkMonitor.h"

@implementation XLNetworkMonitor : NSObject 

static XLNetworkMonitor *instance = nil;
+ (XLNetworkMonitor *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XLNetworkMonitor alloc] init];
    });
    return instance;
}

- (void)startMonitor {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                [UIView xlsn0w_showMessage:@"当期使用无线网络 !"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝网络");
                [UIView xlsn0w_showMessage:@"当期使用移动网络 !"];
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"您的网络已经断开");
                [UIView xlsn0w_showMessage:@"当前网络已断开, 请检查网络设置 !"];
                break;
                
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                [UIView xlsn0w_showMessage:@"未知网络 !"];
                break;
                
            default:
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)stopMonitor {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

@end
