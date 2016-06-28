//
//  UIDevice+PasscodeStatus.h
//  PasscodeStatus
//
//  Created by Liam Nichols on 02/09/2014.
//  Copyright (c) 2014 Liam Nichols. All rights reserved.
//

/**
 *  @Author(作者)         Liam Nichols
 *
 *  @URL(地址)            https://github.com/liamnichols/UIDevice-PasscodeStatus
 *
 *  @Version(版本)        20150620
 *
 *  @Requirements(运行要求)  iOS 8  && A Physical Device
 *
 *  @Description(描述)    A UIDevice category to determine if the passcode is currently set on the device or not.
 *  @Usage(使用) ..
 */
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JKPasscodeStatus){
    /* The passcode status was unknown */
    JKPasscodeStatusUnknown   = 0,
    /* The passcode is enabled */
    JKPasscodeStatusEnabled   = 1,
    /* The passcode is disabled */
    JKPasscodeStatusDisabled  = 2
};

@interface UIDevice (JKPasscodeStatus)

/**
 *  Determines if the device supports the `passcodeStatus` check. Passcode check is only supported on iOS 8.
 */
@property (readonly) BOOL jk_passcodeStatusSupported;

/**
 *  Checks and returns the devices current passcode status.
 *  If `passcodeStatusSupported` returns NO then `LNPasscodeStatusUnknown` will be returned.
 */
@property (readonly) JKPasscodeStatus jk_passcodeStatus;

@end
