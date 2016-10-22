
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"

/**************************************************************************************************/

/*!
 * @author XLsn0w
 *
 * < XL类方法 >
 */

/**
 *  Get App name
 */
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

/**
 *  Get App build
 */
#define APP_BUILD [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

/**
 *  Get App version
 */
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/**
 *  Use BFLocalizedString to use the string translated by BFKit
 */
#define BFLocalizedString(key, comment) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:@"BFKit"]

/**
 *  Password strength level enum, from 0 (min) to 6 (max)
 */
typedef NS_ENUM(NSInteger, PasswordStrengthLevel) {
    /**
     *  Password strength very weak
     */
    PasswordStrengthLevelVeryWeak = 0,
    /**
     *  Password strength weak
     */
    PasswordStrengthLevelWeak,
    /**
     *  Password strength average
     */
    PasswordStrengthLevelAverage,
    /**
     *  Password strength strong
     */
    PasswordStrengthLevelStrong,
    /**
     *  Password strength very strong
     */
    PasswordStrengthLevelVeryStrong,
    /**
     *  Password strength secure
     */
    PasswordStrengthLevelSecure,
    /**
     *  Password strength very secure
     */
    PasswordStrengthLevelVerySecure
};

@import AudioToolbox;
@import Foundation;

/**
 *  Audio IDs enum - http://iphonedevwiki.net/index.php/AudioServices
 */
