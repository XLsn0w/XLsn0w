
#import "XLDBModel.h"
#import "XLDBModelManager.h"
#import <objc/runtime.h>

@implementation XLDBModel

#pragma mark - override method
+ (void)initialize {
    if (self != [XLDBModel self]) {
        [self createTable];
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSDictionary *dic = [self.class getAllProperties];
        _columeNames = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"name"]];
        _columeTypes = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"type"]];
    }
    
    return self;
}

#pragma mark - base method
/**
 *  获取该类的所有属性
 */
+ (NSDictionary *)getPropertys
{
    NSMutableArray *proNames = [NSMutableArray array];
    NSMutableArray *proTypes = [NSMutableArray array];
    NSArray *theTransients = [[self class] transients];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        //获取属性名
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        if ([theTransients containsObject:propertyName]) {
            continue;
        }
        [proNames addObject:propertyName];
        //获取属性类型等参数
        NSString *propertyType = [NSString stringWithCString: property_getAttributes(property) encoding:NSUTF8StringEncoding];
        /*
         各种符号对应类型，部分类型在新版SDK中有所变化，如long 和long long
         c char         C unsigned char
         i int          I unsigned int
         l long         L unsigned long
         s short        S unsigned short
         d double       D unsigned double
         f float        F unsigned float
         q long long    Q unsigned long long
         B BOOL
         @ 对象类型 //指针 对象类型 如NSString 是@“NSString”
         
         
         64位下long 和long long 都是Tq
         SQLite 默认支持五种数据类型TEXT、INTEGER、REAL、BLOB、NULL
         因为在项目中用的类型不多，故只考虑了少数类型
         */
        if ([propertyType hasPrefix:@"T@"]) {
            [proTypes addObject:SQLTEXT];
        } else if ([propertyType hasPrefix:@"Ti"]||[propertyType hasPrefix:@"TI"]||[propertyType hasPrefix:@"Ts"]||[propertyType hasPrefix:@"TS"]||[propertyType hasPrefix:@"TB"]||[propertyType hasPrefix:@"Tq"]||[propertyType hasPrefix:@"TQ"]) {
            [proTypes addObject:SQLINTEGER];
        } else {
            [proTypes addObject:SQLREAL];
        }
        
    }
    free(properties);
    
    return [NSDictionary dictionaryWithObjectsAndKeys:proNames,@"name",proTypes,@"type",nil];
}

/** 获取所有属性，包含主键pk */
+ (NSDictionary *)getAllProperties
{
    NSDictionary *dict = [self.class getPropertys];
    
    NSMutableArray *proNames = [NSMutableArray array];
    NSMutableArray *proTypes = [NSMutableArray array];
    [proNames addObject:@"PrimaryKeyID"];
    [proTypes addObject:[NSString stringWithFormat:@"%@ %@",SQLINTEGER, @"PrimaryKeyID"]];
    [proNames addObjectsFromArray:[dict objectForKey:@"name"]];
    [proTypes addObjectsFromArray:[dict objectForKey:@"type"]];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:proNames,@"name",proTypes,@"type",nil];
}

/** 数据库中是否存在表 */
+ (BOOL)isExistInTable {
    __block BOOL res = NO;
    XLDBModelManager *dbManager = [XLDBModelManager sharedInstance];
    [dbManager.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
         res = [db tableExists:tableName];
    }];
    return res;
}

/** 获取列名 */
+ (NSArray *)getColumns
{
    XLDBModelManager *dbManager = [XLDBModelManager sharedInstance];
    NSMutableArray *columns = [NSMutableArray array];
     [dbManager.dbQueue inDatabase:^(FMDatabase *db) {
         NSString *tableName = NSStringFromClass(self.class);
         FMResultSet *resultSet = [db getTableSchema:tableName];
         while ([resultSet next]) {
             NSString *column = [resultSet stringForColumn:@"name"];
             [columns addObject:column];
         }
     }];
    return [columns copy];
}

/**
 * 创建表
 * 如果已经创建，返回YES
 */
