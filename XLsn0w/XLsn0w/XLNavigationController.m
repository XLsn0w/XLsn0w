
#import "XLNavigationController.h"

typedef void (^TransitionBlock)(void);

@interface XLNavigationController () <UINavigationControllerDelegate>

@property (nonatomic, assign) BOOL transitionInProgress;
@property (nonatomic, strong) NSMutableArray *peddingBlocks;
@property (nonatomic, assign) CGFloat systemVersion;

@end

@implementation XLNavigationController

#pragma mark - Creating Navigation Controllers

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _transitionInProgress = NO;
    _peddingBlocks = [NSMutableArray arrayWithCapacity:2];
    _systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
}

#pragma mark - Pushing and Popping Stack Items

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (_systemVersion >= 8.0) {
        [super pushViewController:viewController animated:animated];
    }
    else {
        [self addTransitionBlock:^{
            [super pushViewController:viewController animated:animated];
        }];
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    UIViewController *poppedViewController = nil;
    if (_systemVersion >= 8.0) {
        poppedViewController = [super popViewControllerAnimated:animated];
    }
    else {
        __weak XLNavigationController *weakSelf = self;
        [self addTransitionBlock:^{
            UIViewController *viewController = [super popViewControllerAnimated:animated];
            if (viewController == nil) {
                weakSelf.transitionInProgress = NO;
            }
        }];
    }
    return poppedViewController;
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSArray *poppedViewControllers = nil;
    if (_systemVersion >= 8.0) {
        poppedViewControllers = [super popToViewController:viewController animated:animated];
    }
    else {
        __weak XLNavigationController *weakSelf = self;
        [self addTransitionBlock:^{
            if ([weakSelf.viewControllers containsObject:viewController]) {
                NSArray *viewControllers = [super popToViewController:viewController animated:animated];
                if (viewControllers.count == 0) {
                    weakSelf.transitionInProgress = NO;
                }
            }
            else {
                weakSelf.transitionInProgress = NO;
            }
        }];
    }
    return poppedViewControllers;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    NSArray *poppedViewControllers = nil;
    if (_systemVersion >= 8.0) {
        poppedViewControllers = [super popToRootViewControllerAnimated:animated];
    }
    else {
        __weak XLNavigationController *weakSelf = self;
        [self addTransitionBlock:^{
            NSArray *viewControllers = [super popToRootViewControllerAnimated:animated];
            if (viewControllers.count == 0) {
                weakSelf.transitionInProgress = NO;
            }
        }];
    }
    return poppedViewControllers;
}

#pragma mark - Accessing Items on the Navigation Stack

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated {
    if (_systemVersion >= 8.0) {
        [super setViewControllers:viewControllers animated:animated];
    }
    else {
        __weak XLNavigationController *weakSelf = self;
        [self addTransitionBlock:^{
            NSArray *originalViewControllers = weakSelf.viewControllers;
            [super setViewControllers:viewControllers animated:animated];
            if (!animated || originalViewControllers.lastObject == viewControllers.lastObject) {
                weakSelf.transitionInProgress = NO;
            }
        }];
    }
}

#pragma mark - Transition Manager

- (void)addTransitionBlock:(void (^)(void))block {
    if (![self isTransitionInProgress]) {
        self.transitionInProgress = YES;
        block();
    }
    else {
        [_peddingBlocks addObject:[block copy]];
    }
}

- (BOOL)isTransitionInProgress {
    return _transitionInProgress;
}

- (void)setTransitionInProgress:(BOOL)transitionInProgress {
    _transitionInProgress = transitionInProgress;
    if (!transitionInProgress && _peddingBlocks.count > 0) {
        _transitionInProgress = YES;
        [self runNextTransition];
    }
}

- (void)runNextTransition {
    TransitionBlock block = _peddingBlocks.firstObject;
    [_peddingBlocks removeObject:block];
    block();
}

@end

