
#import "XL.h"

@implementation XL

@end

static NSString   *const YGPCacheDirectoryName  = @"YLCache";

static inline NSString *escapedString(NSString *key){
    
    if (![key length])return @"";
    
    CFStringRef static const charsToEscape = CFSTR(".:/");
    CFStringRef escapedString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (__bridge CFStringRef)key,
                                                                        NULL,
                                                                        charsToEscape,
                                                                        kCFStringEncodingUTF8);
    return (__bridge_transfer NSString *)escapedString;
}

static inline NSString *unescapedString(NSString *key){
    
    if (![key length])return @"";
    
    CFStringRef unescapedString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef)key,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    return (__bridge_transfer NSString *)unescapedString;
}

@interface XLCache ()
@property (nonatomic,strong)YGPCacheMemory *cacheMemory;
@property (nonatomic,strong)YGPCacheDisk   *cacheDisk;

@end

@implementation XLCache

+ (instancetype)sharedCache{
    
    static XLCache *_ygp_YGPCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ygp_YGPCache = [[XLCache alloc]init];
    });
    
    return _ygp_YGPCache;
}
- (instancetype)init{
    return [self initWithCacheDirectory:YGPCacheDirectoryName];
}

- (instancetype)initWithCacheDirectory:(NSString*)cacheDirectory{
    
    self = [super init];
    
    if (self) {
        
        _cacheDisk   = [[YGPCacheDisk alloc]initWithCacheDirectory:cacheDirectory];
        _cacheMemory = [YGPCacheMemory sharedMemory];
        
    }
    return self;
    
}

#pragma mark Data
- (void)setDataToDiskWithData:(NSData *)data forKey:(NSString *)key{
    [_cacheDisk setData:data forKey:escapedString(key)];
}

- (void)setDataToMemoryWithData:(NSData *)data forKey:(NSString *)key{
    [_cacheMemory setData:data forKey:escapedString(key)];
}

- (void)dataForKey:(NSString *)key block:(YGPCacheDataCacheObjectBlock)block{
    [_cacheDisk dataForKey:escapedString(key) block:^(NSData *data, NSString *key) {
        if (block) {
            block(data,unescapedString(key));
        }
    }];
}


#pragma mark Image
- (void)setImageToDiskWithImage:(UIImage *)image forKey:(NSString *)key{
    [self setDataToDiskWithData:UIImageJPEGRepresentation(image, 1.f) forKey:key];
}

- (void)setImageToMemoryWithImage:(UIImage *)image forKey:(NSString *)key{
    [self setDataToMemoryWithData:UIImageJPEGRepresentation(image, 1.f) forKey:key];
}

- (void)imageForKey:(NSString *)key block:(YGPCacheImageCacheObjectBlock)block{
    
    [_cacheDisk dataForKey:key block:^(NSData *data, NSString *key) {
        
        UIImage *image = [UIImage imageWithData:data];
        
        if (block) {
            block(image,unescapedString(key));
        }
        
    }];
}

#pragma mark Object
- (void)setObjectToDisk:(id<NSCopying>)object forKey:(NSString*)aKey{
    
    NSData *Data = [NSKeyedArchiver archivedDataWithRootObject:object];
    [self setDataToDiskWithData:Data forKey:aKey];
}

- (void)setObjectToMemory:(id<NSCopying>)object forKey:(NSString *)aKey{
    
    NSData *Data = [NSKeyedArchiver archivedDataWithRootObject:object];
    [self setDataToMemoryWithData:Data forKey:aKey];
}

- (void)objectForKey:(NSString *)key block:(YGPCacheObjectBlock)block{
    
    [_cacheDisk dataForKey:key block:^(NSData *data, NSString *key) {
        
        id obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        if (block) {
            block(obj,unescapedString(key));
        }
    }];
}

#pragma mark Remove

- (void)removeDiskCacheDataForKey:(NSString *)key{
    [_cacheDisk removeDataForKey:escapedString(key)];
}

- (void)removeDiskAllData{
    [_cacheDisk removeAllData];
}

