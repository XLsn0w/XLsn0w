
#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface XLDBModelManager : NSObject

@property (nonatomic, retain, readonly) FMDatabaseQueue *dbQueue;

+ (XLDBModelManager *)sharedInstance;

+ (NSString *)dbPath;

- (BOOL)changeDBWithDirectoryName:(NSString *)directoryName;

@end