typedef NS_ENUM(NSInteger, AudioID) {
    /**
     *  New Mail
     */
    AudioIDNewMail = 1000,
    /**
     *  Mail Sent
     */
    AudioIDMailSent = 1001,
    /**
     *  Voice Mail
     */
    AudioIDVoiceMail = 1002,
    /**
     *  Recived Message
     */
    AudioIDRecivedMessage = 1003,
    /**
     *  Sent Message
     */
    AudioIDSentMessage = 1004,
    /**
     *  Alerm
     */
    AudioIDAlarm = 1005,
    /**
     *  Low pPower
     */
    AudioIDLowPower = 1006,
    /**
     *  SMS Received 1
     */
    AudioIDSMSReceived1 = 1007,
    /**
     *  SMS Received 2
     */
    AudioIDSMSReceived2 = 1008,
    /**
     *  SMS Received 3
     */
    AudioIDSMSReceived3 = 1009,
    /**
     *  SMS Received 4
     */
    AudioIDSMSReceived4 = 1010,
    /**
     *  SMS Received 5
     */
    AudioIDSMSReceived5 = 1013,
    /**
     *  SMS Received 6
     */
    AudioIDSMSReceived6 = 1014,
    /**
     *  Tweet Sent
     */
    AudioIDTweetSent = 1016,
    /**
     *  Anticipate
     */
    AudioIDAnticipate = 1020,
    /**
     *  Bloom
     */
    AudioIDBloom = 1021,
    /**
     *  Calypso
     */
    AudioIDCalypso = 1022,
    /**
     *  Choo Choo
     */
    AudioIDChooChoo = 1023,
    /**
     *  Descent
     */
    AudioIDDescent = 1024,
    /**
     *  Fanfare
     */
    AudioIDFanfare = 1025,
    /**
     *  Ladder
     */
    AudioIDLadder = 1026,
    /**
     *  Minuet
     */
    AudioIDMinuet = 1027,
    /**
     *  News Flash
     */
    AudioIDNewsFlash = 1028,
    /**
     *  Noir
     */
    AudioIDNoir = 1029,
    /**
     *  Sherwood Forest
     */
    AudioIDSherwoodForest = 1030,
    /**
     *  Speel
     */
    AudioIDSpell = 1031,
    /**
     *  Suspance
     */
    AudioIDSuspence = 1032,
    /**
     *  Telegraph
     */
    AudioIDTelegraph = 1033,
    /**
     *  Tiptoes
     */
    AudioIDTiptoes = 1034,
    /**
     *  Typewriters
     */
    AudioIDTypewriters = 1035,
    /**
     *  Update
     */
    AudioIDUpdate = 1036,
    /**
     *  USSD Alert
     */
    AudioIDUSSDAlert = 1050,
    /**
     *  SIM Toolkit Call Dropped
     */
    AudioIDSIMToolkitCallDropped = 1051,
    /**
     *  SIM Toolkit General Beep
     */
    AudioIDSIMToolkitGeneralBeep = 1052,
    /**
     *  SIM Toolkit Negative ACK
     */
    AudioIDSIMToolkitNegativeACK = 1053,
    /**
     *  SIM Toolkit Positive ACK
     */
    AudioIDSIMToolkitPositiveACK = 1054,
    /**
     *  SIM Toolkit SMS
     */
    AudioIDSIMToolkitSMS = 1055,
    /**
     *  Tink
     */
    AudioIDTink = 1057,
    /**
     *  CT Busy
     */
    AudioIDCTBusy = 1070,
    /**
     *  CT Congestion
     */
    AudioIDCTCongestion = 1071,
    /**
     *  CT Pack ACK
     */
    AudioIDCTPathACK = 1072,
    /**
     *  CT Error
     */
    AudioIDCTError = 1073,
    /**
     *  CT Call Waiting
     */
    AudioIDCTCallWaiting = 1074,
    /**
     *  CT Keytone
     */
    AudioIDCTKeytone = 1075,
    /**
     *  Lock
     */
    AudioIDLock = 1100,
    /**
     *  Unlock
     */
    AudioIDUnlock = 1101,
    /**
     *  Failed Unlock
     */
    AudioIDFailedUnlock = 1102,
    /**
     *  Keypressed Tink
     */
    AudioIDKeypressedTink = 1103,
    /**
     *  Keypressed Tock
     */
    AudioIDKeypressedTock = 1104,
    /**
     *  Tock
     */
    AudioIDTock = 1105,
    /**
     *  Beep Beep
     */
    AudioIDBeepBeep = 1106,
    /**
     *  Ringer Charged
     */
    AudioIDRingerCharged = 1107,
    /**
     *  Photo Shutter
     */
    AudioIDPhotoShutter = 1108,
    /**
     *  Shake
     */
    AudioIDShake = 1109,
    /**
     *  JBL Begin
     */
    AudioIDJBLBegin = 1110,
    /**
     *  JBL Confirm
     */
    AudioIDJBLConfirm = 1111,
    /**
     *  JBL Cancel
     */
    AudioIDJBLCancel = 1112,
    /**
     *  Begin Recording
     */
    AudioIDBeginRecording = 1113,
    /**
     *  End Recording
     */
    AudioIDEndRecording = 1114,
    /**
     *  JBL Ambiguous
     */
    AudioIDJBLAmbiguous = 1115,
    /**
     *  JBL No Match
     */
    AudioIDJBLNoMatch = 1116,
    /**
     *  Begin Video Record
     */
    AudioIDBeginVideoRecord = 1117,
    /**
     *  End Video Record
     */
    AudioIDEndVideoRecord = 1118,
    /**
     *  VC Invitation Accepted
     */
    AudioIDVCInvitationAccepted = 1150,
    /**
     *  VC Ringing
     */
    AudioIDVCRinging = 1151,
    /**
     *  VC Ended
     */
    AudioIDVCEnded = 1152,
    /**
     *  VC Call Waiting
     */
    AudioIDVCCallWaiting = 1153,
    /**
     *  VC Call Upgrade
     */
    AudioIDVCCallUpgrade = 1154,
    /**
     *  Touch Tone 1
     */
    AudioIDTouchTone1 = 1200,
    /**
     *  Touch Tone 2
     */
    AudioIDTouchTone2 = 1201,
    /**
     *  Touch Tone 3
     */
    AudioIDTouchTone3 = 1202,
    /**
     *  Touch Tone 4
     */
    AudioIDTouchTone4 = 1203,
    /**
     *  Touch Tone 5
     */
    AudioIDTouchTone5 = 1204,
    /**
     *  Touch Tone 6
     */
    AudioIDTouchTone6 = 1205,
    /**
     *  Touch Tone 7
     */
    AudioIDTouchTone7 = 1206,
    /**
     *  Touch Tone 8
     */
    AudioIDTouchTone8 = 1207,
    /**
     *  Touch Tone 9
     */
    AudioIDTouchTone9 = 1208,
    /**
     *  Touch Tone 10
     */
    AudioIDTouchTone10 = 1209,
    /**
     *  Tone Star
     */
    AudioIDTouchToneStar = 1210,
    /**
     *  Tone Pound
     */
    AudioIDTouchTonePound = 1211,
    /**
     *  Headset Start Call
     */
    AudioIDHeadsetStartCall = 1254,
    /**
     *  Headset Redial
     */
    AudioIDHeadsetRedial = 1255,
    /**
     *  Headset Answer Call
     */
    AudioIDHeadsetAnswerCall = 1256,
    /**
     *  Headset End Call
     */
    AudioIDHeadsetEndCall = 1257,
    /**
     *  Headset Call Waiting Actions
     */
    AudioIDHeadsetCallWaitingActions = 1258,
    /**
     *  Headset Transition End
     */
    AudioIDHeadsetTransitionEnd = 1259,
    /**
     *  Voicemail
     */
    AudioIDVoicemail = 1300,
    /**
     *  Received Message
     */
    AudioIDReceivedMessage = 1301,
    /**
     *  New Mail 2
     */
    AudioIDNewMail2 = 1302,
    /**
     *  Email Sent 2
     */
    AudioIDMailSent2 = 1303,
    /**
     *  Alarm 2
     */
    AudioIDAlarm2 = 1304,
    /**
     *  Lock 2
     */
    AudioIDLock2 = 1305,
    /**
     *  Tock 2
     */
    AudioIDTock2 = 1306,
    /**
     *  SMS Received 7
     */
    AudioIDSMSReceived1_2 = 1307,
    /**
     *  SMS Received 8
     */
    AudioIDSMSReceived2_2 = 1308,
    /**
     *  SMS Received 9
     */
    AudioIDSMSReceived3_2 = 1309,
    /**
     *  SMS Received 10
     */
    AudioIDSMSReceived4_2 = 1310,
    /**
     *  SMS Received Vibrate
     */
    AudioIDSMSReceivedVibrate = 1311,
    /**
     *  SMS Received 11
     */
    AudioIDSMSReceived1_3 = 1312,
    /**
     *  SMS Received 12
     */
    AudioIDSMSReceived5_3 = 1313,
    /**
     *  SMS Received 13
     */
    AudioIDSMSReceived6_3 = 1314,
    /**
     *  Voicemail 2
     */
    AudioIDVoicemail2 = 1315,
    /**
     *  Anticipate 2
     */
    AudioIDAnticipate2 = 1320,
    /**
     *  Bloom 2
     */
    AudioIDBloom2 = 1321,
    /**
     *  Calypso 2
     */
    AudioIDCalypso2 = 1322,
    /**
     *  Choo Choo 2
     */
    AudioIDChooChoo2 = 1323,
    /**
     *  Descent 2
     */
    AudioIDDescent2 = 1324,
    /**
     *  Fanfare 2
     */
    AudioIDFanfare2 = 1325,
    /**
     *  Ladder 2
     */
    AudioIDLadder2 = 1326,
    /**
     *  Minuet 2
     */
    AudioIDMinuet2 = 1327,
    /**
     *  News Flash 2
     */
    AudioIDNewsFlash2 = 1328,
    /**
     *  Noir 2
     */
    AudioIDNoir2 = 1329,
    /**
     *  Sherwood Forest 2
     */
    AudioIDSherwoodForest2 = 1330,
    /**
     *  Speel 2
     */
    AudioIDSpell2 = 1331,
    /**
     *  Suspence 2
     */
    AudioIDSuspence2 = 1332,
    /**
     *  Telegraph 2
     */
    AudioIDTelegraph2 = 1333,
    /**
     *  Tiptoes 2
     */
    AudioIDTiptoes2 = 1334,
    /**
     *  Typewriters 2
     */
    AudioIDTypewriters2 = 1335,
    /**
     *  Update 2
     */
    AudioIDUpdate2 = 1336,
    /**
     *  Ringer View Changed
     */
    AudioIDRingerVibeChanged = 1350,
    /**
     *  Silent View Changed
     */
    AudioIDSilentVibeChanged = 1351,
    /**
     *  Vibrate
     */
    AudioIDVibrate = 4095
};

