
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*!
 * @author XLsn0w
 *
 * < XL类方法 封装OC常用方法 提高效率 >
 */
@interface XL : NSObject

+ (NSString *)xl_getNSStringWithNumber:(NSNumber *)number;
+ (NSNumber *)xl_getNSNumberWithString:(NSString *)string;
+ (UIImage *)xl_getCompressedImageWithNewSize:(CGSize)newSize currentImage:(UIImage *)currentImage;
+ (NSData *)xl_getImageDataWithCurrentImage:(UIImage *)currentImage;
+ (NSString *)xl_getBase64EncodedStringWithCurrentImage:(UIImage *)currentImage;
+ (UIImage *)xl_getImageWithBase64EncodedString:(NSString *)base64EncodedString;
+ (void)xl_showTipText:(NSString *)tipText;

@end

#import <UIKit/UIKit.h>
#import <Foundation/NSObject.h>
#import "MBProgressHUD.h"

@interface XLMethods : NSObject

+ (NSDictionary*)dictionaryFromBundleWithName:(NSString*)fileName withType:(NSString*)typeName;
//字符串MD5转换
+ (NSString *)md5HexDigest:(NSString*)input;
+(NSString *)fileMd5sum:(NSString * )filename; //md5转换

//时间格式
+ (NSDate *)getNowTime;
+ (NSString *)getyyyymmdd;
+(NSString *)getyyyymmddHHmmss;
+ (NSString *)get1970timeString;
+ (NSString *)getTimeString:(NSDate *)date;
+ (NSString *)gethhmmss;


+ (void)showTipsWithHUD:(NSString *)labelText;
+ (void)showTipsWithHUD:(NSString *)labelText inView:(UIView *)inView;
+ (void)showTipsWithView:(UIView *)uiview labelText:(NSString *)labelText showTime:(CGFloat)time;
+ (void) showHudMessage:(NSString*) msg hideAfterDelay:(NSInteger) sec uiview:(UIView *)uiview;

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
 *  @param fontSize    字体
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