- (void)removeMemoryCacheDataForKey:(NSString *)key{
    [_cacheMemory removeDataForKey:escapedString(key)];
}

- (void)removeMemoryAllData{
    [_cacheMemory removeAllData];
}

#pragma mark search

- (BOOL)isDataExistOnDiskForKey:(NSString *)key{
    return [_cacheDisk isDataExistOnDiskForKey:escapedString(key)];
}

- (BOOL)containsMemoryObjectForKey:(NSString *)key{
    return [_cacheMemory containsDataForKey:escapedString(key)];
}

- (float)diskCacheSize{
    return [_cacheDisk diskCacheSize];
}

- (NSUInteger)diskCacheFileCount{
    return [_cacheDisk diskCacheFileCount];
}

@end

static char       *const YGPCacheDiskIOQueue            = "YGPCacheDiskIOQueue";
static NSString   *const YGPCacheAttributeListName      = @"YGPCacheAttributeList";
//static NSString   *const YGPCacheDirectoryName          = @"YLCache";

@interface YGPCacheDisk ()
@property (nonatomic,strong) NSFileManager    *fileManager;
@property (nonatomic,copy)   NSString         *cacheDiskPath;
@property (nonatomic,strong) dispatch_queue_t diskIoQueue;
@property (nonatomic,strong) YGPCacheMemory   *memoryCache;
@end

@implementation YGPCacheDisk

+ (instancetype)sharedDisk{
    
    static YGPCacheDisk *_ygp_YGPCacheDisk= nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ygp_YGPCacheDisk = [[YGPCacheDisk alloc]init];
    });
    
    return _ygp_YGPCacheDisk;
}

- (instancetype)init{
    return [self initWithCacheDirectory:YGPCacheDirectoryName];
}

- (instancetype)initWithCacheDirectory:(NSString*)cacheDirectory{
    
    self = [super init];
    
    if (self) {
        [self ygp_initMethodWithCacheDirectory:cacheDirectory];
    }
    return self;
    
}

- (void)ygp_initMethodWithCacheDirectory:(NSString*)cacheDirectory{
    
    _cacheDiskPath = [[self ygp_CacheDirectory:cacheDirectory] copy];
    _diskIoQueue   = dispatch_queue_create(YGPCacheDiskIOQueue, DISPATCH_QUEUE_SERIAL);
    _memoryCache   = [YGPCacheMemory sharedMemory];
    
    [self setTimeoutInterval:60*60*24*2];
    
    [self clearTimeoutDiskFile];
}


- (NSString*)ygp_CacheDirectory:(NSString*)cacheDirectory{
    
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *ygp_cachePath = [docDir stringByAppendingPathComponent:cacheDirectory];
    
    self.fileManager = [[NSFileManager alloc]init];
    BOOL isDir       = false;
    
    if (![_fileManager fileExistsAtPath:ygp_cachePath isDirectory:&isDir]) {
        
        NSError *error = nil;
        
        BOOL res = [_fileManager createDirectoryAtPath:ygp_cachePath
                           withIntermediateDirectories:YES
                                            attributes:nil
                                                 error:&error];
        
        if (!res) {
            NSLog(@"创建文件目录失败 %@",error);
        }
    }
    
    return ygp_cachePath;
}

- (NSString*)ygp_filePathWithKey:(NSString*)key{
    NSString *path = [NSString stringWithFormat:@"%@/%@",_cacheDiskPath,key];
    return path;
}

#pragma mark Disk add get remove
- (void)setData:(NSData *)data forKey:(NSString *)key{
    
    if (![key length] ||![data length]) {return;}
    
    dispatch_async(self.diskIoQueue, ^{
        
        BOOL      isCacheSuccess;
        NSData   *writeData    = data;
        NSString *path         = [self ygp_filePathWithKey:key];
        isCacheSuccess  = [writeData writeToFile:path atomically:YES];
        
        [self addTimeoutListForKey:key];
        
    });
}