@interface XL : NSObject

/**
 *  Check the password strength level
 *
 *  @param password Password string
 *
 *  @return Returns the password strength level with value from enum PasswordStrengthLevel
 */
+ (PasswordStrengthLevel)checkPasswordStrength:(NSString * _Nonnull)password;


/**
 *  This class adds some useful methods to play system sounds
 */

/**
 *  Play a system sound from the ID
 *
 *  @param audioID ID of system audio from the AudioID enum
 */
+ (void)playSystemSound:(AudioID)audioID;

/**
 *  Play system sound vibrate
 */
+ (void)playSystemSoundVibrate;

/**
 *  Play custom sound with url
 *
 *  @param soundURL Sound URL
 *
 *  @return Returns the SystemSoundID
 */
+ (SystemSoundID)playCustomSound:(NSURL * _Nonnull)soundURL;

/**
 *  Dispose custom sound
 *
 *  @param soundID SystemSoundID
 *
 *  @return Returns YES if has been disposed, otherwise NO
 */
+ (BOOL)disposeSound:(SystemSoundID)soundID;


+ (NSString *)xl_getNSStringWithNumber:(NSNumber *)number;
+ (NSNumber *)xl_getNSNumberWithString:(NSString *)string;
+ (UIImage *)xl_getCompressedImageWithNewSize:(CGSize)newSize currentImage:(UIImage *)currentImage;
+ (NSData *)xl_getImageDataWithCurrentImage:(UIImage *)currentImage;
+ (NSString *)xl_getBase64EncodedStringWithCurrentImage:(UIImage *)currentImage;
+ (UIImage *)xl_getImageWithBase64EncodedString:(NSString *)base64EncodedString;
+ (void)xl_showTipText:(NSString *)tipText;
+ (void)xl_saveImageToAlbumWithCurrentImage:(UIImage *)currentImage;
+ (UIImage *)xl_getURLImageWithURLString:(NSString *)URLString;
+ (void)xl_getCurrentNavigationController:(UINavigationController *)currentNavigationController popToViewControllerAtTargetIndex:(NSUInteger)targetIndex;
+ (NSUInteger)xl_getCurrentIndexWithCurrentNavigationController:(UINavigationController *)currentNavigationController currentViewController:(UIViewController *)currentViewController;
+ (void)xl_getPhoneNumber:(NSString *)phoneNumber currentViewController:(UIViewController *)currentViewController;
//手机号码验证
+ (BOOL)xl_isPhoneNumber:(NSString *)phoneNumber;
+ (void)xl_showTimeoutWithCurrentSelf:(UIViewController *)currentSelf statusCode:(NSInteger)statusCode;

