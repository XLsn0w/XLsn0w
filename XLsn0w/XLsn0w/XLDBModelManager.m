
#import "XLDBModelManager.h"
#import "XLDBModel.h"
#import <objc/runtime.h>

@interface XLDBModelManager ()

@property (nonatomic, retain) FMDatabaseQueue *dbQueue;

@end

@implementation XLDBModelManager

static XLDBModelManager *instance = nil;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init] ;
    }) ;
    return instance;
}

+ (NSString *)dbPathWithDirectoryName:(NSString *)directoryName {
    NSString *docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *filemanage = [NSFileManager defaultManager];
    if (directoryName == nil || directoryName.length == 0) {
        docsdir = [docsdir stringByAppendingPathComponent:@"JKBD"];
    } else {
        docsdir = [docsdir stringByAppendingPathComponent:directoryName];
    }
    BOOL isDir;
    BOOL exit =[filemanage fileExistsAtPath:docsdir isDirectory:&isDir];
    if (!exit || !isDir) {
        [filemanage createDirectoryAtPath:docsdir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *dbpath = [docsdir stringByAppendingPathComponent:@"jkdb.sqlite"];
    return dbpath;
}

+ (NSString *)dbPath {
    return [self dbPathWithDirectoryName:nil];
}

- (FMDatabaseQueue *)dbQueue {
    if (_dbQueue == nil) {
        _dbQueue = [[FMDatabaseQueue alloc] initWithPath:[self.class dbPath]];
    }
    return _dbQueue;
}

- (BOOL)changeDBWithDirectoryName:(NSString *)directoryName {
    if (instance.dbQueue) {
        instance.dbQueue = nil;
    }
    instance.dbQueue = [[FMDatabaseQueue alloc] initWithPath:[XLDBModelManager dbPathWithDirectoryName:directoryName]];
    
    int numClasses;
    Class *classes = NULL;
    numClasses = objc_getClassList(NULL,0);
    
    if (numClasses >0 )
    {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (int i = 0; i < numClasses; i++) {
            if (class_getSuperclass(classes[i]) == [instance class]){
                id class = classes[i];
                [class performSelector:@selector(createTable) withObject:nil];
            }
        }
        free(classes);
    }
    
    return YES;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [XLDBModelManager sharedInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [XLDBModelManager sharedInstance];
}

#if ! __has_feature(objc_arc)
- (oneway void)release {
    
}

- (id)autorelease {
    return instance;
}

- (NSUInteger)retainCount {
    return 1;
}
#endif

@end
