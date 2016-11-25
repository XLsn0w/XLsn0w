

#import "XLsn0wTouchID.h"

@implementation XLsn0wTouchID

+ (void)showTouchIDAuthenticationWithReason:(NSString * _Nonnull)reason completion:(void (^ _Nullable)(TouchIDResult result))completion {
    [self showTouchIDAuthenticationWithReason:reason fallbackTitle:nil completion:^(TouchIDResult result) {
        completion(result);
    }];
}

+ (void)showTouchIDAuthenticationWithReason:(NSString * _Nonnull)reason fallbackTitle:(NSString * _Nullable)fallbackTitle completion:(void (^ _Nullable)(TouchIDResult))completion {
    LAContext *context = [[LAContext alloc] init];
    
    [context setLocalizedFallbackTitle:fallbackTitle];
    
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:^(BOOL success, NSError *error) {
            if (success) {
                completion(TouchIDResultSuccess);
            } else {
                switch (error.code) {
                    case LAErrorAuthenticationFailed:
                        completion(TouchIDResultAuthenticationFailed);
                        break;
                    case LAErrorUserCancel:
                        completion(TouchIDResultUserCancel);
                        break;
                    case LAErrorUserFallback:
                        completion(TouchIDResultUserFallback);
                        break;
                    case LAErrorSystemCancel:
                        completion(TouchIDResultSystemCancel);
                        break;
                    default:
                        completion(TouchIDResultError);
                        break;
                }
            }
        }];
    } else {
        switch (error.code) {
            case LAErrorPasscodeNotSet:
                completion(TouchIDResultPasscodeNotSet);
                break;
            case LAErrorTouchIDNotAvailable:
                completion(TouchIDResultNotAvailable);
                break;
            case LAErrorTouchIDNotEnrolled:
                completion(TouchIDResultNotEnrolled);
                break;
            default:
                completion(TouchIDResultError);
                break;
        }
    }
}

@end
