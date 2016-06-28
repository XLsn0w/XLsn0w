
#import <Foundation/Foundation.h>

@interface User : NSObject

/*! 主键ID 检索用户索引 */
@property (nonatomic, copy) NSString *primaryKeyId;

/*! 用户头像 NSData类型 */
@property (nonatomic, strong) NSData *imageData;

/*! 用户名 */
@property (nonatomic, copy) NSString *userName;

/*! 密码 */
@property (nonatomic, copy) NSString *password;

/*! 年龄 */
@property (nonatomic, copy) NSString *age;

/*! 生日 */
@property (nonatomic, copy) NSString *birthday;

/*! 身高 */
@property (nonatomic, copy) NSString *height;

/*! 体重 */
@property (nonatomic, copy) NSString *weight;

/*! 手机号码 */
@property (nonatomic, copy) NSString *phoneNumber;

/*! 地址 */
@property (nonatomic, copy) NSString *address;

/*! 用户编号 */
@property (nonatomic, copy) NSString *userNumber;

/*! <用户ID> 格式不限，可以为数字、GUID、或者任意的字符串（中文除外）*/
@property(nonatomic, strong) NSString *userId;

/*! 头像URL 字符串类型 */
@property(nonatomic, strong) NSString *imageUrl;

/*! Token 用户令牌 */
@property(nonatomic, strong) NSString *userToken;

@end
