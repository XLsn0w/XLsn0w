

@import Foundation;

/**
 *  This category adds some useful methods to NSMutableDictionary
 */
@interface NSMutableDictionary (BFKit)

/**
*  Set the object for a given key in safe mode (if not nil)
*
*  @param anObject The object
*  @param aKey     The key
*
*  @return Returns YES if has been setted, otherwise NO
*/
- (BOOL)safeSetObject:(id _Nonnull)anObject
               forKey:(id<NSCopying> _Nonnull)aKey;

@end
