
#import "XLDatabase.h"

#import "FMDatabase.h"
#import "User.h"

@implementation XLDatabase

//Create Singleton
static XLDatabase *instance = nil;
+ (XLDatabase *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XLDatabase alloc] init];
    });
    return instance;
}

//Create XLDatabase With TableName
- (void)createXLDatabaseWithTableName:(NSString *)tableName {
    if (!_fmdb) {
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *dbFileName = [NSString stringWithFormat:@"%@.db", tableName];
        NSString *databasePath = [documentsPath stringByAppendingPathComponent:dbFileName];
        _fmdb = [FMDatabase databaseWithPath:databasePath];
       }
    if ([_fmdb open]) {
        BOOL result = [_fmdb executeUpdate:@"create table XLDatabase (primaryKeyId text primary key not null, imageData blob, userName text, password text, age text, birthday text, height text, weight text, phoneNumber text, address text, userId text, imageUrl text, userToken text, token text, trueName text, estateId text, gender text, accountId text, accountType text, propertyId text)"];
        if (result) {
            NSLog(@"<创建XLDatabase成功>");
        } else {
            NSLog(@"[创建XLDatabase失败]|[本地XLDatabase存在]");
        }
        [_fmdb close];
    }
}

/*******insert user into XLDatabase****************************************************************/
- (void)insertUser:(User *)user {
    if ([_fmdb open]) {
        NSString *insertCommand = [NSString stringWithFormat:@"insert into XLDatabase (primaryKeyId, imageData, userName, password, age, birthday, height, weight, phoneNumber, address, userId, imageUrl, userToken, token, trueName, estateId, gender, accountId, accountType, propertyId) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"];
        BOOL result = [_fmdb executeUpdate:insertCommand,
                       user.primaryKeyId,
                       user.imageData,
                       user.userName,
                       user.password,
                       user.age,
                       user.birthday,
                       user.height,
                       user.weight,
                       user.phoneNumber,
                       user.address,
                       user.userId,
                       user.imageUrl,
                       user.userToken,
                       user.token,
                       user.trueName,
                       user.estateId,
                       user.gender,
                       user.accountId,
                       user.accountType,
                       user.propertyId];
        if (result) {
            NSLog(@"插入User成功");
        } else {
            NSLog(@"插入User失败");
        }
        [_fmdb close];
    }
}

/*******delete user from XLDatabase****************************************************************/
- (void)deleteUserWithPrimaryKeyId:(NSString *)primaryKeyId {
    if ([_fmdb open]) {
        NSString *deleteCommand = [NSString stringWithFormat:@"delete from XLDatabase where primaryKeyId = ?"];
        BOOL result = [_fmdb executeUpdate:deleteCommand, primaryKeyId];
        if (result) {
            NSLog(@"删除User成功");
        } else {
            NSLog(@"删除User失败");
        }
        [_fmdb close];
    }
}

/*******update XLDatabase**************************************************************************/

//update XLDatabase imageData Of User
- (void)updateImageDataOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateCommand = [NSString stringWithFormat:@"update XLDatabase set imageData = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateCommand, user.imageData, user.primaryKeyId];
        if (result) {
            NSLog(@"更新imageData成功");
        } else {
            NSLog(@"更新imageData失败");
        }
        [_fmdb close];
    }
}

//update XLDatabase userName Of User
- (void)updateUserNameOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateCommand = [NSString stringWithFormat:@"update XLDatabase set userName = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateCommand, user.userName, user.primaryKeyId];
        if (result) {
            NSLog(@"更新userName成功");
        } else {
            NSLog(@"更新userName失败");
        }
        [_fmdb close];
    }
}

//update XLDatabase password Of User
- (void)updatePasswordOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateCommand = [NSString stringWithFormat:@"update XLDatabase set password = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateCommand, user.password, user.primaryKeyId];
        if (result) {
            NSLog(@"更新password成功");
        } else {
            NSLog(@"更新password失败");
        }
        [_fmdb close];
    }
}

//update XLDatabase age Of User
- (void)updateAgeOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateCommand = [NSString stringWithFormat:@"update XLDatabase set age = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateCommand, user.age, user.primaryKeyId];
        if (result) {
            NSLog(@"更新age成功");
        } else {
            NSLog(@"更新age失败");
        }
        [_fmdb close];
    }
}