/**************************************************************************************************/
/**
 *  Executes a block on first start of the App for current version.
 *  Remember to execute UI instuctions on main thread
 *
 *  @param block The block to execute, returns isFirstStartForCurrentVersion
 */
+ (void)onFirstStart:(void (^ _Nullable)(BOOL isFirstStart))block;

/**
 *  Executes a block on first start of the App.
 *  Remember to execute UI instuctions on main thread
 *
 *  @param block The block to execute, returns isFirstStart
 */
+ (void)onFirstStartForCurrentVersion:(void (^ _Nullable)(BOOL isFirstStartForCurrentVersion))block;

/**
 *  Executes a block on first start of the App for current given version.
 *  Remember to execute UI instuctions on main thread
 *
 *  @param version Version to be checked
 *  @param block   The block to execute, returns isFirstStartForVersion
 */
+ (void)onFirstStartForVersion:(NSString * _Nonnull)version
                         block:(void (^ _Nullable)(BOOL isFirstStartForCurrentVersion))block;

/**
 *  Returns if is the first start of the App
 *
 *  @return Returns if is the first start of the App
 */
+ (BOOL)isFirstStart;

/**
 *  Returns if is the first start of the App for current version
 *
 *  @return Returns if is the first start of the App for current version
 */
+ (BOOL)isFirstStartForCurrentVersion;

/**
 *  Returns if is the first start of the App for the given version
 *
 *  @param version Version to be checked
 *
 *  @return Returns if is the first start of the App for the given version
 */
+ (BOOL)isFirstStartForVersion:(NSString * _Nonnull)version;

/**
 *  This class adds some useful methods to encrypt/decrypt data.
 *  All methods are static
 */

/**
 *  Create a MD5 string
 *
 *  @param string The string to be converted
 *
 *  @return Returns the MD5 NSString
 */
+ (NSString * _Nullable)MD5:(NSString * _Nonnull)string;

/**
 *  Create a SHA1 string
 *
 *  @param string The string to be converted
 *
 *  @return Returns the SHA1 NSString
 */
+ (NSString * _Nullable)SHA1:(NSString * _Nonnull)string;

/**
 *  Create a SHA256 string
 *
 *  @param string The string to be converted
 *
 *  @return Returns the SHA256 NSString
 */
+ (NSString * _Nullable)SHA256:(NSString * _Nonnull)string;

