
#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "User.h"

@interface XLDataBase : NSObject

@property (nonatomic,retain)FMDatabase *fmdb;

//单例工具类
+ (XLDataBase *)sharedXLDataBase;

//打开数据库
- (void)openDataBaseWithPath:(NSString *)path;

//关闭数据库
- (void)closeDataBase;

//创建数据库表
- (void)createDataBaseTableName:(NSString *)tableName;

//(增)插入
- (void)insertModel:(User *)model;
//(删)删除
- (void)deletaWithNumber:(NSString *)number;
//(改)更新
- (void)updateImageData:(User *)model;
- (void)updateName:(User *)model;
- (void)updateAge:(User *)model;
- (void)updatePhoneNumber:(User *)model;
- (void)updateAddress:(User *)model;

//(查)获取全部数据
- (NSMutableArray *)queryDataBase;

@end
