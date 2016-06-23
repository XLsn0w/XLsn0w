
#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, copy) NSString *number;//编号 检索索引

@property (nonatomic, strong) NSData *imageData;//头像

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *address;

@end