- (void)dataForKey:(NSString*)key
             block:(YGPCacheDataCacheObjectBlock)block{
    
    if (![key length]) {
        if (block) {
            block(nil,nil);
        }
    }
    
    dispatch_async(self.diskIoQueue, ^{
        
        NSData *cacheData = nil;
        
        // Memory cache data
        // 查看内存中
        cacheData = [_memoryCache objectForKey:key];
        
        if (cacheData) {
            if (block){
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(cacheData,key);
                });
            }
        }else{
            
            NSString *path = [self ygp_filePathWithKey:key];
            
            if ([_fileManager fileExistsAtPath:path]) {
                cacheData = [NSData dataWithContentsOfFile:path options:0 error:nil];
            }
            
            // data write the memory
            if (cacheData) {
                [_memoryCache setData:cacheData forKey:key];
            }
            
            if (block){
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(cacheData,key);
                    
                });
            }
        }
    });
}

- (void)removeDataForKey:(NSString *)key{
    
    if (![key length]) {return;}
    
    dispatch_async(self.diskIoQueue, ^{
        
        [_fileManager removeItemAtPath:key error:nil];
        [_memoryCache removeDataForKey:key];
        
    });
}

- (void)removeAllData{
    
    dispatch_async(self.diskIoQueue, ^{
        
        NSDirectoryEnumerator * fileEnumerator = [_fileManager enumeratorAtPath:_cacheDiskPath];
        
        for (NSString *fileName in fileEnumerator) {
            [_fileManager removeItemAtPath:fileName error:nil];
        }
        
    });
}

- (BOOL)isDataExistOnDiskForKey:(NSString *)key{
    
    __block BOOL isContains  = NO;
    dispatch_sync(self.diskIoQueue, ^{
        
        NSString *path = [self ygp_filePathWithKey:key];
        if ([_fileManager fileExistsAtPath:path]) {
            isContains = YES;
        }
    });
    
    return isContains;
}

#pragma mark

- (float)diskCacheSize{
    
    __block float folderSize = 0;
    
    if (![_fileManager fileExistsAtPath:_cacheDiskPath])
        return 0;
    
    dispatch_sync(self.diskIoQueue, ^{
        
        NSDirectoryEnumerator *fileEnumerator = [_fileManager enumeratorAtPath:_cacheDiskPath];
        
        for (NSString *fileName in fileEnumerator) {
            
            NSString *filePath = [_cacheDiskPath stringByAppendingPathComponent:fileName];
            folderSize += [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil] fileSize];
            
        }
    });
    
    return folderSize / (1024.0 * 1024.0); //Mb
}

- (NSUInteger)diskCacheFileCount{
    
    __block NSUInteger fileCount = 0;
    
    dispatch_sync(self.diskIoQueue, ^{
        
        NSDirectoryEnumerator *fileEnumerator = [_fileManager enumeratorAtPath:_cacheDiskPath];
        fileCount = [[fileEnumerator allObjects] count];
        
    });
    
    return fileCount;
}

#pragma mark TimeoutList

- (NSMutableDictionary*)getTimeoutList{
    
    __block NSData *cacheListData  = nil;
    NSMutableDictionary *cacheList = nil;
    NSString * filePath = [self ygp_filePathWithKey:YGPCacheAttributeListName];
    cacheListData = [NSData dataWithContentsOfFile:filePath
                                           options:0
                                             error:nil];
    
    if (!cacheListData) {
        cacheList = [[NSMutableDictionary alloc]init];
    }else{
        cacheList = [[NSJSONSerialization JSONObjectWithData:cacheListData
                                                     options:kNilOptions
                                                       error:nil] mutableCopy];
    }
    
    return cacheList;
    
}

- (void)addTimeoutListForKey:(NSString*)key{
    
    //每次添加缓存数据的将在缓存列表中添加一个时间戳
    
    NSTimeInterval now = [[NSDate date] timeIntervalSinceReferenceDate];
    
    NSMutableDictionary *cacheList = [[NSMutableDictionary alloc]init];
    [cacheList addEntriesFromDictionary:[self getTimeoutList]];
    
    [cacheList setObject:[NSString stringWithFormat:@"%f",now] forKey:key];
    
    [self cacheTimeListForData:cacheList];
    
}

