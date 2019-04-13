
#import "UIView+XLsn0w.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

NSString const *UIView_badgeKey = @"UIView_badgeKey";

NSString const *UIView_badgeBGColorKey = @"UIView_badgeBGColorKey";
NSString const *UIView_badgeTextColorKey = @"UIView_badgeTextColorKey";
NSString const *UIView_badgeFontKey = @"UIView_badgeFontKey";
NSString const *UIView_badgePaddingKey = @"UIView_badgePaddingKey";
NSString const *UIView_badgeMinSizeKey = @"UIView_badgeMinSizeKey";
NSString const *UIView_badgeOriginXKey = @"UIView_badgeOriginXKey";
NSString const *UIView_badgeOriginYKey = @"UIView_badgeOriginYKey";
NSString const *UIView_shouldHideBadgeAtZeroKey = @"UIView_shouldHideBadgeAtZeroKey";
NSString const *UIView_shouldAnimateBadgeKey = @"UIView_shouldAnimateBadgeKey";
NSString const *UIView_badgeValueKey = @"UIView_badgeValueKey";

@interface UIView ()

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation UIView (XLsn0w)

@dynamic badgeValue, badgeBGColor, badgeTextColor, badgeFont;
@dynamic badgePadding, badgeMinSize, badgeOriginX, badgeOriginY;
@dynamic shouldHideBadgeAtZero, shouldAnimateBadge;


- (void)xlsn0w_addSeparatorWithType:(ViewSeparatorType)type {
    [self xlsn0w_addSeparatorWithType:type color:nil];
}

- (void)xlsn0w_addSeparatorWithType:(ViewSeparatorType)type color:(UIColor *)color {
    switch (type) {
        case ViewSeparatorTypeTop: {
            UIImageView *topLine = [[self class] xlsn0w_instanceHorizontalLine:self.frame.size.width color:color];
            [self addSubview:topLine];
            topLine.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
        }
            break;
        case ViewSeparatorTypeLeft: {
            UIImageView *leftLine = [[self class] xlsn0w_instanceVerticalLine:self.frame.size.height color:color];
            [self addSubview:leftLine];
            leftLine.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleHeight;
        }
            break;
        case ViewSeparatorTypeBottom: {
            UIImageView *bottomLine = [[self class] xlsn0w_instanceHorizontalLine:self.frame.size.width color:color];
            bottomLine.frame = CGRectMake(0.0, self.frame.size.height - SeparatorWidth, bottomLine.frame.size.width, SeparatorWidth);
            [self addSubview:bottomLine];
            bottomLine.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth;
        }
            break;
        case ViewSeparatorTypeRight: {
            UIImageView *rightLine = [[self class] xlsn0w_instanceVerticalLine:self.frame.size.height color:color];
            rightLine.frame = CGRectMake(self.frame.size.width - SeparatorWidth, 0.0, SeparatorWidth, rightLine.frame.size.height);
            [self addSubview:rightLine];
            rightLine.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleHeight;
        }
            break;
        case ViewSeparatorTypeVerticalSide: {
            [self xlsn0w_addSeparatorWithType:ViewSeparatorTypeTop color:color];
            [self xlsn0w_addSeparatorWithType:ViewSeparatorTypeBottom color:color];
        }
            break;
        case ViewSeparatorTypeHorizontalSide: {
            [self xlsn0w_addSeparatorWithType:ViewSeparatorTypeLeft color:color];
            [self xlsn0w_addSeparatorWithType:ViewSeparatorTypeRight color:color];
        }
            break;
        default: {
            [self xlsn0w_addSeparatorWithType:ViewSeparatorTypeHorizontalSide color:color];
            [self xlsn0w_addSeparatorWithType:ViewSeparatorTypeVerticalSide color:color];
        }
            break;
    }
}

- (void)xlsn0w_addALSeparatorWithType:(ViewSeparatorType)type {
    [self xlsn0w_addALSeparatorWithType:type color:nil];
    
}

