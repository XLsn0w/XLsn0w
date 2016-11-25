
#import <Foundation/Foundation.h>

@interface XLNetworkMonitor : NSObject

+ (XLNetworkMonitor *)sharedInstance;

- (void)startMonitor;

- (void)stopMonitor;

@end