- (void)clearTimeoutDiskFile{
    
    
    NSTimeInterval now             = [[NSDate date] timeIntervalSinceReferenceDate];
    NSMutableArray *timeoutKeys    = [[NSMutableArray alloc]init];
    NSMutableDictionary *cacheList = [[NSMutableDictionary alloc]init];
    
    [cacheList addEntriesFromDictionary:[self getTimeoutList]];
    
    for (NSString *key in cacheList) {
        
        if ((now - [cacheList[key] doubleValue]) >= _timeoutInterval) {
            
            [[NSFileManager defaultManager] removeItemAtPath:[self ygp_filePathWithKey:key]
                                                       error:nil];
            [timeoutKeys addObject:key];
            
        }
    }
    
    [cacheList removeObjectsForKeys:timeoutKeys];
    [self cacheTimeListForData:cacheList];
    
}

- (void)cacheTimeListForData:(NSMutableDictionary*)dict{
    
    NSData *cacheListData = [NSJSONSerialization dataWithJSONObject:dict
                                                            options:NSJSONWritingPrettyPrinted
                                                              error:nil];
    
    [cacheListData writeToFile:[self ygp_filePathWithKey:YGPCacheAttributeListName] atomically:YES];
}

@end


#pragma mark memory cache
@interface YGPMemoryCacheNode :NSObject
@property (nonatomic,copy)   NSString       *key;
@property (nonatomic,assign) NSTimeInterval accessedTime;
@property (nonatomic,assign) NSUInteger     accessedCount;
@end

@implementation YGPMemoryCacheNode

- (instancetype)initWithKey:(NSString*)key forAccessedCount:(NSUInteger)AccessedCount{
    
    self = [super init];
    
    if (self) {
        _key               = [key copy];
        _accessedCount     = AccessedCount;
        NSTimeInterval now = [[NSDate date] timeIntervalSinceReferenceDate];
        _accessedTime      = now;
        
    }
    return self;
}
@end

static inline YGPMemoryCacheNode *memoryCacheNode(NSString *key,NSUInteger accessedCount){
    
    YGPMemoryCacheNode * cacheNode = [[YGPMemoryCacheNode alloc]initWithKey:key
                                                           forAccessedCount:accessedCount];
    
    return cacheNode;
}


static NSUInteger  const YGPCacheCacheMemoryObjLimit    = 35; //max count
//static NSString   *const YGPCacheAttributeListName      = @"YGPCacheAttributeList";
static char       *const YGPCacheMemoryIOQueue          = "YGPCacheMemoryIOQueue";

@interface YGPCacheMemory ()
{
    NSMutableDictionary *_cacheData;
    NSMutableArray      *_recentlyAccessedKeys;
    NSMutableDictionary *_recentlyNode;
    NSTimeInterval       _recentlyHandleTime;
    NSUInteger           _minAccessedCount;
}

@property (nonatomic,strong) dispatch_queue_t memoryIoQueue;
@end

@implementation YGPCacheMemory

+ (instancetype)sharedMemory{
    
    static YGPCacheMemory *_ygp_YGPCacheMemory = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ygp_YGPCacheMemory = [[YGPCacheMemory alloc]init];
    });
    return _ygp_YGPCacheMemory;
}

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        _cacheData             = [[NSMutableDictionary alloc]init];
        _recentlyNode          = [[NSMutableDictionary alloc]init];
        _recentlyAccessedKeys  = [[NSMutableArray alloc]init];
        _recentlyHandleTime    = [[NSDate date] timeIntervalSinceReferenceDate];
        _minAccessedCount      = 1;
        _memoryCacheCountLimit = YGPCacheCacheMemoryObjLimit;
        _memoryIoQueue         = dispatch_queue_create(YGPCacheMemoryIOQueue, DISPATCH_QUEUE_SERIAL);
        
        [[NSNotificationCenter defaultCenter]addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * __unused note) {
            [self removeAllData];
        }];
        
        [[NSNotificationCenter defaultCenter]addObserverForName:UIApplicationWillTerminateNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * __unused note) {
            [self removeAllData];
        }];
        
        [[NSNotificationCenter defaultCenter]addObserverForName:UIApplicationWillResignActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * __unused note) {
            [self removeAllData];
        }];
        
        
        
    }
    return self;
}