- (void)xlsn0w_addALSeparatorWithType:(ViewSeparatorType)type color:(UIColor *)color {
    switch (type) {
        case ViewSeparatorTypeTop:{
            UIImageView *topLine = [[self class] xlsn0w_instanceHorizontalLine:self.frame.size.width color:color];
            topLine.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:topLine];
            NSArray *hTopContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[topLine]-0-|"
                                                                              options:0
                                                                              metrics:nil
                                                                                views:NSDictionaryOfVariableBindings(topLine)];
            NSArray *vTopContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[topLine(borderWidth)]"
                                                                              options:0
                                                                              metrics:@{@"borderWidth":@(SeparatorWidth)}
                                                                                views:NSDictionaryOfVariableBindings(topLine)];
            [self addConstraints:hTopContraints];
            [self addConstraints:vTopContraints];
        }
            break;
        case ViewSeparatorTypeLeft: {
            UIImageView *leftLine = [[self class] xlsn0w_instanceVerticalLine:self.frame.size.height color:color];
            leftLine.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:leftLine];
            NSArray *hLeftContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[leftLine(borderWidth)]"
                                                                                 options:0
                                                                                 metrics:@{@"borderWidth":@(SeparatorWidth)}
                                                                                   views:NSDictionaryOfVariableBindings(leftLine)];
            NSArray *vLeftContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[leftLine]-0-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(leftLine)];
            [self addConstraints:hLeftContraints];
            [self addConstraints:vLeftContraints];
        }
            break;
        case ViewSeparatorTypeBottom: {
            UIImageView *bottomLine = [[self class] xlsn0w_instanceHorizontalLine:self.frame.size.width color:color];
            bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:bottomLine];
            NSArray *hBottomContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bottomLine]-0-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(bottomLine)];
            NSArray *vBottomContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottomLine(borderWidth)]-0-|"
                                                                                 options:0
                                                                                 metrics:@{@"borderWidth":@(SeparatorWidth)}
                                                                                   views:NSDictionaryOfVariableBindings(bottomLine)];
            [self addConstraints:hBottomContraints];
            [self addConstraints:vBottomContraints];
        }
            break;
        case ViewSeparatorTypeRight: {
            UIImageView *rightLine = [[self class] xlsn0w_instanceHorizontalLine:self.frame.size.width color:color];
            rightLine.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:rightLine];
            NSArray *hRightContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[rightLine(borderWidth)]-0-|"
                                                                              options:0
                                                                              metrics:@{@"borderWidth":@(SeparatorWidth)}
                                                                                views:NSDictionaryOfVariableBindings(rightLine)];
            NSArray *vRightContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[rightLine]-0-|"
                                                                              options:0
                                                                              metrics:nil
                                                                                views:NSDictionaryOfVariableBindings(rightLine)];
            [self addConstraints:hRightContraints];
            [self addConstraints:vRightContraints];
        }
            break;
        case ViewSeparatorTypeVerticalSide: {
            [self xlsn0w_addALSeparatorWithType:ViewSeparatorTypeTop color:color];
            [self xlsn0w_addALSeparatorWithType:ViewSeparatorTypeBottom color:color];
        }
            break;
        case ViewSeparatorTypeHorizontalSide: {
            [self xlsn0w_addALSeparatorWithType:ViewSeparatorTypeLeft color:color];
            [self xlsn0w_addALSeparatorWithType:ViewSeparatorTypeRight color:color];
        }
            break;
        default: {
            [self xlsn0w_addALSeparatorWithType:ViewSeparatorTypeHorizontalSide color:color];
            [self xlsn0w_addALSeparatorWithType:ViewSeparatorTypeVerticalSide color:color];
        }
    }
}

- (void)xlsn0w_addSeparatorWithType:(ViewSeparatorType)type withColor:(UIColor *)color {
    [self xlsn0w_addSeparatorWithType:type color:color];
}

+ (UIImageView *)xlsn0w_instanceHorizontalLine:(CGFloat)width {
    return [self xlsn0w_instanceHorizontalLine:width color:[UIColor lightGrayColor]];
}


+ (UIImageView *)xlsn0w_instanceVerticalLine:(CGFloat)height {
    return [self xlsn0w_instanceVerticalLine:height color:[UIColor lightGrayColor]];
}

+ (UIImageView *)xlsn0w_instanceHorizontalLine:(CGFloat)width color:(UIColor *)color {
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, width, SeparatorWidth)];
    line.backgroundColor = color?:[UIColor lightGrayColor];
    return line;
}

+ (UIImageView *)xlsn0w_instanceVerticalLine:(CGFloat)height color:(UIColor *)color {
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, SeparatorWidth, height)];
    line.backgroundColor = color?:[UIColor lightGrayColor];
    return line;
}

+ (UIImageView *)xlsn0w_instanceHorizontalLine:(CGFloat)width andColor:(UIColor *)color {
    return [self xlsn0w_instanceHorizontalLine:width color:color];
}