+ (BOOL)createTable
{
    __block BOOL res = YES;
    XLDBModelManager *dbManager = [XLDBModelManager sharedInstance];
    [dbManager.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *columeAndType = [self.class getColumeAndTypeString];
        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@);",tableName,columeAndType];
        if (![db executeUpdate:sql]) {
            res = NO;
            *rollback = YES;
            return;
        };
        
        NSMutableArray *columns = [NSMutableArray array];
        FMResultSet *resultSet = [db getTableSchema:tableName];
        while ([resultSet next]) {
            NSString *column = [resultSet stringForColumn:@"name"];
            [columns addObject:column];
        }
        NSDictionary *dict = [self.class getAllProperties];
        NSArray *properties = [dict objectForKey:@"name"];
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",columns];
        //过滤数组
        NSArray *resultArray = [properties filteredArrayUsingPredicate:filterPredicate];
        for (NSString *column in resultArray) {
            NSUInteger index = [properties indexOfObject:column];
            NSString *proType = [[dict objectForKey:@"type"] objectAtIndex:index];
            NSString *fieldSql = [NSString stringWithFormat:@"%@ %@",column,proType];
            NSString *sql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN %@ ",NSStringFromClass(self.class),fieldSql];
            if (![db executeUpdate:sql]) {
                res = NO;
                *rollback = YES;
                return ;
            }
        }
    }];
    
    return res;
}

/**
 * 创建表
 * 如果已经创建，返回YES
 */
//+ (BOOL)createTable
//{
//    FMDatabase *db = [FMDatabase databaseWithPath:[JKDBHelper dbPath]];
//    if (![db open]) {
//        NSLog(@"数据库打开失败!");
//        return NO;
//    }
//    
//    NSString *tableName = NSStringFromClass(self.class);
//    NSString *columeAndType = [self.class getColumeAndTypeString];
//    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@);",tableName,columeAndType];
//    if (![db executeUpdate:sql]) {
//        return NO;
//    }
//    
//    NSMutableArray *columns = [NSMutableArray array];
//    FMResultSet *resultSet = [db getTableSchema:tableName];
//    while ([resultSet next]) {
//        NSString *column = [resultSet stringForColumn:@"name"];
//        [columns addObject:column];
//    }
//    NSDictionary *dict = [self.class getAllProperties];
//    NSArray *properties = [dict objectForKey:@"name"];
//    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",columns];
//    //过滤数组
//    NSArray *resultArray = [properties filteredArrayUsingPredicate:filterPredicate];
//
//    for (NSString *column in resultArray) {
//        NSUInteger index = [properties indexOfObject:column];
//        NSString *proType = [[dict objectForKey:@"type"] objectAtIndex:index];
//        NSString *fieldSql = [NSString stringWithFormat:@"%@ %@",column,proType];
//        NSString *sql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN %@ ",NSStringFromClass(self.class),fieldSql];
//        if (![db executeUpdate:sql]) {
//            return NO;
//        }
//    }
//    [db close];
//    return YES;
//}

- (BOOL)saveOrUpdate {
    id primaryValue = [self valueForKey:@"PrimaryKeyID"];
    if ([primaryValue intValue] <= 0) {
        return [self save];
    }
    
    return [self update];
}

- (BOOL)saveOrUpdateByColumnName:(NSString*)columnName AndColumnValue:(NSString*)columnValue
{
    id record = [self.class findFirstByCriteria:[NSString stringWithFormat:@"where %@ = %@",columnName,columnValue]];
    if (record) {
        id primaryValue = [record valueForKey:@"PrimaryKeyID"]; //取到了主键PK
        if ([primaryValue intValue] <= 0) {
            return [self save];
        }else{
            self.PrimaryKeyID = [primaryValue integerValue];
            return [self update];
        }
    }else{
        return [self save];
    }
}

