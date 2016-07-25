
#import <UIKit/UIKit.h>

@interface UploadImageCell : UITableViewCell

//cell中放置collectionView
@property (nonatomic, retain) UICollectionView *collectionView;

//collectionView约束
@property (nonatomic, retain) UICollectionViewFlowLayout *collectionViewFlowLayout;

@end
