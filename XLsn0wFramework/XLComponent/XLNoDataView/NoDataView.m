
#import "NoDataView.h"
#import "UIView+XLsn0w.h"
#import <Masonry.h>

@implementation NoDataView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self drawUI];
    }
    return self;
}

- (void)drawUI {
    _noDataLabel = [[UILabel alloc] init];
    [self addSubview:_noDataLabel];
    [_noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    _noDataLabel.textAlignment = NSTextAlignmentCenter;
    
    _noDataImageView = [[UIImageView alloc] init];
    [self addSubview:_noDataImageView];
    [_noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_noDataLabel).mas_offset(-50);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    [_noDataImageView setImage:[UIImage imageNamed:@"noDataImageView"]];
    _noDataImageView.layer.borderWidth = 1;
    _noDataImageView.layer.borderColor = [[UIColor blackColor] CGColor];
    [_noDataImageView xlsn0w_addCornerRadius:50];
    
}

@end
