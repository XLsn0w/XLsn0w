
#import "DisplayImageCell.h"
#import <Photos/Photos.h>

@implementation DisplayImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [[UIColor blackColor] CGColor];
        self.layer.borderWidth = 1;
        [self.contentView addSubview:self.picImageV];
        [self.contentView addSubview:self.choosePic];
        
    }
    return self;
}

- (UIImageView *)picImageV {
    if (!_picImageV) {
        self.picImageV = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _picImageV;
}
- (UIImageView *)choosePic {
    if (!_choosePic) {
        self.choosePic = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 40, self.bounds.size.height - 40, 30, 30)];
    }
    return _choosePic;
}

/////此方法为存入沙盒后在提取展示,暂时没用
//- (void)cellDisplayWith:(NSString *)image {
//    NSString *picPath = [[self getCachePath] stringByAppendingPathComponent:image];
//    UIImage *image1 = [UIImage imageWithContentsOfFile:picPath];
//    [self.picImageV setImage:image1];
//}

///所有相片展示的方法 将照片直接展示
- (void)displayCellWith :(NSString *)image {
    __block DisplayImageCell *blockSelf = self;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize targetSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) * scale, CGRectGetHeight([UIScreen mainScreen].bounds) * scale);
    PHImageRequestOptions *operation = [[PHImageRequestOptions alloc] init];
    ///必要时从iCloud下载
    //   operation.networkAccessAllowed = YES;
    ///return only a single result, blocking until available (or failure). Defaults to NO
    operation.synchronous = YES;
    operation.resizeMode = PHImageRequestOptionsResizeModeFast;

    
    /// 尝试将图片写入缓存,看看拖动UICollectionView时的卡顿现象有无缓解
    PHCachingImageManager *manager = [[PHCachingImageManager alloc] init];
    NSMutableArray<PHAsset *> *assets = [NSMutableArray array];
    [manager startCachingImagesForAssets:assets targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:nil];
    PHFetchResult *saveAsset = [PHAsset fetchAssetsWithLocalIdentifiers:@[image] options:nil];
    [saveAsset enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[PHAsset class]]) {
            [assets addObject:obj];
        }
        [manager requestImageForAsset:obj targetSize:targetSize contentMode:PHImageContentModeDefault options:operation resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            [blockSelf.picImageV setImage:result];
        }];
    }];
}
///展示选取照片的方法
- (void)displayCellWithChoosedPics:(id)imagePath {
        __block DisplayImageCell *blockSelf = self;
    if ([imagePath isKindOfClass:[UIImage class]]) {
        [self.picImageV setImage:[UIImage imageNamed:@"plus"]];
        [self.choosePic setImage:[UIImage imageNamed:@""]];
    }else {
        CGFloat scale = [UIScreen mainScreen].scale;
        CGSize targetSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) * scale, CGRectGetHeight([UIScreen mainScreen].bounds) * scale);
        PHImageRequestOptions *operation = [[PHImageRequestOptions alloc] init];
        ///必要时从iCloud下载
        //   operation.networkAccessAllowed = YES;
        ///return only a single result, blocking until available (or failure). Defaults to NO
        operation.synchronous = YES;
        operation.resizeMode = PHImageRequestOptionsResizeModeFast;
        PHFetchResult *saveAsset = [PHAsset fetchAssetsWithLocalIdentifiers:@[imagePath] options:nil];
        [saveAsset enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [[PHImageManager defaultManager] requestImageForAsset:obj targetSize:targetSize contentMode:PHImageContentModeDefault options:operation resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                [blockSelf.picImageV setImage:result];
            }];
        }];
        [self.choosePic setImage:[UIImage imageNamed:@"minus"]];
    }
   
}

/*****************************************************/

- (void)setCellImage:(UIImage *)indexPathImage {
    [self.picImageV setImage:indexPathImage];
    /*****************************************************/
    [self.choosePic setImage:[UIImage imageNamed:@"minus"]];//显示减号图片
    UITapGestureRecognizer *minusTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(minusTapGestureAction:)];//创建手势 添加事件
    [self.choosePic addGestureRecognizer:minusTapGesture];//把手势添加到减号图片上面
    self.choosePic.userInteractionEnabled = YES;//开启减号图片用户交互
}

- (void)setNoMinusCellImage:(UIImage *)indexPathImage {
    [self.picImageV setImage:indexPathImage];
    /*****************************************************/
    [self.choosePic setImage:[UIImage imageNamed:@""]];//一定要执行setImage方法 设置为空
    self.choosePic.userInteractionEnabled = NO;
}

- (void)minusTapGestureAction:(UITapGestureRecognizer *)minusTapGesture {
    UIImageView *minusImageView = (UIImageView *)minusTapGesture.view;
    DisplayImageCell *displayImageCell = (DisplayImageCell *)[minusImageView.superview superview];
    [self.xlDelegate deleteDisplayImageCell:displayImageCell];
}

/*****************************************************/

- (void)dealloc{
    self.choosePic = nil;
    self.picImageV = nil;
}

//- (NSString *)getCachePath {
//    ///沙盒路径
//    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
//    NSString *filePath = [cachePath stringByAppendingPathComponent:@"pics"];
//    return filePath;
//}

@end
