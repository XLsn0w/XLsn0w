
#import <Foundation/Foundation.h>
#import <FMDB.h>
#import "User.h"

@interface XLDataBase : NSObject

@property (nonatomic,retain)FMDatabase *fmdb;

//单例工具类
+ (XLDataBase *)sharedXLDataBase;

//创建数据库表
- (void)createDataBaseTableName:(NSString *)tableName;

//(增)插入
- (void)insertUser:(User *)user;

//(删)删除
- (void)deleteUserWithPrimaryKeyId:(NSString *)primaryKeyId;

//(改)更新
- (void)updateImageDataOfUser:(User *)user;
- (void)updateUserNameOfUser:(User *)user;
- (void)updatePasswordOfUser:(User *)user;
- (void)updateAgeOfUser:(User *)user;
- (void)updateBirthdayOfUser:(User *)user;
- (void)updateHeightOfUser:(User *)user;
- (void)updateWeightOfUser:(User *)user;
- (void)updatePhoneNumberOfUser:(User *)user;
- (void)updateAddressOfUser:(User *)user;
- (void)updateUserNumberOfUser:(User *)user;

//(查)获取全部数据
- (NSMutableArray *)queryDataBase;

@end