- (BOOL)save {
    NSString *tableName = NSStringFromClass(self.class);
    NSMutableString *keyString = [NSMutableString string];
    NSMutableString *valueString = [NSMutableString string];
    NSMutableArray *insertValues = [NSMutableArray  array];
    for (int i = 0; i < self.columeNames.count; i++) {
        NSString *proname = [self.columeNames objectAtIndex:i];
        if ([proname isEqualToString:@"PrimaryKeyID"]) {
            continue;
        }
        [keyString appendFormat:@"%@,", proname];
        [valueString appendString:@"?,"];
        id value = [self valueForKey:proname];
        if (!value) {
            value = @"";
        }
        [insertValues addObject:value];
    }
    
    [keyString deleteCharactersInRange:NSMakeRange(keyString.length - 1, 1)];
    [valueString deleteCharactersInRange:NSMakeRange(valueString.length - 1, 1)];
    
    XLDBModelManager *dbManager = [XLDBModelManager sharedInstance];
    __block BOOL res = NO;
    [dbManager.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(%@) VALUES (%@);", tableName, keyString, valueString];
        res = [db executeUpdate:sql withArgumentsInArray:insertValues];
        self.PrimaryKeyID = res?[NSNumber numberWithLongLong:db.lastInsertRowId].intValue:0;
        NSLog(res?@"插入成功":@"插入失败");
    }];
    return res;
}

/** 批量保存用户对象 */
+ (BOOL)saveObjects:(NSArray *)array
{
    //判断是否是JKBaseModel的子类
    for (XLDBModel *model in array) {
        if (![model isKindOfClass:[XLDBModel class]]) {
            return NO;
        }
    }
    
    __block BOOL res = YES;
    XLDBModelManager *dbManager = [XLDBModelManager sharedInstance];
    // 如果要支持事务
    [dbManager.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (XLDBModel *model in array) {
            NSString *tableName = NSStringFromClass(model.class);
            NSMutableString *keyString = [NSMutableString string];
            NSMutableString *valueString = [NSMutableString string];
            NSMutableArray *insertValues = [NSMutableArray  array];
            for (int i = 0; i < model.columeNames.count; i++) {
                NSString *proname = [model.columeNames objectAtIndex:i];
                if ([proname isEqualToString:@"PrimaryKeyID"]) {
                    continue;
                }
                [keyString appendFormat:@"%@,", proname];
                [valueString appendString:@"?,"];
                id value = [model valueForKey:proname];
                if (!value) {
                    value = @"";
                }
                [insertValues addObject:value];
            }
            [keyString deleteCharactersInRange:NSMakeRange(keyString.length - 1, 1)];
            [valueString deleteCharactersInRange:NSMakeRange(valueString.length - 1, 1)];
            
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(%@) VALUES (%@);", tableName, keyString, valueString];
            BOOL flag = [db executeUpdate:sql withArgumentsInArray:insertValues];
            model.PrimaryKeyID = flag?[NSNumber numberWithLongLong:db.lastInsertRowId].intValue:0;
            NSLog(flag?@"插入成功":@"插入失败");
            if (!flag) {
                res = NO;
                *rollback = YES;
                return;
            }
        }
    }];
    return res;
}

/** 更新单个对象 */
- (BOOL)update {
    XLDBModelManager *dbManager = [XLDBModelManager sharedInstance];
    __block BOOL res = NO;
    [dbManager.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        id primaryValue = [self valueForKey:@"PrimaryKeyID"];
        if (!primaryValue || primaryValue <= 0) {
            return ;
        }
        NSMutableString *keyString = [NSMutableString string];
        NSMutableArray *updateValues = [NSMutableArray  array];
        for (int i = 0; i < self.columeNames.count; i++) {
            NSString *proname = [self.columeNames objectAtIndex:i];
            if ([proname isEqualToString:@"PrimaryKeyID"]) {
                continue;
            }
            [keyString appendFormat:@" %@=?,", proname];
            id value = [self valueForKey:proname];
            if (!value) {
                value = @"";
            }
            [updateValues addObject:value];
        }
        
        //删除最后那个逗号
        [keyString deleteCharactersInRange:NSMakeRange(keyString.length - 1, 1)];
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@ = ?;", tableName, keyString, @"PrimaryKeyID"];
        [updateValues addObject:primaryValue];
        res = [db executeUpdate:sql withArgumentsInArray:updateValues];
        NSLog(res?@"更新成功":@"更新失败");
    }];
    return res;
}

