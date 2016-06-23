
#import <UIKit/UIKit.h>

@interface XLCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *titleLabel;

- (void)addValueWithImageUrl:(NSString *)imageUrl title:(NSString *)title;

@end
