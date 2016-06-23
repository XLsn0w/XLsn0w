
#import <UIKit/UIKit.h>

@interface UINavigationController (SafeTransition)

@property (nonatomic, assign, getter = isTransitionInProgress) BOOL transitionInProgress;

@end

@interface XLNavigationController : UINavigationController

@end
