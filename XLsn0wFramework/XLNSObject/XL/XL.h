
#import <Foundation/Foundation.h>

@interface XL : NSObject

@end

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class YGPMemoryCache;

typedef void(^YGPCacheDataCacheObjectBlock)(NSData *data ,NSString *key);
typedef void(^YGPCacheImageCacheObjectBlock)(UIImage *image ,NSString *key);

typedef void(^YGPCacheObjectBlock)(id object,NSString *key);

@interface XLCache : NSObject

@property (nonatomic,assign)NSTimeInterval timeoutInterval;

+ (instancetype)sharedCache;
- (instancetype)initWithCacheDirectory:(NSString*)cacheDirectory;

#pragma mark save get
- (void)setDataToDiskWithData:(NSData*)data forKey:(NSString*)key;
- (void)setDataToMemoryWithData:(NSData*)data forKey:(NSString*)key;

- (void)dataForKey:(NSString*)key block:(YGPCacheDataCacheObjectBlock)block;


#pragma mark Image
- (void)setImageToDiskWithImage:(UIImage*)image forKey:(NSString*)key;
- (void)setImageToMemoryWithImage:(UIImage*)image forKey:(NSString*)key;

- (void)imageForKey:(NSString*)key block:(YGPCacheImageCacheObjectBlock)block;

#pragma mark Object

- (void)setObjectToDisk:(id<NSCopying>)object forKey:(NSString*)aKey;
- (void)setObjectToMemory:(id<NSCopying>)object forKey:(NSString*)aKey;

- (void)objectForKey:(NSString*)key block:(YGPCacheObjectBlock)block;

#pragma mark Remove
- (void)removeDiskCacheDataForKey:(NSString*)key;
- (void)removeDiskAllData;

- (void)removeMemoryCacheDataForKey:(NSString*)key;
- (void)removeMemoryAllData;


- (BOOL)isDataExistOnDiskForKey:(NSString*)key;
- (BOOL)containsMemoryObjectForKey:(NSString*)key;

- (float)diskCacheSize;
- (NSUInteger)diskCacheFileCount;

@end

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^YGPCacheDataCacheObjectBlock)(NSData *data ,NSString *key);
typedef void(^YGPCacheImageCacheObjectBlock)(UIImage *image ,NSString *key);
typedef void(^YGPCacheDataCacheImageBlock)(UIImage *image,NSString *key);

@interface YGPCacheDisk : NSObject
@property (nonatomic,assign)NSTimeInterval timeoutInterval;

+ (instancetype)sharedDisk;
- (instancetype)initWithCacheDirectory:(NSString*)cacheDirectory;

- (void)setData:(NSData*)data forKey:(NSString*)key;

- (void)dataForKey:(NSString*)key
             block:(YGPCacheDataCacheObjectBlock)block;

- (void)removeDataForKey:(NSString *)key;

- (void)removeAllData;

- (BOOL)isDataExistOnDiskForKey:(NSString *)key;

- (float)diskCacheSize;

- (NSUInteger)diskCacheFileCount;

@end

@interface YGPCacheMemory : NSObject
@property (nonatomic,assign)NSUInteger memoryCacheCountLimit;

+ (instancetype)sharedMemory;

- (void)setData:(NSData*)data forKey:(NSString*)key;

- (NSData*)objectForKey:(NSString*)key;

- (void)removeDataForKey:(NSString*)key;

- (void)removeAllData;

- (BOOL)containsDataForKey:(NSString*)key;

@end