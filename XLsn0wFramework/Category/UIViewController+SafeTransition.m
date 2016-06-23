
#import "UIViewController+SafeTransition.h"
#import "XLNavigationController.h"
#import <objc/runtime.h>

@implementation UIViewController (SafeTransition)

+ (void)load {
    Method m1;
    Method m2;

    m1 = class_getInstanceMethod(self, @selector(sofaViewDidAppear:));
    m2 = class_getInstanceMethod(self, @selector(viewDidAppear:));
    method_exchangeImplementations(m1, m2);
}

- (void)sofaViewDidAppear:(BOOL)animated {
    if([self.navigationController isKindOfClass:[XLNavigationController class]]){
        self.navigationController.transitionInProgress = NO;
        [self sofaViewDidAppear:animated];
    }
}

@end
