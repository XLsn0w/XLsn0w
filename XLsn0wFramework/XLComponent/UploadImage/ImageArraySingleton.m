
#import "ImageArraySingleton.h"

@implementation ImageArraySingleton

+ (ImageArraySingleton *)shareSingleTon {
    static ImageArraySingleton *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[ImageArraySingleton alloc] init];
    });
    return singleton;
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        self.imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

@end
