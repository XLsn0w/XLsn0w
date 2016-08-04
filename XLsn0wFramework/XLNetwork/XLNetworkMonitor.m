
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
                [UIView xlsn0w_showMessage:@"您当期设备使用的是无线网络!"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝网络");
                [UIView xlsn0w_showMessage:@"您当期设备使用的是蜂窝网络!"];
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"您的网络已经断开");
                [UIView xlsn0w_showMessage:@"您当前设备网络已经断开,请检查网络设置!"];
                break;
                
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                [UIView xlsn0w_showMessage:@"未知网络!"];
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
