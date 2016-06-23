
#import "XLCollectionViewCell.h"

@implementation XLCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _avatarImageView = [UIImageView new];
        [self addSubview:_avatarImageView];
//        [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(20);
//            make.left.mas_equalTo(25);
//            make.right.mas_equalTo(-25);
//            make.height.mas_equalTo(30);
//        }];
        
        _titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
//        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(60);
//            make.left.mas_equalTo(25);
//            make.right.mas_equalTo(-25);
//            make.height.mas_equalTo(30);
//        }];
    }
    return self;
}

- (void)addValueWithImageUrl:(NSString *)imageUrl title:(NSString *)title {
    _avatarImageView.image = [UIImage imageNamed:imageUrl];
    _titleLabel.text = title;
}

@end
