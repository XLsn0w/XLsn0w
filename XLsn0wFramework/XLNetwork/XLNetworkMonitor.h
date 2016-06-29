
#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UIView+XLsn0w.h"

@interface XLNetworkMonitor : NSObject

+ (XLNetworkMonitor *)sharedInstance;

- (void)startMonitor;

- (void)stopMonitor;

@end