/**
 *  Create a SHA512 string
 *
 *  @param string The string to be converted
 *
 *  @return Returns the SHA512 NSString
 */
+ (NSString * _Nullable)SHA512:(NSString * _Nonnull)string;

/**
 *  Encrypt NSData in AES128
 *
 *  @param data NSData to be encrypted
 *  @param key  Key to encrypt data
 *
 *  @return Returns the encrypted NSData
 */
+ (NSData * _Nullable)AES128EncryptData:(NSData * _Nonnull)data
                                withKey:(NSString * _Nonnull)key;

/**
 *  Decrypt NSData in AES128
 *
 *  @param data NSData to be decrypted
 *  @param key  Key to decrypt data
 *
 *  @return Returns the decrypted NSData
 */
+ (NSData * _Nullable)AES128DecryptData:(NSData * _Nonnull)data
                                withKey:(NSString * _Nonnull)key;

/**
 *  Encrypt NSData in AES256
 *
 *  @param data NSData to be encrypted
 *  @param key  Key to encrypt data
 *
 *  @return Returns the encrypted NSData
 */
+ (NSData * _Nullable)AES256EncryptData:(NSData * _Nonnull)data
                                withKey:(NSString * _Nonnull)key;

/**
 *  Decrypt NSData in AES256
 *
 *  @param data NSData to be decrypted
 *  @param key  Key to decrypt data
 *
 *  @return Returns the decrypted NSData
 */
+ (NSData * _Nullable)AES256DecryptData:(NSData * _Nonnull)data
                                withKey:(NSString * _Nonnull)key;

/**
 *  Encrypt NSString in AES128
 *
 *  @param data NSString to be encrypted
 *  @param key  Key to encrypt data
 *
 *  @return Returns the encrypted NSData
 */
+ (NSData * _Nullable)AES128EncryptString:(NSString * _Nonnull)string
                                  withKey:(NSString * _Nonnull)key;

/**
 *  Decrypt NSString in AES128
 *
 *  @param data NSString to be decrypted
 *  @param key  Key to decrypt data
 *
 *  @return Returns the decrypted NSData
 */
+ (NSData * _Nullable)AES128DecryptString:(NSString * _Nonnull)string
                                  withKey:(NSString * _Nonnull)key;

/**
 *  Encrypt NSString in AES256
 *
 *  @param data NSString to be encrypted
 *  @param key  Key to encrypt data
 *
 *  @return Returns the encrypted NSData
 */
+ (NSData * _Nullable)AES256EncryptString:(NSString * _Nonnull)string
                                  withKey:(NSString * _Nonnull)key;

/**
 *  Decrypt NSString in AES256
 *
 *  @param data NSString to be decrypted
 *  @param key  Key to decrypt data
 *
 *  @return Returns the decrypted NSData
 */
+ (NSData * _Nullable)AES256DecryptString:(NSString * _Nonnull)string
                                  withKey:(NSString * _Nonnull)key;



@end

/**************************************************************************************************/

@interface XLMethods : NSObject

+ (NSDictionary*)dictionaryFromBundleWithName:(NSString*)fileName withType:(NSString*)typeName;
//字符串MD5转换
+ (NSString *)md5HexDigest:(NSString*)input;
+ (NSString *)fileMd5sum:(NSString * )filename; //md5转换

//时间格式
+ (NSDate *)getNowTime;
+ (NSString *)getyyyymmdd;
+ (NSString *)getyyyymmddHHmmss;
+ (NSString *)get1970timeString;
+ (NSString *)getTimeString:(NSDate *)date;
+ (NSString *)gethhmmss;

+ (void)showTipsWithHUD:(NSString *)labelText;
+ (void)showTipsWithHUD:(NSString *)labelText inView:(UIView *)inView;
+ (void)showTipsWithView:(UIView *)uiview labelText:(NSString *)labelText showTime:(CGFloat)time;
+ (void)showHudMessage:(NSString*)msg hideAfterDelay:(NSInteger)sec uiview:(UIView *)uiview;

//+ (NetworkStatus)getCurrentNetworkStatus;
+ (void)showNotReachabileTips;

+ (NSDate *)dateFromString:(NSString *)dateString usingFormat:(NSString*)format;
+ (NSDate *)dateFromString:(NSString *)dateString;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringFromDate:(NSDate *)date usingFormat:(NSString*)format;