/** 批量更新用户对象*/
+ (BOOL)updateObjects:(NSArray *)array
{
    for (XLDBModel *model in array) {
        if (![model isKindOfClass:[XLDBModel class]]) {
            return NO;
        }
    }
    __block BOOL res = YES;
    XLDBModelManager *dbManager = [XLDBModelManager sharedInstance];
    // 如果要支持事务
    [dbManager.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (XLDBModel *model in array) {
            NSString *tableName = NSStringFromClass(model.class);
            id primaryValue = [model valueForKey:@"PrimaryKeyID"];
            if (!primaryValue || primaryValue <= 0) {
                res = NO;
                *rollback = YES;
                return;
            }
            
            NSMutableString *keyString = [NSMutableString string];
            NSMutableArray *updateValues = [NSMutableArray  array];
            for (int i = 0; i < model.columeNames.count; i++) {
                NSString *proname = [model.columeNames objectAtIndex:i];
                if ([proname isEqualToString:@"PrimaryKeyID"]) {
                    continue;
                }
                [keyString appendFormat:@" %@=?,", proname];
                id value = [model valueForKey:proname];
                if (!value) {
                    value = @"";
                }
                [updateValues addObject:value];
            }
            
            //删除最后那个逗号
            [keyString deleteCharactersInRange:NSMakeRange(keyString.length - 1, 1)];
            NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@=?;", tableName, keyString, @"PrimaryKeyID"];
            [updateValues addObject:primaryValue];
            BOOL flag = [db executeUpdate:sql withArgumentsInArray:updateValues];
            NSLog(flag?@"更新成功":@"更新失败");
            if (!flag) {
                res = NO;
                *rollback = YES;
                return;
            }
        }
    }];
    
    return res;
}

/** 删除单个对象 */
- (BOOL)deleteObject {
    XLDBModelManager *dbManager = [XLDBModelManager sharedInstance];
    __block BOOL res = NO;
    [dbManager.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        id primaryValue = [self valueForKey:@"PrimaryKeyID"];
        if (!primaryValue || primaryValue <= 0) {
            return ;
        }
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?",tableName, @"PrimaryKeyID"];
        res = [db executeUpdate:sql withArgumentsInArray:@[primaryValue]];
         NSLog(res?@"删除成功":@"删除失败");
    }];
    return res;
}

/** 批量删除用户对象 */
+ (BOOL)deleteObjects:(NSArray *)array
{
    for (XLDBModel *model in array) {
        if (![model isKindOfClass:[XLDBModel class]]) {
            return NO;
        }
    }
    
    __block BOOL res = YES;
    XLDBModelManager *dbManager = [XLDBModelManager sharedInstance];
    // 如果要支持事务
    [dbManager.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (XLDBModel *model in array) {
            NSString *tableName = NSStringFromClass(model.class);
            id primaryValue = [model valueForKey:@"PrimaryKeyID"];
            if (!primaryValue || primaryValue <= 0) {
                return ;
            }
            
            NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?",tableName, @"PrimaryKeyID"];
            BOOL flag = [db executeUpdate:sql withArgumentsInArray:@[primaryValue]];
             NSLog(flag?@"删除成功":@"删除失败");
            if (!flag) {
                res = NO;
                *rollback = YES;
                return;
            }
        }
    }];
    return res;
}

/** 通过条件删除数据 */
+ (BOOL)deleteObjectsByCriteria:(NSString *)criteria {
    XLDBModelManager *jkDB = [XLDBModelManager sharedInstance];
    __block BOOL res = NO;
    [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ %@ ",tableName,criteria];
        res = [db executeUpdate:sql];
        NSLog(res?@"删除成功":@"删除失败");
    }];
    return res;
}

/** 通过条件删除 (多参数）--2 */
+ (BOOL)deleteObjectsWithFormat:(NSString *)format, ...
{
    va_list ap;
    va_start(ap, format);
    NSString *criteria = [[NSString alloc] initWithFormat:format locale:[NSLocale currentLocale] arguments:ap];
    va_end(ap);
    
    return [self deleteObjectsByCriteria:criteria];
}

/** 清空表 */
+ (BOOL)clearTable {
    XLDBModelManager *dbManager = [XLDBModelManager sharedInstance];
    __block BOOL res = NO;
    [dbManager.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@",tableName];
        res = [db executeUpdate:sql];
        NSLog(res?@"清空成功":@"清空失败");
    }];
    return res;
}

