
#import "XLDataBase.h"

@implementation XLDataBase

+ (XLDataBase *)sharedXLDataBase {
    static XLDataBase *db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        db = [[XLDataBase alloc] init];
    });
    return db;
}

//打开数据库
- (void)openDataBaseWithPath:(NSString *)path {
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject] stringByAppendingString:path];
    _fmdb = [FMDatabase databaseWithPath:dbPath];
    NSLog(@"XLDataBasePath: %@", dbPath);
}

//关闭数据库
- (void)closeDataBase {
    [_fmdb close];
}

//创建数据库表
- (void)createDataBaseTableName:(NSString *)tableName {
    if (!_fmdb) {
        [self openDataBaseWithPath:[NSString stringWithFormat:@"/%@.db", tableName]];
       }
    if ([_fmdb open]) {
        BOOL result = [_fmdb executeUpdate:@"create table XLDataBase (primaryKeyId integer primary key not null, imageData blob, userName text, password text, age text, birthday text, height text, weight text, phoneNumber text, address text)"];
        if (result) {
            NSLog(@"XLDataBase数据库=>建表成功");
        }else {
            NSLog(@"XLDataBase数据库=>建表失败/已经存在");
        }
    }
}

//插入一条数据
- (void)insertUser:(User *)user {
    if (!user) {
        NSLog(@"UserModel不存在");
        return;
    }
    if ([_fmdb open]) {
        NSString *insertDatabase = [NSString stringWithFormat:@"insert into XLDataBase (primaryKeyId, imageData, userName, password, age, birthday, height, weight, phoneNumber, address) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"];
        

        BOOL result = [_fmdb executeUpdate:insertDatabase,user.primaryKeyId, user.imageData, user.userName, user.password, user.age, user.birthday, user.height, user.weight, user.phoneNumber, user.address];
        
        if (result) {
            NSLog(@"插入UserModel成功");
        } else {
            NSLog(@"插入UserModel失败");
        }
        [_fmdb close];
    }
}

//头像
- (void)updateImageDataOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateDatabase = [NSString stringWithFormat:@"update XLDataBase set imageData = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateDatabase, user.imageData, user.primaryKeyId];
        if (result) {
            NSLog(@"更新ImageData成功");
        } else {
            NSLog(@"更新ImageData失败");
        }
        [_fmdb close];
    }
}

//用户名
- (void)updateUserNameOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateDatabase = [NSString stringWithFormat:@"update XLDataBase set userName = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateDatabase, user.userName, user.primaryKeyId];
        if (result) {
            NSLog(@"更新UserName成功");
        } else {
            NSLog(@"更新UserName失败");
        }
        [_fmdb close];
    }
}

//密码
- (void)updatePasswordOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateDatabase = [NSString stringWithFormat:@"update XLDataBase set password = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateDatabase, user.password, user.primaryKeyId];
        if (result) {
            NSLog(@"更新Password成功");
        } else {
            NSLog(@"更新Password失败");
        }
        [_fmdb close];
    }
}

//年龄
- (void)updateAgeOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateDatabase = [NSString stringWithFormat:@"update XLDataBase set age = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateDatabase, user.age, user.primaryKeyId];
        if (result) {
            NSLog(@"更新Age成功");
        } else {
            NSLog(@"更新Age失败");
        }
        [_fmdb close];
    }
}

//生日
- (void)updateBirthdayOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateDatabase = [NSString stringWithFormat:@"update XLDataBase set birthday = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateDatabase, user.birthday, user.primaryKeyId];
        if (result) {
            NSLog(@"更新Birthday成功");
        } else {
            NSLog(@"更新Birthday失败");
        }
        [_fmdb close];
    }
}

- (void)updateHeightOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateDatabase = [NSString stringWithFormat:@"update XLDataBase set height = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateDatabase, user.height, user.primaryKeyId];
        if (result) {
            NSLog(@"更新Height成功");
        } else {
            NSLog(@"更新Height失败");
        }
        [_fmdb close];
    }
}
- (void)updateWeightOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateDatabase = [NSString stringWithFormat:@"update XLDataBase set weight = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateDatabase, user.weight, user.primaryKeyId];
        if (result) {
            NSLog(@"更新Weight成功");
        } else {
            NSLog(@"更新Weight失败");
        }
        [_fmdb close];
    }
}

- (void)updatePhoneNumberOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateDatabase = [NSString stringWithFormat:@"update XLDataBase set phoneNumber = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateDatabase, user.phoneNumber, user.primaryKeyId];
        if (result) {
            NSLog(@"更新PhoneNumber成功");
        } else {
            NSLog(@"更新PhoneNumber失败");
        }
        [_fmdb close];
    }
}

- (void)updateAddressOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateDatabase = [NSString stringWithFormat:@"update XLDataBase set address = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateDatabase, user.address, user.primaryKeyId];
        if (result) {
            NSLog(@"更新Address成功");
        } else {
            NSLog(@"更新Address失败");
        }
        [_fmdb close];
    }
}

//删除一条数据
- (void)deletaWithPrimaryKeyId:(NSString *)primaryKeyId {
    if ([_fmdb open]) {
        NSString *deleteDatabase = [NSString stringWithFormat:@"delete from XLDataBase where primaryKeyId = ?"];
        BOOL result = [_fmdb executeUpdate:deleteDatabase, primaryKeyId];
        if (result) {
            NSLog(@"删除DataBase成功");
        } else {
            NSLog(@"删除DataBase失败");
        }
    }
}

/*!
 * @author XLsn0w
 *
 * 取出数据库表里面的值
 *
 * @return 一个数组
 */
- (NSMutableArray *)queryDataBase {
    NSMutableArray *queryArray = [[NSMutableArray alloc] init];
    if ([_fmdb  open]) {
        FMResultSet *resultSet = [_fmdb executeQuery:@"select * from XLDataBase"];
       
        while ([resultSet next]) {
            User *model = [[User alloc] init];
            
           //主键ID
            model.primaryKeyId = [resultSet stringForColumn:@"primaryKeyId"];
        
            //用户各类属性
            model.imageData = [resultSet dataForColumn:@"imageData"];//头像 (NSData *)
            model.userName = [resultSet stringForColumn:@"userName"];
            model.password = [resultSet stringForColumn:@"password"];
            model.age = [resultSet stringForColumn:@"age"];
            model.birthday = [resultSet stringForColumn:@"age"];
            model.height = [resultSet stringForColumn:@"age"];
            model.weight = [resultSet stringForColumn:@"age"];
            model.phoneNumber = [resultSet stringForColumn:@"phoneNumber"];
            model.address = [resultSet stringForColumn:@"address"];
            
            [queryArray addObject:model];
        }
    }
    NSLog(@"查询DataBase成功");
    return queryArray;
}

@end
