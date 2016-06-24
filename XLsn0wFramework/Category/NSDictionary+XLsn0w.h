
#import <Foundation/Foundation.h>

@interface NSDictionary (XLsn0w)

@end

@interface NSDictionary (StringToDictionary)

+ (nonnull NSDictionary *)transformStringToDictionaryWithStr:(nonnull NSString *)string;

@end

@interface NSDictionary (ModelToDictionary)

/**
 *  模型转字典
 *
 *  @return 字典
 */
+ (nonnull NSDictionary *)dictionaryFromModel;

/**
 *  带model的数组或字典转字典
 *
 *  @param object 带model的数组或字典转
 *
 *  @return 字典
 */
+ (nonnull id)idFromObject:(nonnull id)object;

@end