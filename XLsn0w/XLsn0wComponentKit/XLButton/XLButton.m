

#import "XLButton.h"

@interface XLButton ()

@property(nonatomic, strong) UIImageView *overlayImgView;
@property(nonatomic, assign) CGFloat fadeDuration;

@end

@implementation XLButton

- (instancetype _Nonnull)initWithFrame:(CGRect)frame image:(UIImage * _Nonnull)image highlightedImage:(UIImage * _Nonnull)highlightedImage fadeDuration:(CGFloat)fadeDuration {
    if ((self = [XLButton buttonWithType:UIButtonTypeCustom])) {
        self.frame = frame;
        
        self.fadeDuration = fadeDuration;
        
        [self setImage:image forState:UIControlStateNormal];
        self.overlayImgView = [[UIImageView alloc] initWithImage:highlightedImage];
        self.overlayImgView.frame = self.imageView.frame;
        self.overlayImgView.bounds = self.imageView.bounds;
        
        self.adjustsImageWhenHighlighted = NO;
    }
    
    return self;
}


- (void)setHighlighted:(BOOL)highlighted {
    if (![self isHighlighted] && highlighted) {
        [self addSubview:self.overlayImgView];
        
        [UIView animateWithDuration:self.fadeDuration animations:^{
            self.overlayImgView.alpha = 1;
        } completion:NULL];
    } else if ([self isHighlighted] && !highlighted) {
        [UIView animateWithDuration:self.fadeDuration animations:^{
            self.overlayImgView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.overlayImgView removeFromSuperview];
        }];
    }
    
    [super setHighlighted:highlighted];
}

- (void)setOverlayImgView:(UIImageView *)overlayImgView {
    if (overlayImgView != _overlayImgView) {
        _overlayImgView = overlayImgView;
    }
    
    self.overlayImgView.alpha = 0;
}

@end
