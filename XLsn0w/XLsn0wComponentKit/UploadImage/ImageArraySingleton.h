
#import <Foundation/Foundation.h>

@interface ImageArraySingleton : NSObject

+ (ImageArraySingleton *)shareSingleTon;

@property (nonatomic, strong) NSMutableArray *imageArray;

@end