- (void)setData:(NSData*)data forKey:(NSString*)key{
    
    if (![key length] ||![data length]) {return;}
    
    dispatch_async(_memoryIoQueue, ^{
        
        [_cacheData setObject:data forKey:key];
        
    });
    
}

- (NSData*)objectForKey:(NSString*)key{
    
    if (![key length]) {return nil;}
    
    __block NSData *cacheData = nil;
    
    dispatch_sync(_memoryIoQueue, ^{
        
        cacheData = _cacheData[key];
        
        if (cacheData) {
            [self timeoutObjForKey:key];
        }
        
    });
    
    return cacheData;
}

- (void)removeAllData{
    
    dispatch_async(_memoryIoQueue, ^{
        
        [_cacheData            removeAllObjects];
        [_recentlyAccessedKeys removeAllObjects];
        [_recentlyNode         removeAllObjects];
    });
}

- (void)removeDataForKey:(NSString*)key{
    
    if (![key length]) {return;}
    
    dispatch_async(_memoryIoQueue, ^{
        
        [_cacheData removeObjectForKey:key];
        if ([_recentlyAccessedKeys containsObject:key]) {
            [_recentlyAccessedKeys removeObject:key];
            [_recentlyNode         removeObjectForKey:key];
        }
    });
}

- (BOOL)containsDataForKey:(NSString*)key{
    
    __block BOOL isContains = NO;
    
    dispatch_sync(_memoryIoQueue, ^{
        if (_cacheData[key]) {
            isContains = YES;
        }
    });
    
    return isContains;
}

- (void)timeoutObjForKey:(NSString*)key{
    
    /*
     
     获取一个缓存数据，就将其移动到队列的最顶端，队列内越后的数据就是调用得最少次的
     设置一个内存LIMIT 最大值，当缓存数据超过了最大值。每次有新的数据进入列队，就会讲
     列队的最后一个缓存数据移除掉。
     
     每个缓存数据都会组建成一个结构体 里面包含 （访问次数 ，访问时间）
     每隔3分钟的时候就会去调用 队列  将访问次数最小和访问时间离现在最久的数据将其出列
     
     */
    
    YGPMemoryCacheNode *node = nil;
    
    if ([_recentlyAccessedKeys containsObject:key]) {
        [_recentlyAccessedKeys removeObject:key];
        
        node = _recentlyNode[key];
        [_recentlyNode removeObjectForKey:key];
    }
    
    [_recentlyAccessedKeys insertObject:key atIndex:0];
    
    //增加内存访问的计时和时间
    NSUInteger accessedCount = 1;
    if (node)accessedCount   = node.accessedCount+1;
    
    //获取最小的访问数
    if (accessedCount < _minAccessedCount) _minAccessedCount = accessedCount;
    
    [_recentlyNode setObject:memoryCacheNode(key, accessedCount) forKey:key];
    
    //移除近期不访问
    if (_recentlyAccessedKeys.count >= YGPCacheCacheMemoryObjLimit) {
        NSString *lastObjKey = [_recentlyAccessedKeys lastObject];
        [_cacheData    removeObjectForKey:lastObjKey];
        [_recentlyNode removeObjectForKey:lastObjKey];
    }
    
    //remove timeout data
    NSTimeInterval now     = [[NSDate date] timeIntervalSinceReferenceDate];
    NSTimeInterval timeout = 60 * 5;
    
    if ((now - _recentlyHandleTime) >= timeout) {
        
        [_recentlyNode enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            YGPMemoryCacheNode *node = (YGPMemoryCacheNode*)obj;
            
            if ((now - node.accessedTime) >= timeout && node.accessedCount <= _minAccessedCount) {
                
                [_cacheData            removeObjectForKey:key];
                [_recentlyNode         removeObjectForKey:key];
                [_recentlyAccessedKeys removeObject:key];
                
            }
        }];
    }
    
    
    _recentlyHandleTime = now;
}

@end
