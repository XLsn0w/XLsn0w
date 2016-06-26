
#import "XLDataBase.h"

@implementation XLDataBase

//Singleton
+ (XLDataBase *)sharedXLDataBase {
    static XLDataBase *db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        db = [[XLDataBase alloc] init];
    });
    return db;
}

//Create DataBase TableName
- (void)createDataBaseTableName:(NSString *)tableName {
    if (!_fmdb) {
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *dbFileName = [NSString stringWithFormat:@"%@.db", tableName];
        NSString *databasePath = [documentsPath stringByAppendingPathComponent:dbFileName];
        _fmdb = [FMDatabase databaseWithPath:databasePath];
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

//insert user into XLDataBase
- (void)insertUser:(User *)user {
    if ([_fmdb open]) {
        NSString *insertDatabase = [NSString stringWithFormat:@"insert into XLDataBase (primaryKeyId, imageData, userName, password, age, birthday, height, weight, phoneNumber, address, userNumber) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"];
        BOOL result = [_fmdb executeUpdate:insertDatabase,user.primaryKeyId, user.imageData, user.userName, user.password, user.age, user.birthday, user.height, user.weight, user.phoneNumber, user.address, user.userNumber];
        if (result) {
            NSLog(@"插入User成功");
        } else {
            NSLog(@"插入User失败");
        }
        [_fmdb close];
    }
}

//update XLDataBase ImageData Of User
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

//update XLDataBase UserName Of User
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

//update XLDataBase Password Of User
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

//update XLDataBase Age Of User
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

//update XLDataBase Birthday Of User
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

//update XLDataBase Height Of User
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

//update XLDataBase Weight Of User
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

//update XLDataBase PhoneNumber Of User
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

//update XLDataBase Address Of User
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

//update XLDataBase UserNumber Of User
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

//delete user from XLDataBase
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
 * Get User Model
 *
 * @return UserArray
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
            user.imageData = [resultSet dataForColumn:@"imageData"];//(NSData *)UserImage 
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
