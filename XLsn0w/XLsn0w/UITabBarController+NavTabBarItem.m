
#import "UITabBarController+NavTabBarItem.h"

@implementation UITabBarController (NavTabBarItem)

+ (void)navigationControllerInitWithRootViewController:(UIViewController *)viewController
                                       tabBarItemTitle:(NSString *)title
                                   tabBarItemImageName:(NSString *)imageName
                           tabBarItemSelectedImageName:(NSString *)selectedImageName
                                   addTabBarController:(UITabBarController *)tabBarController {
    //init navigationController
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    //init tabBarItem
    navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //TabBarController addChildViewController: NavigationController
    [tabBarController addChildViewController:navigationController];
}

@end