//获取后台服务器主机名
//+(NSString*)readFromUmengOlineHostname;

//loadingView方法集
+(void)addLoadingViewInView:(UIView*)viewToLoadData usingUIActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)aStyle;
+(void)removeLoadingViewInView:(UIView*)viewToLoadData;
+(void)addLoadingViewInView:(UIView*)viewToLoadData usingUIActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)aStyle usingColor:(UIColor*)color;
+(void)removeLoadingViewAndLabelInView:(UIView*)viewToLoadData;
+(void)addLoadingViewAndLabelInView:(UIView*)viewToLoadData usingOrignalYPosition:(CGFloat)yPosition;
+(void)showProgessInView:(UIView *)view withExtBlock:(void (^)())exBlock withComBlock:(void (^)())comBlock;
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation; //图片旋转

//将图片保存到应用程序沙盒中去,imageNameString的格式为 @"upLoad.png"
+ (void)saveImagetoLocal:(UIImage*)image imageName:(NSString *)imageNameString;
+ (NSString *)getDeviceOSType;


//判断字符串长度
+ (int)convertToInt:(NSString*)strtemp;
//end

+(NSMutableArray *)decorateString:(NSString *)string;
//正则表达式部分
+ (BOOL) validateEmail:(NSString *)email;
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;
//用户名
+ (BOOL) validateUserName:(NSString *)name;
//密码
+ (BOOL) validatePassword:(NSString *)passWord;
//昵称
+ (BOOL) validateNickname:(NSString *)nickname;
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
//银行卡
+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber;
//银行卡后四位
+ (BOOL) validateBankCardLastNumber: (NSString *)bankCardNumber;
//CVN
+ (BOOL) validateCVNCode: (NSString *)cvnCode;
//month
+ (BOOL) validateMonth: (NSString *)month;
//year
+ (BOOL) validateYear: (NSString *)year;
//verifyCode
+ (BOOL) validateVerifyCode: (NSString *)verifyCode;
//压缩图片质量
+(UIImage *)reduceImage:(UIImage *)image percent:(float)percent;
//压缩图片尺寸
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
+ (UIColor *) colorWithHexString: (NSString *)color;
+ (NSString *)documentsDirectoryPath;
/**
 *  返回字符串所占用的尺寸
 *
 *  @param stringFont    字体
 *  @param stringSize 最大尺寸
 */
+ (CGSize)getWidthByString:(NSString*)string withFont:(UIFont*)stringFont withStringSize:(CGSize)stringSize;
/**
 *  正则表达式验证数字
 */
+ (BOOL)checkNum:(NSString *)str;

// View转化为图片
+ (UIImage *)getImageFromView:(UIView *)view;
// imageView转化为图片
+ (UIImage *)getImageFromImageView:(UIImageView *)imageView;

+ (NSInteger)getCellMaxNum:(CGFloat)cellHeight maxHeight:(CGFloat)height;//得到tableview最大页数
//匹配数字和英文字母
+ (BOOL) isNumberOrEnglish:(NSString *)string;
//匹配数字
+ (BOOL) isKimiNumber:(NSString *)number;
//是否存在字段
+ (BOOL)rangeString:(NSString *)string searchString:(NSString *)searchString;

@end

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class YGPMemoryCache;

typedef void(^YGPCacheDataCacheObjectBlock)(NSData *data ,NSString *key);
typedef void(^YGPCacheImageCacheObjectBlock)(UIImage *image ,NSString *key);

typedef void(^YGPCacheObjectBlock)(id object,NSString *key);

@interface XLCache : NSObject

@property (nonatomic,assign)NSTimeInterval timeoutInterval;

+ (instancetype)sharedCache;
- (instancetype)initWithCacheDirectory:(NSString*)cacheDirectory;

#pragma mark save get
- (void)setDataToDiskWithData:(NSData*)data forKey:(NSString*)key;
- (void)setDataToMemoryWithData:(NSData*)data forKey:(NSString*)key;

- (void)dataForKey:(NSString*)key block:(YGPCacheDataCacheObjectBlock)block;


#pragma mark Image
- (void)setImageToDiskWithImage:(UIImage*)image forKey:(NSString*)key;
- (void)setImageToMemoryWithImage:(UIImage*)image forKey:(NSString*)key;

- (void)imageForKey:(NSString*)key block:(YGPCacheImageCacheObjectBlock)block;

#pragma mark Object

