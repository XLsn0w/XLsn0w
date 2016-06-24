
#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, copy) NSString *primaryKeyId;//主键ID
@property (nonatomic, strong) NSData *imageData;//头像
@property (nonatomic, copy) NSString *userName;//用户名
@property (nonatomic, copy) NSString *password;//密码
@property (nonatomic, copy) NSString *age;//年龄
@property (nonatomic, copy) NSString *birthday;//生日
@property (nonatomic, copy) NSString *height;//身高
@property (nonatomic, copy) NSString *weight;//体重
@property (nonatomic, copy) NSString *phoneNumber;//手机号码
@property (nonatomic, copy) NSString *address;//收货地址

@end
