
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
        BOOL result = [_fmdb executeUpdate:@"create table XLDataBase (primaryKeyId integer primary key not null, imageData blob, userName text, password text, age text, birthday text, height text, weight text, phoneNumber text, address text, userNumber text)"];
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
        NSLog(@"User不存在");
        return;
    }
    if ([_fmdb open]) {
        NSString *insertDatabase = [NSString stringWithFormat:@"insert into XLDataBase (primaryKeyId, imageData, userName, password, age, birthday, height, weight, phoneNumber, address, userNumber) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"];
        

        BOOL result = [_fmdb executeUpdate:insertDatabase,user.primaryKeyId, user.imageData, user.userName, user.password, user.age, user.birthday, user.height, user.weight, user.phoneNumber, user.address];
        
        if (result) {
            NSLog(@"插入User成功");
        } else {
            NSLog(@"插入User失败");
        }
        [_fmdb close];
    }
}

//头像
- (void)updateImageDataOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set imageData = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.imageData, user.primaryKeyId];
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
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set userName = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.userName, user.primaryKeyId];
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
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set password = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.password, user.primaryKeyId];
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
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set age = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.age, user.primaryKeyId];
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
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set birthday = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.birthday, user.primaryKeyId];
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
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set height = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.height, user.primaryKeyId];
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
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set weight = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.weight, user.primaryKeyId];
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
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set phoneNumber = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.phoneNumber, user.primaryKeyId];
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
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set address = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.address, user.primaryKeyId];
        if (result) {
            NSLog(@"更新Address成功");
        } else {
            NSLog(@"更新Address失败");
        }
        [_fmdb close];
    }
}
- (void)updateUserNumberOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set userNumber = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.userNumber, user.primaryKeyId];
        if (result) {
            NSLog(@"更新UserNumber成功");
        } else {
            NSLog(@"更新UserNumber失败");
        }
        [_fmdb close];
    }
}

//删除一条数据
- (void)deleteUserWithPrimaryKeyId:(NSString *)primaryKeyId {
    if ([_fmdb open]) {
        NSString *deleteString = [NSString stringWithFormat:@"delete from XLDataBase where primaryKeyId = ?"];
        BOOL result = [_fmdb executeUpdate:deleteString, primaryKeyId];
        if (result) {
            NSLog(@"删除User成功");
        } else {
            NSLog(@"删除User失败");
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
    //create userArray
    NSMutableArray *userArray = [[NSMutableArray alloc] init];
    if ([_fmdb  open]) {
        //执行查询语句
        FMResultSet *resultSet = [_fmdb executeQuery:@"select * from XLDataBase"];
        //遍历结果
        while ([resultSet next]) {
            //create user
            User *user = [[User alloc] init];
            //Primary Key ID
            user.primaryKeyId = [resultSet stringForColumn:@"primaryKeyId"];
            //user property
            user.imageData = [resultSet dataForColumn:@"imageData"];//头像 (NSData *)
            user.userName = [resultSet stringForColumn:@"userName"];
            user.password = [resultSet stringForColumn:@"password"];
            user.age = [resultSet stringForColumn:@"age"];
            user.birthday = [resultSet stringForColumn:@"age"];
            user.height = [resultSet stringForColumn:@"age"];
            user.weight = [resultSet stringForColumn:@"age"];
            user.phoneNumber = [resultSet stringForColumn:@"phoneNumber"];
            user.address = [resultSet stringForColumn:@"address"];
            user.userNumber = [resultSet stringForColumn:@"userNumber"];
            //add user to userArray
            [userArray addObject:user];
        }
    }
    NSLog(@"查询UserArray成功");
    return userArray;
}

@end
