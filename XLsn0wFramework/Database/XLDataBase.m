
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

/*!
 @property (nonatomic, strong) NSData *imageData;//头像
 @property (nonatomic, copy) NSString *userName;//用户名
 @property (nonatomic, copy) NSString *password;//密码
 @property (nonatomic, copy) NSString *age;//年龄
 @property (nonatomic, copy) NSString *birthday;//生日
 @property (nonatomic, copy) NSString *height;//身高
 @property (nonatomic, copy) NSString *weight;//体重
 @property (nonatomic, copy) NSString *phoneNumber;//手机号码
 @property (nonatomic, copy) NSString *address;//收货地址
 */
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
-(void)insertModel:(User *)model {
    if (!model) {
        NSLog(@"model为空");
        return;
    }
    
    if ([_fmdb open]) {
        NSString *insertDatabase = [NSString stringWithFormat:@"insert into XLDataBase (primaryKeyId, imageData, userName, password, age, birthday, height, weight, phoneNumber, address) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"];
        

        BOOL result = [_fmdb executeUpdate:insertDatabase,model.primaryKeyId, model.imageData, model.userName, model.password, model.age, model.birthday, model.height, model.weight, model.phoneNumber, model.address];
        
        if (result) {
            NSLog(@"插入成功");
        } else {
            NSLog(@"插入失败");
        }
        [_fmdb close];
    }
}

- (void)updateImageData:(User *)model {
    if ([_fmdb open]) {
        NSString *updateDatabase = [NSString stringWithFormat:@"update XLDataBase set imageData = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateDatabase, model.imageData, model.primaryKeyId];
        if (result) {
            NSLog(@"更新成功");
        } else {
            NSLog(@"更新失败");
        }
        [_fmdb close];
    }
}

- (void)updateName:(User *)model {
    if ([_fmdb open]) {
        NSString *updateDatabase = [NSString stringWithFormat:@"update XLDataBase set userName = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateDatabase, model.userName, model.primaryKeyId];
        if (result) {
            NSLog(@"更新成功");
        } else {
            NSLog(@"更新失败");
        }
        [_fmdb close];
    }
}

- (void)updateAge:(User *)model {
    if ([_fmdb open]) {
        NSString *updateDatabase = [NSString stringWithFormat:@"update XLDataBase set age = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateDatabase, model.age, model.primaryKeyId];
        if (result) {
            NSLog(@"更新成功");
        } else {
            NSLog(@"更新失败");
        }
        [_fmdb close];
    }
}

- (void)updatePhoneNumber:(User *)model {
    if ([_fmdb open]) {
        NSString *updateDatabase = [NSString stringWithFormat:@"update XLDataBase set phoneNumber = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateDatabase, model.phoneNumber, model.primaryKeyId];
        if (result) {
            NSLog(@"更新成功");
        } else {
            NSLog(@"更新失败");
        }
        [_fmdb close];
    }
}
- (void)updateAddress:(User *)model {
    if ([_fmdb open]) {
        NSString *updateDatabase = [NSString stringWithFormat:@"update XLDataBase set address = ? where primaryKeyId = ?;"];
        BOOL result = [_fmdb executeUpdate:updateDatabase, model.address, model.primaryKeyId];
        if (result) {
            NSLog(@"更新成功");
        } else {
            NSLog(@"更新失败");
        }
        [_fmdb close];
    }
}


//删除一条数据
- (void)deletaWithNumber:(NSString *)number {
    if ([_fmdb open]) {
        NSString *deleteDatabase = [NSString stringWithFormat:@"delete from XLDataBase where primaryKeyId = ?"];
        BOOL result = [_fmdb executeUpdate:deleteDatabase, number];
        if (result) {
            NSLog(@"删除DataBase成功");
        } else {
            NSLog(@"删除DataBase失败");
        }
    }
}

//查询数据库
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