- (void)setObjectToDisk:(id<NSCopying>)object forKey:(NSString*)aKey;
- (void)setObjectToMemory:(id<NSCopying>)object forKey:(NSString*)aKey;

- (void)objectForKey:(NSString*)key block:(YGPCacheObjectBlock)block;

#pragma mark Remove
- (void)removeDiskCacheDataForKey:(NSString*)key;
- (void)removeDiskAllData;

- (void)removeMemoryCacheDataForKey:(NSString*)key;
- (void)removeMemoryAllData;


- (BOOL)isDataExistOnDiskForKey:(NSString*)key;
- (BOOL)containsMemoryObjectForKey:(NSString*)key;

- (float)diskCacheSize;
- (NSUInteger)diskCacheFileCount;

@end

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^YGPCacheDataCacheObjectBlock)(NSData *data ,NSString *key);
typedef void(^YGPCacheImageCacheObjectBlock)(UIImage *image ,NSString *key);
typedef void(^YGPCacheDataCacheImageBlock)(UIImage *image,NSString *key);

@interface YGPCacheDisk : NSObject
@property (nonatomic,assign)NSTimeInterval timeoutInterval;

+ (instancetype)sharedDisk;
- (instancetype)initWithCacheDirectory:(NSString*)cacheDirectory;

- (void)setData:(NSData*)data forKey:(NSString*)key;

- (void)dataForKey:(NSString*)key
             block:(YGPCacheDataCacheObjectBlock)block;

- (void)removeDataForKey:(NSString *)key;

- (void)removeAllData;

- (BOOL)isDataExistOnDiskForKey:(NSString *)key;

- (float)diskCacheSize;

- (NSUInteger)diskCacheFileCount;

@end

@interface YGPCacheMemory : NSObject
@property (nonatomic,assign)NSUInteger memoryCacheCountLimit;

+ (instancetype)sharedMemory;

- (void)setData:(NSData*)data forKey:(NSString*)key;

- (NSData*)objectForKey:(NSString*)key;

- (void)removeDataForKey:(NSString*)key;

- (void)removeAllData;

- (BOOL)containsDataForKey:(NSString*)key;

@end

@interface XLTools : NSObject

+ (NSString *)xl_htmlShuangyinhao:(NSString *)values;
+ (UIColor *)xl_colorWithHexString:(NSString *)stringToConvert;
+ (NSString *)xl_nullDefultString:(NSString *)fromString null:(NSString *)nullStr;

#pragma 正则匹配邮箱号
+ (BOOL)checkMailAccount:(NSString *)mail;

#pragma 正则匹配手机号
+ (BOOL)checkPhoneNumber:(NSString *)phoneNumber;

#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *)password;

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *)userName;

#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIDCard: (NSString *)IDCard;

#pragma 正则匹配URL
+ (BOOL)checkURL:(NSString *)url;

/*****************************************************/

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber:(NSString *)number;
#pragma 正则匹配昵称
+ (BOOL)checkNickname:(NSString *)nickname;
#pragma 正则匹配以C开头的18位字符
+ (BOOL) checkCtooNumberTo18:(NSString *)nickNumber;
#pragma 正则匹配以C开头字符
+ (BOOL) checkCtooNumber:(NSString *)nickNumber;
#pragma 正则匹配银行卡号是否正确
+ (BOOL) checkBankNumber:(NSString *)bankNumber;
#pragma 正则匹配17位车架号
+ (BOOL) checkCheJiaNumber:(NSString *)cheJiaNumber;
#pragma 正则只能输入数字和字母
+ (BOOL) checkTeshuZifuNumber:(NSString *)cheJiaNumber;
#pragma 车牌号验证
+ (BOOL)checkCarNumber:(NSString *)carNumber;

@end

/***********************************************************************************/

/// 文件管理类
@interface XLFileManager : NSObject

/// 把对象归档存到沙盒里
+(void)saveObject:(id)object byFileName:(NSString*)fileName;
/// 通过文件名从沙盒中找到归档的对象
+(id)getObjectByFileName:(NSString*)fileName;

/// 根据文件名删除沙盒中的 plist 文件
+(void)removeFileByFileName:(NSString*)fileName;

/// 存储用户偏好设置 到 NSUserDefults
+(void)saveUserData:(id)data forKey:(NSString*)key;

/// 读取用户偏好设置
+(id)readUserDataForKey:(NSString*)key;

