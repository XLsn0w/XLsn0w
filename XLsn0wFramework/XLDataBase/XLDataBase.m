
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

//Create XLDataBase With TableName
- (void)createXLDataBaseWithTableName:(NSString *)tableName {
    if (!_fmdb) {
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *dbFileName = [NSString stringWithFormat:@"%@.db", tableName];
        NSString *databasePath = [documentsPath stringByAppendingPathComponent:dbFileName];
        _fmdb = [FMDatabase databaseWithPath:databasePath];
       }
    if ([_fmdb open]) {
        BOOL result = [_fmdb executeUpdate:@"create table XLDataBase (primaryKeyId integer primary key not null, imageData blob, userName text, password text, age text, birthday text, height text, weight text, phoneNumber text, address text, userNumber text, userId text, imageUrl text, userToken text)"];
        if (result) {
            NSLog(@"<创建XLDataBase成功>");
        } else {
            NSLog(@"[创建XLDataBase失败]|[本地XLDataBase存在]");
        }
        [_fmdb close];
    }
}

//insert user into XLDataBase
- (void)insertUser:(User *)user {
    if ([_fmdb open]) {
        NSString *insertDatabase = [NSString stringWithFormat:@"insert into XLDataBase (primaryKeyId, imageData, userName, password, age, birthday, height, weight, phoneNumber, address, userNumber, userId, imageUrl, userToken) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"];
        BOOL result = [_fmdb executeUpdate:insertDatabase,user.primaryKeyId, user.imageData, user.userName, user.password, user.age, user.birthday, user.height, user.weight, user.phoneNumber, user.address, user.userNumber, user.userId, user.imageUrl, user.userToken];
        if (result) {
            NSLog(@"插入User成功");
        } else {
            NSLog(@"插入User失败");
        }
        [_fmdb close];
    }
}

//update XLDataBase imageData Of User
- (void)updateImageDataOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set imageData = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.imageData, user.primaryKeyId];
        if (result) {
            NSLog(@"更新imageData成功");
        } else {
            NSLog(@"更新imageData失败");
        }
        [_fmdb close];
    }
}

//update XLDataBase userName Of User
- (void)updateUserNameOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set userName = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.userName, user.primaryKeyId];
        if (result) {
            NSLog(@"更新userName成功");
        } else {
            NSLog(@"更新userName失败");
        }
        [_fmdb close];
    }
}

//update XLDataBase password Of User
- (void)updatePasswordOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set password = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.password, user.primaryKeyId];
        if (result) {
            NSLog(@"更新password成功");
        } else {
            NSLog(@"更新password失败");
        }
        [_fmdb close];
    }
}

//update XLDataBase age Of User
- (void)updateAgeOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set age = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.age, user.primaryKeyId];
        if (result) {
            NSLog(@"更新age成功");
        } else {
            NSLog(@"更新age失败");
        }
        [_fmdb close];
    }
}

//update XLDataBase birthday Of User
- (void)updateBirthdayOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set birthday = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.birthday, user.primaryKeyId];
        if (result) {
            NSLog(@"更新birthday成功");
        } else {
            NSLog(@"更新birthday失败");
        }
        [_fmdb close];
    }
}

//update XLDataBase height Of User
- (void)updateHeightOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set height = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.height, user.primaryKeyId];
        if (result) {
            NSLog(@"更新height成功");
        } else {
            NSLog(@"更新height失败");
        }
        [_fmdb close];
    }
}

//update XLDataBase weight Of User
- (void)updateWeightOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set weight = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.weight, user.primaryKeyId];
        if (result) {
            NSLog(@"更新weight成功");
        } else {
            NSLog(@"更新weight失败");
        }
        [_fmdb close];
    }
}

//update XLDataBase phoneNumber Of User
- (void)updatePhoneNumberOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set phoneNumber = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.phoneNumber, user.primaryKeyId];
        if (result) {
            NSLog(@"更新phoneNumber成功");
        } else {
            NSLog(@"更新phoneNumber失败");
        }
        [_fmdb close];
    }
}

//update XLDataBase address Of User
- (void)updateAddressOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set address = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.address, user.primaryKeyId];
        if (result) {
            NSLog(@"更新address成功");
        } else {
            NSLog(@"更新address失败");
        }
        [_fmdb close];
    }
}

//update XLDataBase userNumber Of User
- (void)updateUserNumberOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set userNumber = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.userNumber, user.primaryKeyId];
        if (result) {
            NSLog(@"更新userNumber成功");
        } else {
            NSLog(@"更新userNumber失败");
        }
        [_fmdb close];
    }
}

//update XLDataBase userId Of User
- (void)updateUserIdOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set userId = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.userId, user.primaryKeyId];
        if (result) {
            NSLog(@"更新userId成功");
        } else {
            NSLog(@"更新userId失败");
        }
        [_fmdb close];
    }
}

//update XLDataBase imageUrl Of User
- (void)updateImageUrlOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set imageUrl = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.imageUrl, user.primaryKeyId];
        if (result) {
            NSLog(@"更新imageUrl成功");
        } else {
            NSLog(@"更新imageUrl失败");
        }
        [_fmdb close];
    }
}

//update XLDataBase userToken Of User
- (void)updateUserTokenOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateString = [NSString stringWithFormat:@"update XLDataBase set userToken = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateString, user.userToken, user.primaryKeyId];
        if (result) {
            NSLog(@"更新userToken成功");
        } else {
            NSLog(@"更新userToken失败");
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

/*! Query XLDataBase return userArray */
- (NSMutableArray *)queryXLDataBase {
    // create userArray
    NSMutableArray *userArray = [[NSMutableArray alloc] init];
    if ([_fmdb  open]) {
        // 执行查询语句
        FMResultSet *resultSet = [_fmdb executeQuery:@"select * from XLDataBase"];
        // 遍历结果
        while ([resultSet next]) {
            //create user
            User *user = [[User alloc] init];
            
            // Primary Key ID
            user.primaryKeyId = [resultSet stringForColumn:@"primaryKeyId"];
            
            // user property
            user.imageData = [resultSet dataForColumn:@"imageData"];//NSData *
            
            // NSString *
            user.userName = [resultSet stringForColumn:@"userName"];
            user.password = [resultSet stringForColumn:@"password"];
            user.age = [resultSet stringForColumn:@"age"];
            user.birthday = [resultSet stringForColumn:@"age"];
            user.height = [resultSet stringForColumn:@"age"];
            user.weight = [resultSet stringForColumn:@"age"];
            user.phoneNumber = [resultSet stringForColumn:@"phoneNumber"];
            user.address = [resultSet stringForColumn:@"address"];
            user.userNumber = [resultSet stringForColumn:@"userNumber"];
            user.userId = [resultSet stringForColumn:@"userId"];
            user.imageUrl = [resultSet stringForColumn:@"imageUrl"];
            user.userToken = [resultSet stringForColumn:@"userToken"];
            
            // add user into userArray
            [userArray addObject:user];
        }
    }
    NSLog(@"查询XLDataBase成功<Get UserArray Success>");
    return userArray;
}

@end