+ (UIImageView *)xlsn0w_instanceVerticalLine:(CGFloat)height andColor:(UIColor *)color {
    return [self xlsn0w_instanceVerticalLine:height color:color];
}

#pragma mark - runtime

- (void)setHud:(MBProgressHUD *)hud {
    objc_setAssociatedObject(self, @selector(hud), hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MBProgressHUD *)hud {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - methods

- (void)xlsn0w_showMessageHUD:(NSString *)message {
    if(!self.hud)
        self.hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    self.hud.mode = MBProgressHUDModeText;
    self.hud.label.text = [message isKindOfClass:[NSString class]]?message:@"";
    [self.hud setOffset:(CGPointMake(0, -50))];
    self.hud.userInteractionEnabled = NO;
    [self.hud showAnimated:YES];
}

- (void)xlsn0w_removeHUD{
    [self.hud hideAnimated:YES];
    self.hud = nil;
}

#pragma mark - static methods

+ (void)xlsn0w_showMessage:(NSString *)message {
    [self xlsn0w_showMessage:message onParentView:nil];
}

+ (void)xlsn0w_showMessage:(NSString *)message onParentView:(UIView *)parentView {
    if (!parentView) {
        UIWindow *topWindows = [[[UIApplication sharedApplication] windows] lastObject];
        parentView = topWindows;
    }
    MBProgressHUD *messageHud = [MBProgressHUD showHUDAddedTo:parentView animated:YES];
    messageHud.mode = MBProgressHUDModeText;
    messageHud.label.text = [message isKindOfClass:[NSString class]] ? message : @"";
    [messageHud setOffset:(CGPointMake(0, -50))];
    messageHud.userInteractionEnabled = NO;
    [messageHud hideAnimated:YES afterDelay:1.5f];
}

+ (void)xlsn0w_showDetailMessage:(NSString *)message {
    [self xlsn0w_showDetailMessage:message onParentView:nil];
}

+ (void)xlsn0w_showDetailMessage:(NSString *)message onParentView:(UIView *)parentView {
    if (!parentView) {
        UIWindow *topWindows = [[[UIApplication sharedApplication] windows] lastObject];
        parentView = topWindows;
    }
    MBProgressHUD *messageHud = [MBProgressHUD showHUDAddedTo:parentView animated:YES];
    messageHud.mode = MBProgressHUDModeText;
    messageHud.label.text = @"提示";
    messageHud.detailsLabel.text = [message isKindOfClass:[NSString class]] ? message : @"";
    [messageHud setOffset:(CGPointMake(0, -50))];
    messageHud.userInteractionEnabled = NO;
    [messageHud hideAnimated:YES afterDelay:1.0f];
}

- (UIImage *)xlsn0w_screenshot {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return screenshot;
}

- (UIImage *)xlsn0w_screenshotWithOffsetY:(CGFloat)deltaY {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //  KEY: need to translate the context down to the current visible portion of the tablview
    CGContextTranslateCTM(ctx, 0, deltaY);
    [self.layer renderInContext:ctx];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return screenshot;
}

- (void)xlsn0w_layerBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius {
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)xlsn0w_addCornerRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)xlsn0w_addBorderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)borderWidth {
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
}

- (void)xlsn0w_addCornerRadius:(CGFloat)radius lineColor:(UIColor *)lineColor {
    self.layer.cornerRadius = radius;
    self.clipsToBounds = YES;
    if(lineColor){
        self.layer.borderColor = lineColor.CGColor;
        self.layer.borderWidth = SeparatorWidth;
    }
}

- (void)xlsn0w_addCornerRadius:(CGFloat)radius andLineColor:(UIColor *)lineColor {
    [self xlsn0w_addCornerRadius:radius lineColor:lineColor];
}

-(BOOL) containsSubView:(UIView *)subView
{
    for (UIView *view in [self subviews]) {
        if ([view isEqual:subView]) {
            return YES;
        }
    }
    return NO;
}

//-(BOOL) containsSubViewOfClassType:(Class)class {
//    for (UIView *view in [self subviews]) {
//        if ([view isMemberOfClass:class]) {
//            return YES;
//        }
//    }
//    return NO;
//}

- (CGPoint)frameOrigin {
    return self.frame.origin;
}

- (void)setFrameOrigin:(CGPoint)newOrigin {
    self.frame = CGRectMake(newOrigin.x, newOrigin.y, self.frame.size.width, self.frame.size.height);
}

