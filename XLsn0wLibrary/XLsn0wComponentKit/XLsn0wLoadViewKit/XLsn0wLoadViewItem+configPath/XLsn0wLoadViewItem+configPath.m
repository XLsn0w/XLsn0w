
#import "XLsn0wLoadViewItem+configPath.h"

static float SQUARE_LEN = 14.0;
static float ANIMATION_DURING_TIME = 2.5;
@implementation XLsn0wLoadViewItem (configPath)

- (void)configKeyFrameAnimationForColorLayerWithStartLoadingStyle:(HIKLoadViewStartLoadingSyle)style
{
    
    CGPoint leftTop     = CGPointMake(0.0, 0.0);
    CGPoint rightTop    = CGPointMake(SQUARE_LEN, 0.0);
    CGPoint rightBottom = CGPointMake(SQUARE_LEN, SQUARE_LEN);
    CGPoint leftBottom  = CGPointMake(0.0, SQUARE_LEN);
    UIBezierPath *path  = [UIBezierPath bezierPath];
    
    switch (style) {
            
        case HIKLoadViewStartFromLeftBottom:
        {
            [path moveToPoint:leftBottom];
            [path addLineToPoint:leftTop];
            [path addLineToPoint:rightTop];
            [path addLineToPoint:rightBottom];
            [path addLineToPoint:leftBottom];
        }
            break;
        case HIKLoadViewStartFromLeftTop:
        {
            [path moveToPoint:leftTop];
            [path addLineToPoint:rightTop];
            [path addLineToPoint:rightBottom];
            [path addLineToPoint:leftBottom];
            [path addLineToPoint:leftTop];
        }
            break;
        case HIKLoadViewStartFromRightBottom:
        {
            [path moveToPoint:rightBottom];
            [path addLineToPoint:leftBottom];
            [path addLineToPoint:leftTop];
            [path addLineToPoint:rightTop];
            [path addLineToPoint:rightBottom];
        }
            break;
        case HIKLoadViewStartFromRightTop:
        {
            [path moveToPoint:rightTop];
            [path addLineToPoint:rightBottom];
            [path addLineToPoint:leftBottom];
            [path addLineToPoint:leftTop];
            [path addLineToPoint:rightTop];
        }
            break;
        default:
            break;
    }
//    self.colorCirculeLayer.anchorPoint = CGPointZero;
    self.colorCirculeLayer.position = CGPointZero;
    self.colorCirculeLayer.opacity = 1.0;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration             = ANIMATION_DURING_TIME;
    animation.path                 = path.CGPath;
    animation.calculationMode      = kCAAnimationPaced;
    animation.repeatCount          = HUGE_VALF;
    animation.additive             = YES;
    animation.fillMode             = kCAFillModeForwards;
    animation.removedOnCompletion  = NO;
    [self.colorCirculeLayer addAnimation:animation forKey:@"position"];
}

- (void)stayOnPresentationLayerPosition
{
    CALayer *presentationLayer = [self.colorCirculeLayer presentationLayer];
    [[self.colorCirculeLayer modelLayer] setPosition:presentationLayer.position];
}
@end