//update XLDatabase birthday Of User
- (void)updateBirthdayOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateCommand = [NSString stringWithFormat:@"update XLDatabase set birthday = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateCommand, user.birthday, user.primaryKeyId];
        if (result) {
            NSLog(@"更新birthday成功");
        } else {
            NSLog(@"更新birthday失败");
        }
        [_fmdb close];
    }
}

//update XLDatabase height Of User
- (void)updateHeightOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateCommand = [NSString stringWithFormat:@"update XLDatabase set height = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateCommand, user.height, user.primaryKeyId];
        if (result) {
            NSLog(@"更新height成功");
        } else {
            NSLog(@"更新height失败");
        }
        [_fmdb close];
    }
}

//update XLDatabase weight Of User
- (void)updateWeightOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateCommand = [NSString stringWithFormat:@"update XLDatabase set weight = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateCommand, user.weight, user.primaryKeyId];
        if (result) {
            NSLog(@"更新weight成功");
        } else {
            NSLog(@"更新weight失败");
        }
        [_fmdb close];
    }
}

//update XLDatabase phoneNumber Of User
- (void)updatePhoneNumberOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateCommand = [NSString stringWithFormat:@"update XLDatabase set phoneNumber = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateCommand, user.phoneNumber, user.primaryKeyId];
        if (result) {
            NSLog(@"更新phoneNumber成功");
        } else {
            NSLog(@"更新phoneNumber失败");
        }
        [_fmdb close];
    }
}

//update XLDatabase address Of User
- (void)updateAddressOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateCommand = [NSString stringWithFormat:@"update XLDatabase set address = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateCommand, user.address, user.primaryKeyId];
        if (result) {
            NSLog(@"更新address成功");
        } else {
            NSLog(@"更新address失败");
        }
        [_fmdb close];
    }
}

//update XLDatabase userId Of User
- (void)updateUserIdOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateCommand = [NSString stringWithFormat:@"update XLDatabase set userId = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateCommand, user.userId, user.primaryKeyId];
        if (result) {
            NSLog(@"更新userId成功");
        } else {
            NSLog(@"更新userId失败");
        }
        [_fmdb close];
    }
}

//update XLDatabase imageUrl Of User
- (void)updateImageUrlOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateCommand = [NSString stringWithFormat:@"update XLDatabase set imageUrl = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateCommand, user.imageUrl, user.primaryKeyId];
        if (result) {
            NSLog(@"更新imageUrl成功");
        } else {
            NSLog(@"更新imageUrl失败");
        }
        [_fmdb close];
    }
}

//update XLDatabase userToken Of User
- (void)updateUserTokenWithUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateCommand = [NSString stringWithFormat:@"update XLDatabase set userToken = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateCommand, user.userToken, user.primaryKeyId];
        if (result) {
            NSLog(@"更新userToken成功");
        } else {
            NSLog(@"更新userToken失败");
        }
        [_fmdb close];
    }
}

//update XLDatabase gender Of User
- (void)updateGenderOfUser:(User *)user {
    if ([_fmdb open]) {
        NSString *updateCommand = [NSString stringWithFormat:@"update XLDatabase set gender = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateCommand, user.gender, user.primaryKeyId];
        if (result) {
            NSLog(@"更新gender成功");
        } else {
            NSLog(@"更新gender失败");
        }
        [_fmdb close];
    }
}

/*******************select userArray from XLDatabase***********************************************/
- (NSMutableArray *)selectUserArrayFromXLDatabase {
    // create userArray
    NSMutableArray *userArray = [[NSMutableArray alloc] init];
    if ([_fmdb  open]) {
        // 执行查询语句
        NSString *selectCommand = @"select * from XLDatabase";
        FMResultSet *resultSet = [_fmdb executeQuery:selectCommand];
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
            user.userId = [resultSet stringForColumn:@"userId"];
            user.imageUrl = [resultSet stringForColumn:@"imageUrl"];
            user.userToken = [resultSet stringForColumn:@"userToken"];
            
            user.token = [resultSet stringForColumn:@"token"];
            user.trueName = [resultSet stringForColumn:@"trueName"];
            user.estateId = [resultSet stringForColumn:@"estateId"];
            
            user.gender = [resultSet stringForColumn:@"gender"];
            user.accountId = [resultSet stringForColumn:@"accountId"];
            user.accountType = [resultSet stringForColumn:@"accountType"];
            user.propertyId = [resultSet stringForColumn:@"propertyId"];
            
            // add user into userArray
            [userArray addObject:user];
        }
        [_fmdb close];
    }
    NSLog(@"[查询XLDatabase成功|Select UserArray Success]");
    return userArray;
}

@end
