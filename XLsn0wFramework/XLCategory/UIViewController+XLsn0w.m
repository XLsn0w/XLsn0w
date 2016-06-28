
#import "UIViewController+XLsn0w.h"

@implementation UIViewController (XLsn0w)

@end

#import <objc/runtime.h>
#define kOriginDelegate @"kOriginDelegate"

@implementation UIViewController (HandleNavBack)

- (BOOL)clickNavigationBackButtonShouldPopAction {
    return YES;
}

@end

@implementation UINavigationController (HandleNavBack)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(new_viewDidLoad);
        
        Method originMethod = class_getInstanceMethod(class, originSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class,
                                            originSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originMethod),
                                method_getTypeEncoding(originMethod));
        } else {
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (void)new_viewDidLoad {
    [self new_viewDidLoad];
    
    objc_setAssociatedObject(self, [kOriginDelegate UTF8String], self.interactivePopGestureRecognizer.delegate, OBJC_ASSOCIATION_ASSIGN);
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

#pragma mark - 点击按钮返回事件
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];
    if([vc respondsToSelector:@selector(clickNavigationBackButtonShouldPopAction)]) {
        shouldPop = [vc clickNavigationBackButtonShouldPopAction];
    }
    
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        for(UIView *subview in [navigationBar subviews]) {
            if(0. < subview.alpha && subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    return NO;
}

#pragma mark - 手势返回事件
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        UIViewController *vc = [self topViewController];
        if([vc respondsToSelector:@selector(clickNavigationBackButtonShouldPopAction)]) {
            return [vc clickNavigationBackButtonShouldPopAction];
        }
        id<UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, [kOriginDelegate UTF8String]);
        return [originDelegate gestureRecognizerShouldBegin:gestureRecognizer];
    }
    return YES;
}

@end
