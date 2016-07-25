
#import <UIKit/UIKit.h>

@interface DisplayImageCell : UICollectionViewCell

//展示相册图片用
@property (nonatomic ,retain) UIImageView *picImageV;

///选中显示对号
@property (nonatomic, retain) UIImageView *choosePic;

/////将照片存到沙盒后展示
//- (void)cellDisplayWith:(NSString *)image;

///将照片直接展示
- (void)displayCellWith :(NSString *)image;

///右下角显示小叉号
- (void)displayCellWithChoosedPics :(id)imagePath;

@end

