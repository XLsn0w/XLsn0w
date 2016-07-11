
#import "XLsn0wAppDelegate.h"
#import "XLsn0wViewController.h"

@implementation XLsn0wAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self setupRootViewController];
    return YES;
}

- (void)setupRootViewController {
    XLsn0wViewController *xlsn0wViewController = [[XLsn0wViewController alloc] init];
    UINavigationController *xlsn0wNavigationController = [[UINavigationController alloc] initWithRootViewController:xlsn0wViewController];
    self.window.rootViewController = xlsn0wNavigationController;
}

@end
