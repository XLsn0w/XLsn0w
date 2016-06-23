
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
        BOOL result = [_fmdb executeUpdate:@"create table XLDataBase (number integer primary key not null, imageData blob, name text, age text, phoneNumber text, address text)"];
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
        NSString *insertDatabase = [NSString stringWithFormat:@"insert into XLDataBase (number, imageData, name, age, phoneNumber, address) values(?, ?, ?, ?, ?, ?)"];
        

        BOOL result = [_fmdb executeUpdate:insertDatabase,model.number, model.imageData, model.name, model.age, model.phoneNumber, model.address];
        
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
        NSString *updateDatabase = [NSString stringWithFormat:@"update XLDataBase set imageData = ? where number = ?;"];
        BOOL result = [_fmdb executeUpdate:updateDatabase, model.imageData, model.number];
        if (result) {
            NSLog(@"更新姓名成功");
        } else {
            NSLog(@"更新失败");
        }
        [_fmdb close];
    }
}

- (void)updateName:(User *)model {
    if ([_fmdb open]) {
        NSString *updateDatabase = [NSString stringWithFormat:@"update XLDataBase set name = ? where number = ?;"];
        BOOL result = [_fmdb executeUpdate:updateDatabase, model.name, model.number];
        if (result) {
            NSLog(@"更新姓名成功");
        } else {
            NSLog(@"更新失败");
        }
        [_fmdb close];
    }
}

- (void)updateAge:(User *)model {
    if ([_fmdb open]) {
        NSString *updateDatabase = [NSString stringWithFormat:@"update XLDataBase set age = ? where number = ?;"];
        BOOL result = [_fmdb executeUpdate:updateDatabase, model.age, model.number];
        if (result) {
            NSLog(@"更新年龄成功");
        } else {
            NSLog(@"更新失败");
        }
        [_fmdb close];
    }
}

- (void)updatePhoneNumber:(User *)model {
    if ([_fmdb open]) {
        NSString *updateDatabase = [NSString stringWithFormat:@"update XLDataBase set phoneNumber = ? where number = ?;"];
        BOOL result = [_fmdb executeUpdate:updateDatabase, model.phoneNumber, model.number];
        if (result) {
            NSLog(@"更新年龄成功");
        } else {
            NSLog(@"更新失败");
        }
        [_fmdb close];
    }
}
- (void)updateAddress:(User *)model {
    if ([_fmdb open]) {
        NSString *updateDatabase = [NSString stringWithFormat:@"update XLDataBase set address = ? where number = ?;"];
        BOOL result = [_fmdb executeUpdate:updateDatabase, model.address, model.number];
        if (result) {
            NSLog(@"更新年龄成功");
        } else {
            NSLog(@"更新失败");
        }
        [_fmdb close];
    }
}


//删除一条数据
- (void)deletaWithNumber:(NSString *)number {
    if ([_fmdb open]) {
        NSString *deleteDatabase = [NSString stringWithFormat:@"delete from XLDataBase where number = ?"];
        BOOL result = [_fmdb executeUpdate:deleteDatabase, number];
        if (result) {
            NSLog(@"删除成功");
        } else {
            NSLog(@"删除失败");
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
           
            model.number = [resultSet stringForColumn:@"number"];//编号 检索索引
            
            model.imageData = [resultSet dataForColumn:@"imageData"];//头像 (NSData *)
            
            //用户各类属性
            model.name = [resultSet stringForColumn:@"name"];
            model.age = [resultSet stringForColumn:@"age"];
            model.phoneNumber = [resultSet stringForColumn:@"phoneNumber"];
            model.address = [resultSet stringForColumn:@"address"];
            
            [queryArray addObject:model];
        }
    }
    NSLog(@"查询成功");
    return queryArray;
}

@end
