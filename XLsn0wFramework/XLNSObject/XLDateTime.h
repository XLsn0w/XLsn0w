
#import <Foundation/Foundation.h>

@interface XLDateTime : NSObject

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;

- (NSDate *)convertDate;

@end

