
#import <Foundation/Foundation.h>

@class FMDatabase;
@class User;

@interface XLDatabase : NSObject

@property (nonatomic, strong) FMDatabase *fmdb;

//单例工具类
+ (XLDatabase *)sharedInstance;

//创建数据库表
- (void)createXLDatabaseWithTableName:(NSString *)tableName;

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
- (void)updateUserIdOfUser:(User *)user;
- (void)updateImageUrlOfUser:(User *)user;
- (void)updateGenderOfUser:(User *)user;

- (void)updateUserTokenWithUser:(User *)user;

//(查)取值
- (NSMutableArray *)selectUserArrayFromXLDatabase;

@end