/// 删除用户偏好设置
+(void)removeUserDataForkey:(NSString*)key;

@end

/***********************************************************************************/

@interface LocalPush : NSObject

+ (NSDate *)fireDateWithWeek:(NSInteger)week
                        hour:(NSInteger)hour
                      minute:(NSInteger)minute
                      second:(NSInteger)second;

//本地发送推送（先取消上一个 再push现在的）
+ (void)localPushForDate:(NSDate *)fireDate
                  forKey:(NSString *)key
               alertBody:(NSString *)alertBody
             alertAction:(NSString *)alertAction
               soundName:(NSString *)soundName
             launchImage:(NSString *)launchImage
                userInfo:(NSDictionary *)userInfo
              badgeCount:(NSUInteger)badgeCount
          repeatInterval:(NSCalendarUnit)repeatInterval;

#pragma mark - 退出
+ (void)cancelAllLocalPhsh;

+ (void)cancleLocalPushWithKey:(NSString *)key;

@end

struct SolarTerm {
    __unsafe_unretained NSString *solarName;
    int solarDate;
};

@interface XLCalendar : NSObject {
    NSArray *HeavenlyStems;//天干表
    NSArray *EarthlyBranches;//地支表
    NSArray *LunarZodiac;//生肖表
    NSArray *SolarTerms;//24节气表
    NSArray *arrayMonth;//农历月表
    NSArray *arrayDay;//农历天表
    
    NSDate *thisdate;
    
    int year;//年
    int month;//月
    int day;//日
    
    int lunarYear;	//农历年
    int lunarMonth;	//农历月
    int doubleMonth;	//闰月
    bool isLeap;	  //是否闰月标记
    int lunarDay;	//农历日
    
    struct SolarTerm solarTerm[2];
    
    NSString *yearHeavenlyStem;//年天干
    NSString *monthHeavenlyStem;//月天干
    NSString *dayHeavenlyStem;//日天干
    
    NSString *yearEarthlyBranch;//年地支
    NSString *monthEarthlyBranch;//月地支
    NSString *dayEarthlyBranch;//日地支
    
    NSString *monthLunar;//农历月
    NSString *dayLunar;//农历日
    
    NSString *zodiacLunar;//生肖
    
    NSString *solarTermTitle; //24节气
    
    //added by cyrusleung
    NSMutableArray *holiday;//节日
}

-(void)loadWithDate:(NSDate *)date;//加载数据

-(void)InitializeValue;//添加数据
-(int)LunarYearDays:(int)y;
-(int)DoubleMonth:(int)y;
-(int)DoubleMonthDays:(int)y;
-(int)MonthDays:(int)y :(int)m;
-(void)ComputeSolarTerm;

-(double)Term:(int)y :(int)n :(bool)pd;
-(double)AntiDayDifference:(int)y :(double)x;
-(double)EquivalentStandardDay:(int)y :(int)m :(int)d;
-(int)IfGregorian:(int)y :(int)m :(int)d :(int)opt;
-(int)DayDifference:(int)y :(int)m :(int)d;
-(double)Tail:(double)x;

-(NSString *)MonthLunar;//农历
-(NSString *)DayLunar;//农历日
-(NSString *)ZodiacLunar;//年生肖
-(NSString *)YearHeavenlyStem;//年天干
-(NSString *)MonthHeavenlyStem;//月天干
-(NSString *)DayHeavenlyStem;//日天干
-(NSString *)YearEarthlyBranch;//年地支
-(NSString *)MonthEarthlyBranch;//月地支
-(NSString *)DayEarthlyBranch;//日地支
-(NSString *)SolarTermTitle;//节气
-(NSMutableArray *)Holiday;//节日
-(bool)IsLeap;//是不是农历闰年？？
-(int)GregorianYear;//阳历年
-(int)GregorianMonth;//阳历月
-(int)GregorianDay;//阳历天
-(int)Weekday;//一周的第几天
-(NSString *)Constellation;//星座

@end


@interface NSDate (XLCalendar)

/****************************************************
 *@Description:获得NSDate对应的中国日历（农历）的NSDate
 *@Params:nil
 *@Return:NSDate对应的中国日历（农历）的LunarCalendar
 ****************************************************/
- (XLCalendar *)chineseCalendarDate;//加载中国农历

@end

@interface XLDateTime : NSObject

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;

- (NSDate *)convertDate;

@end