/** 查询全部数据 */
+ (NSArray *)findAll {
    XLDBModelManager *dbManager = [XLDBModelManager sharedInstance];
    NSMutableArray *users = [NSMutableArray array];
    [dbManager.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            XLDBModel *model = [[self.class alloc] init];
            for (int i=0; i< model.columeNames.count; i++) {
                 NSString *columeName = [model.columeNames objectAtIndex:i];
                 NSString *columeType = [model.columeTypes objectAtIndex:i];
                 if ([columeType isEqualToString:SQLTEXT]) {
                     [model setValue:[resultSet stringForColumn:columeName] forKey:columeName];
                 } else {
                     [model setValue:[NSNumber numberWithLongLong:[resultSet longLongIntForColumn:columeName]] forKey:columeName];
                 }
             }
            [users addObject:model];
            FMDBRelease(model);
        }
    }];
    
    return users;
}

+ (instancetype)findFirstWithFormat:(NSString *)format, ...
{
    va_list ap;
    va_start(ap, format);
    NSString *criteria = [[NSString alloc] initWithFormat:format locale:[NSLocale currentLocale] arguments:ap];
    va_end(ap);
    
    return [self findFirstByCriteria:criteria];
}

/** 查找某条数据 */
+ (instancetype)findFirstByCriteria:(NSString *)criteria
{
    NSArray *results = [self.class findByCriteria:criteria];
    if (results.count < 1) {
        return nil;
    }
    
    return [results firstObject];
}

+ (instancetype)findByPK:(int)inPk
{
    NSString *condition = [NSString stringWithFormat:@"WHERE %@=%d", @"PrimaryKeyID", inPk];
    return [self findFirstByCriteria:condition];
}

+ (NSArray *)findWithFormat:(NSString *)format, ...
{
    va_list ap;
    va_start(ap, format);
    NSString *criteria = [[NSString alloc] initWithFormat:format locale:[NSLocale currentLocale] arguments:ap];
    va_end(ap);
    
    return [self findByCriteria:criteria];
}

/** 通过条件查找数据 */
+ (NSArray *)findByCriteria:(NSString *)criteria {
    XLDBModelManager *dbManager = [XLDBModelManager sharedInstance];
    NSMutableArray *users = [NSMutableArray array];
    [dbManager.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ %@",tableName,criteria];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            XLDBModel *model = [[self.class alloc] init];
            for (int i=0; i< model.columeNames.count; i++) {
                NSString *columeName = [model.columeNames objectAtIndex:i];
                NSString *columeType = [model.columeTypes objectAtIndex:i];
                if ([columeType isEqualToString:SQLTEXT]) {
                    [model setValue:[resultSet stringForColumn:columeName] forKey:columeName];
                } else {
                    [model setValue:[NSNumber numberWithLongLong:[resultSet longLongIntForColumn:columeName]] forKey:columeName];
                }
            }
            [users addObject:model];
            FMDBRelease(model);
        }
    }];
    
    return users;
}

#pragma mark - util method
+ (NSString *)getColumeAndTypeString
{
    NSMutableString* pars = [NSMutableString string];
    NSDictionary *dict = [self.class getAllProperties];
    
    NSMutableArray *proNames = [dict objectForKey:@"name"];
    NSMutableArray *proTypes = [dict objectForKey:@"type"];
    
    for (int i=0; i< proNames.count; i++) {
        [pars appendFormat:@"%@ %@",[proNames objectAtIndex:i],[proTypes objectAtIndex:i]];
        if(i+1 != proNames.count)
        {
            [pars appendString:@","];
        }
    }
    return pars;
}

- (NSString *)description
{
    NSString *result = @"";
    NSDictionary *dict = [self.class getAllProperties];
    NSMutableArray *proNames = [dict objectForKey:@"name"];
    for (int i = 0; i < proNames.count; i++) {
        NSString *proName = [proNames objectAtIndex:i];
        id  proValue = [self valueForKey:proName];
        result = [result stringByAppendingFormat:@"%@:%@\n",proName,proValue];
    }
    return result;
}

#pragma mark - must be override method
/** 如果子类中有一些property不需要创建数据库字段，那么这个方法必须在子类中重写
 */
+ (NSArray *)transients
{
    return [NSArray array];
}

@end
