/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/

@import Foundation;

/**
 *  Exented NSLog
 *
 *  @param file         File
 *  @param lineNumber   Line number
 *  @param function     Function name
 *  @param format       Format
 */
void ExtendNSLog(const char * _Nonnull file, int lineNumber, const char * _Nonnull function, NSString * _Nonnull format, ...);

/**
 *  This class adds some useful methods to NSLog
 *
 *  XLsn0wLog(): Exented NSLog
 *
 *  XLsn0wLogString: Log string
 *
 *  XLsn0wLogDetailedString: Detailed log string
 *
 *  XLsn0wLogClear: Clear the log string
 */
@interface XLsn0wLog : NSObject

/**
 *  XLsn0wLog only if in DEBUG mode
 */
#ifdef DEBUG
    /**
     *  Exented NSLog
     */
    #define XLsn0wLog(args ...) ExtendNSLog(__FILE__, __LINE__, __PRETTY_FUNCTION__, args);
    /**
     *  Log string
     */
    #define XLsn0wLogString [XLsn0wLog logString]
    /**
     *  Detailed log string
     */
    #define XLsn0wLogDetailedString [XLsn0wLog logDetailedString]
    /**
     *  Clear the log string
     */
    #define XLsn0wLogClear [XLsn0wLog clearLog]
#else
    #define XLsn0wLog(args ...)
    #define XLsn0wLogString
    #define XLsn0wLogDetailedString
    #define XLsn0wLogClear
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
