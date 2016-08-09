
#import <Foundation/Foundation.h>

/**
 *  Exented NSLog
 *
 *  @param file         File
 *  @param lineNumber   Line number
 *  @param functionName Function name
 *  @param format       Format
 */
void ExtendNSLog(const char * _Nonnull file, int lineNumber, const char * _Nonnull function, NSString * _Nonnull format, ...);

/**
 *  This class adds some useful methods to NSLog
 *
 *  BFLog(): Exented NSLog
 *
 *  BFLogString: Log string
 *
 *  BFLogDetailedString: Detailed log string
 *
 *  BFLogClear: Clear the log string
 */

@interface XLog : NSObject

/**
 *  BFLog only if in DEBUG mode
 */
#ifdef DEBUG
/**
 *  Exented NSLog
 */
#define BFLog(args ...) ExtendNSLog(__FILE__, __LINE__, __PRETTY_FUNCTION__, args);
/**
 *  Log string
 */
#define BFLogString [BFLog logString]
/**
 *  Detailed log string
 */
#define BFLogDetailedString [BFLog logDetailedString]
/**
 *  Clear the log string
 */
#define BFLogClear [BFLog clearLog]
#else
#define BFLog(args ...)
#define BFLogString
#define BFLogDetailedString
#define BFLogClear
#endif

/**
 *  Clear the log string.
 *  You can call it with the BFLogClear macro
 */
+ (void)clearLog;

/**
 *  Get the log string.
 *  You can call it with the BFLogString macro
 *
 *  @return Returns the log string
 */
+ (NSString * _Nonnull)logString;

/**
 *  Get the detailed log string.
 *  You can call it with the BFLogDetailedString macro
 *
 *  @return Returns the detailed log string
 */
+ (NSString * _Nonnull)detailedLogString;

/**
 *  Get the detailed log string.
 *  You can call it with the BFLogDetailedString macro
 *
 *  @return Returns the detailed log string
 */
+ (NSString * _Nonnull)logDetailedString DEPRECATED_MSG_ATTRIBUTE("Use -detailedLogString");

@end