- (CGSize)frameSize {
    return self.frame.size;
}

- (void)setFrameSize:(CGSize)newSize {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                            newSize.width, newSize.height);
}

- (CGFloat)frameX {
    return self.frame.origin.x;
}

- (void)setFrameX:(CGFloat)newX {
    self.frame = CGRectMake(newX, self.frame.origin.y,
                            self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameY {
    return self.frame.origin.y;
}

- (void)setFrameY:(CGFloat)newY {
    self.frame = CGRectMake(self.frame.origin.x, newY,
                            self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameRight {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setFrameRight:(CGFloat)newRight {
    self.frame = CGRectMake(newRight - self.frame.size.width, self.frame.origin.y,
                            self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameBottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setFrameBottom:(CGFloat)newBottom {
    self.frame = CGRectMake(self.frame.origin.x, newBottom - self.frame.size.height,
                            self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameWidth {
    return self.frame.size.width;
}

- (void)setFrameWidth:(CGFloat)newWidth {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                            newWidth, self.frame.size.height);
}

- (CGFloat)frameHeight {
    return self.frame.size.height;
}

- (void)setFrameHeight:(CGFloat)newHeight {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                            self.frame.size.width, newHeight);
}

- (void)badgeInit {
    // Default design initialization
    self.badgeBGColor   = [UIColor redColor];
    self.badgeTextColor = [UIColor whiteColor];
    self.badgeFont      = [UIFont systemFontOfSize:12.0];
    self.badgePadding   = 6;
    self.badgeMinSize   = 8;
    self.badgeOriginX   = self.frame.size.width - self.badge.frame.size.width/2;
    self.badgeOriginY   = -4;
    self.shouldHideBadgeAtZero = YES;
    self.shouldAnimateBadge = YES;
    // Avoids badge to be clipped when animating its scale
    self.clipsToBounds = NO;
}

#pragma mark - Utility methods

// Handle badge display when its properties have been changed (color, font, ...)
- (void)refreshBadge
{
    // Change new attributes
    self.badge.textColor        = self.badgeTextColor;
    self.badge.backgroundColor  = self.badgeBGColor;
    self.badge.font             = self.badgeFont;
}

- (CGSize) badgeExpectedSize
{
    // When the value changes the badge could need to get bigger
    // Calculate expected size to fit new value
    // Use an intermediate label to get expected size thanks to sizeToFit
    // We don't call sizeToFit on the true label to avoid bad display
    UILabel *frameLabel = [self duplicateLabel:self.badge];
    [frameLabel sizeToFit];
    
    CGSize expectedLabelSize = frameLabel.frame.size;
    return expectedLabelSize;
}

- (void)updateBadgeFrame
{
    
    CGSize expectedLabelSize = [self badgeExpectedSize];
    
    // Make sure that for small value, the badge will be big enough
    CGFloat minHeight = expectedLabelSize.height;
    
    // Using a const we make sure the badge respect the minimum size
    minHeight = (minHeight < self.badgeMinSize) ? self.badgeMinSize : expectedLabelSize.height;
    CGFloat minWidth = expectedLabelSize.width;
    CGFloat padding = self.badgePadding;
    
    // Using const we make sure the badge doesn't get too smal
    minWidth = (minWidth < minHeight) ? minHeight : expectedLabelSize.width;
    self.badge.frame = CGRectMake(self.badgeOriginX, self.badgeOriginY, minWidth + padding, minHeight + padding);
    self.badge.layer.cornerRadius = (minHeight + padding) / 2;
    self.badge.layer.masksToBounds = YES;
}

// Handle the badge changing value
- (void)updateBadgeValueAnimated:(BOOL)animated
{
    // Bounce animation on badge if value changed and if animation authorized
    if (animated && self.shouldAnimateBadge && ![self.badge.text isEqualToString:self.badgeValue]) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.4f :1.3f :1.f :1.f]];
        [self.badge.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
    
    // Set the new value
    self.badge.text = self.badgeValue;
    
    // Animate the size modification if needed
    NSTimeInterval duration = animated ? 0.2 : 0;
    [UIView animateWithDuration:duration animations:^{
        [self updateBadgeFrame];
    }];
}

- (UILabel *)duplicateLabel:(UILabel *)labelToCopy
{
    UILabel *duplicateLabel = [[UILabel alloc] initWithFrame:labelToCopy.frame];
    duplicateLabel.text = labelToCopy.text;
    duplicateLabel.font = labelToCopy.font;
    
    return duplicateLabel;
}

- (void)removeBadge
{
    // Animate badge removal
    [UIView animateWithDuration:0.2 animations:^{
        self.badge.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.badge removeFromSuperview];
        self.badge = nil;
    }];
}

#pragma mark - getters/setters
-(UILabel*) badge {
    return objc_getAssociatedObject(self, &UIView_badgeKey);
}
-(void)setBadge:(UILabel *)badgeLabel
{
    objc_setAssociatedObject(self, &UIView_badgeKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge value to be display
-(NSString *)badgeValue {
    return objc_getAssociatedObject(self, &UIView_badgeValueKey);
}
-(void) setBadgeValue:(NSString *)badgeValue
{
    objc_setAssociatedObject(self, &UIView_badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // When changing the badge value check if we need to remove the badge
    if (!badgeValue || [badgeValue isEqualToString:@""] || ([badgeValue isEqualToString:@"0"] && self.shouldHideBadgeAtZero)) {
        [self removeBadge];
    } else if (!self.badge) {
        // Create a new badge because not existing
        self.badge                      = [[UILabel alloc] initWithFrame:CGRectMake(self.badgeOriginX, self.badgeOriginY, 20, 20)];
        self.badge.textColor            = self.badgeTextColor;
        self.badge.backgroundColor      = self.badgeBGColor;
        self.badge.font                 = self.badgeFont;
        self.badge.textAlignment        = NSTextAlignmentCenter;
        [self badgeInit];
        [self addSubview:self.badge];
        [self updateBadgeValueAnimated:NO];
    } else {
        [self updateBadgeValueAnimated:YES];
    }
}

// Badge background color
-(UIColor *)badgeBGColor {
    return objc_getAssociatedObject(self, &UIView_badgeBGColorKey);
}
-(void)setBadgeBGColor:(UIColor *)badgeBGColor
{
    objc_setAssociatedObject(self, &UIView_badgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

// Badge text color
-(UIColor *)badgeTextColor {
    return objc_getAssociatedObject(self, &UIView_badgeTextColorKey);
}
-(void)setBadgeTextColor:(UIColor *)badgeTextColor
{
    objc_setAssociatedObject(self, &UIView_badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

// Badge font
-(UIFont *)badgeFont {
    return objc_getAssociatedObject(self, &UIView_badgeFontKey);
}
-(void)setBadgeFont:(UIFont *)badgeFont
{
    objc_setAssociatedObject(self, &UIView_badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

// Padding value for the badge
-(CGFloat) badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, &UIView_badgePaddingKey);
    return number.floatValue;
}
-(void) setBadgePadding:(CGFloat)badgePadding
{
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    objc_setAssociatedObject(self, &UIView_badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

// Minimum size badge to small
-(CGFloat) badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, &UIView_badgeMinSizeKey);
    return number.floatValue;
}
-(void) setBadgeMinSize:(CGFloat)badgeMinSize
{
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    objc_setAssociatedObject(self, &UIView_badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

// Values for offseting the badge over the BarButtonItem you picked
-(CGFloat) badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &UIView_badgeOriginXKey);
    return number.floatValue;
}
-(void) setBadgeOriginX:(CGFloat)badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &UIView_badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

-(CGFloat) badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &UIView_badgeOriginYKey);
    return number.floatValue;
}
-(void) setBadgeOriginY:(CGFloat)badgeOriginY
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &UIView_badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

// In case of numbers, remove the badge when reaching zero
-(BOOL) shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &UIView_shouldHideBadgeAtZeroKey);
    return number.boolValue;
}
- (void)setShouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero
{
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &UIView_shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge has a bounce animation when value changes
-(BOOL) shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &UIView_shouldAnimateBadgeKey);
    return number.boolValue;
}
- (void)setShouldAnimateBadge:(BOOL)shouldAnimateBadge
{
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &UIView_shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame= frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (BOOL)isShowOnKeyWindow {
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

#pragma mark - 添加一个string的tag属性

static void *TagStrKey = &TagStrKey;
- (NSString *)tagStr
{
    return objc_getAssociatedObject(self, TagStrKey);
}

- (void)setTagStr:(NSString *)tagStr
{
    objc_setAssociatedObject(self, TagStrKey, tagStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
