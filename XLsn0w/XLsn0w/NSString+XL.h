
#import <Foundation/Foundation.h>

@interface NSString (XL)

+ (NSString *)xl_MD5LockString:(NSString *)string;

+ (NSString *)xl_MD5StrongLockString:(NSString *)string;

@end

@interface NSString (XLDate)

/**
 *  Get date info string from a date type object
 *
 *  @param date date type object
 *
 *  @return a date info string
 */
+ (NSString *)xl_formatInfoFromDate:(NSDate *)date;

/**
 *  Get sns date info string form date type object
 *
 *  @param date date type object
 *
 *  @return a date info string of sns
 */
+ (NSString *)xl_formatDateFromDate:(NSDate *)date;

@end

@interface NSString (XLPredicate)

/**
 *  check the string is email
 *
 *  @param input input string
 *
 *  @return true/false value
 */
+ (BOOL)xl_checkEmail:(NSString *)input;

/**
 *  check the string is phone Number
 *
 *  @param input input string
 *
 *  @return true/false value
 */
+ (BOOL)xl_checkPhoneNumber:(NSString *)input;

/**
 *  check the string is chinese name
 *
 *  @param input input string
 *
 *  @return true/false value
 */
+ (BOOL)xl_checkChineseName:(NSString *)input;

/**
 *  check the string is valudate code
 *
 *  @param input input string
 *
 *  @return true/false value
 */
+ (BOOL)xl_checkValidateCode:(NSString *)input;

/**
 *  check the string is strong password string
 *
 *  @param input input string
 *
 *  @return true/false value
 */
+ (BOOL)xl_checkPassword:(NSString *)input;


/**
 *  check the string is mobile number
 *
 *  @param input input string
 *
 *  @return true/false value
 */
+ (BOOL)xl_checkMobileNumber:(NSString *)input;

/**
 *  check the string is validate money
 *
 *  @param input input string
 *
 *  @return true/false value
 */
+ (BOOL)xl_checkWithDrawMoney:(NSString *)input;

@end

@interface NSString (XLMD5)

/**
 *  Get a md5 string - encrypt method
 *
 *  @return The md5 encrypt string
 */
- (NSString *)xl_md5;

@end

@interface NSString (XLSubString)

/**
 *  Get substring from origin string with condition
 *
 *  @param bKey The begin key
 *  @param eKey The end key
 *
 *  @return The result string
 */
- (NSString *)xl_getSubStringBeginKey:(NSString *)bKey endKey:(NSString *)eKey;

@end

@interface NSString (XLPrice)

+ (NSString *)xl_formatPrice:(NSNumber *)price;

@end

