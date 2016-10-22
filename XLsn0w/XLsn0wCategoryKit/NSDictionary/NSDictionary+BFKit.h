

@import Foundation;

/**
 *  This category adds some useful methods to NSDictionary
 */
@interface NSDictionary (BFKit)

/**
 *  Convert self to JSON as NSString
 *
 *  @return Returns the JSON as NSString or nil if error while parsing
 */
- (NSString * _Nonnull)dictionaryToJson DEPRECATED_MSG_ATTRIBUTE("Use -dictionaryToJSON");

/**
 *  Convert self to JSON as NSString
 *
 *  @return Returns the JSON as NSString or nil if error while parsing
 */
- (NSString * _Nonnull)dictionaryToJSON;

/**
 *  Convert the given dictionary to JSON as NSString
 *
 *  @param dictionary The dictionary to be converted
 *
 *  @return Returns the JSON as NSString or nil if error while parsing
 */
+ (NSString * _Nonnull)dictionaryToJson:(NSDictionary * _Nonnull)dictionary DEPRECATED_MSG_ATTRIBUTE("Use +dictionaryToJSON:");

/**
 *  Convert the given dictionary to JSON as NSString
 *
 *  @param dictionary The dictionary to be converted
 *
 *  @return Returns the JSON as NSString or nil if error while parsing
 */
+ (NSString * _Nonnull)dictionaryToJSON:(NSDictionary * _Nonnull)dictionary;

/**
 *  Returns an object if key exists or nil if not
 *
 *  @param key Key to get value of
 *
 *  @return Value for the key Or nil
 */
- (id _Nullable)safeObjectForKey:(NSString * _Nonnull)key;


@end
