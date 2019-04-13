
#import "UILabel+XLsn0w.h"
#import <objc/runtime.h>

@implementation UILabel (XLsn0w)

+ (CGFloat)xlsn0w_heightOfText:(NSString *)text fontSize:(CGFloat)fontSize constraintWidth:(CGFloat)width {
    return [self xlsn0w_heightOfText:text fontSize:fontSize constraintWidth:width minimumHeight:0];
}

+ (CGFloat)xlsn0w_heightOfText:(NSString *)text fontSize:(CGFloat)fontSize constraintWidth:(CGFloat)width minimumHeight:(CGFloat)height {
    UIFont *systemFont = [UIFont systemFontOfSize:fontSize];
    return [self xlsn0w_heightOfText:text font:systemFont constraintWidth:width minimumHeight:height];
}

+ (CGFloat)xlsn0w_heightOfText:(NSString *)text font:(UIFont *)font constraintWidth:(CGFloat)width minimumHeight:(CGFloat)height {
    CGFloat finalHeight = 0.0f;
    CGSize constrainedSize = CGSizeMake(width, CGFLOAT_MAX);
    CGSize size = CGSizeZero;
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        size = [text boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    } else {
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED <= 60000)
        size = [text sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:NSLineBreakByWordWrapping];
#endif
    }
    finalHeight = ceilf(size.height);
    
    // check if setup minimum height and final is lower than the minimum height
    if (height > 0 && finalHeight < height) {
        finalHeight = height;
    }
    return finalHeight;
}

- (BOOL)isSingleLine{
    
    return [objc_getAssociatedObject(self, @selector(isSingleLine)) boolValue];
}

- (void)setSingleLine:(BOOL)isSingleLine{
    
    objc_setAssociatedObject(self, @selector(isSingleLine), [NSNumber numberWithBool:isSingleLine], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setLbTextSize:(CGSize)lbTextSize{
    
    objc_setAssociatedObject(self, @selector(lbTextSize), [NSValue valueWithCGSize:lbTextSize], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)lbTextSize{
    
    return [objc_getAssociatedObject(self, @selector(lbTextSize)) CGSizeValue];
}

- (CGSize)setText:(NSString *)text lines:(NSInteger)lines andLineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)cSize{
    
    self.numberOfLines = lines;  //限定行数
    if (!text && text.length !=0) {
        return CGSizeZero;
    }
    
    self.lbTextSize = [self p_calculateSizeWithText:text lines:lines font:self.font andLineSpacing:lines constrainedToSize:cSize];
    
    if ([self p_isSingleLine:self.lbTextSize.height font:self.font]) {
        lineSpacing = 0.0f;
        [self setSingleLine:YES];
    }else{
        [self setSingleLine:NO];
    }
    
    //设置文字的属性
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;//结尾部分的内容以……方式省略
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    [self setAttributedText:attributedString];
    self.bounds = CGRectMake(0, 0, self.lbTextSize.width, self.lbTextSize.height);
    [self p_adjustLabelContent];
    NSLog(@"self.frame.size = %@",NSStringFromCGSize(self.frame.size));
    return self.frame.size;
}

+ (CGSize)sizeWithText:(NSString *)text lines:(NSInteger)lines font:(UIFont*)font andLineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)cSize{
    
    UILabel *label = [[UILabel alloc]init];
    label.font = font;
    [label setText:text lines:lines andLineSpacing:lineSpacing constrainedToSize:cSize];
    return label.frame.size;
}

#pragma mark - private methods
//单行的判断
- (BOOL)p_isSingleLine:(CGFloat)height font:(UIFont*)font{
    
    BOOL isSingle = NO;
    CGFloat oneRowHeight = [@"占位" sizeWithAttributes:@{NSFontAttributeName:font}].height;
    if (fabs(height - oneRowHeight)  < 0.001f) {
        isSingle = YES;
    }
    return isSingle;
}

//真正计算文本占用的size
- (CGSize)p_calculateSizeWithText:(NSString *)text lines:(NSInteger)lines font:(UIFont*)font andLineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)cSize{
    
    if (!text && text.length !=0) {
        return CGSizeZero;
    }
    NSString *firstWord = [text substringToIndex:1];
    
    CGFloat oneRowHeight = [firstWord sizeWithAttributes:@{NSFontAttributeName:font}].height;
    CGSize textSize = [text boundingRectWithSize:cSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
    CGFloat rows = textSize.height / oneRowHeight;
    CGFloat realHeight = oneRowHeight;
    // 0 不限制行数
    if (lines == 0) {
        if (rows >= 1) {
            realHeight = (rows * oneRowHeight) + (rows - 1) * lineSpacing;
        }
    }else{
        if (rows >= lines) {
            rows = lines;
        }
        realHeight = (rows * oneRowHeight) + (rows - 1) * lineSpacing;
    }
    
    return CGSizeMake(textSize.width, realHeight);
}

- (void)p_adjustLabelContent{
    
    if (self.isSingleLine) {
        [self sizeThatFits:self.lbTextSize];//固定原始label的大小，避免文本太多，单行显示时超出label size
    }else{
        [self sizeToFit]; //调整label的宽和高，使它根据字符串的大小做合适的改变,避免多行显示时文本不从顶部往下排版
    }
    NSLog(@"testSize = %@, size = %@",NSStringFromCGSize(self.lbTextSize),NSStringFromCGSize(self.frame.size));
}

@end

@implementation UILabel (XLAutoSize)

- (UILabel *)xlsn0w_resizeLabelHorizontal {
    return [self xlsn0w_resizeLabelHorizontal:0];
}

- (UILabel *)xlsn0w_resizeLabelVertical {
   return [self xlsn0w_resizeLabelVertical:0];
}

- (UILabel *)xlsn0w_resizeLabelVertical:(CGFloat)minimumHeigh {
    CGRect newFrame = self.frame;
    CGSize constrainedSize = CGSizeMake(newFrame.size.width, CGFLOAT_MAX);
    NSString *text = self.text;
    UIFont *font = self.font;
    CGSize size = CGSizeZero;
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        size = [text boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }else{
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED <= 60000)
        size = [text sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:NSLineBreakByWordWrapping];
#endif
    }
    newFrame.size.height = ceilf(size.height);
    if (minimumHeigh > 0) {
        newFrame.size.height = (newFrame.size.height < minimumHeigh ? minimumHeigh : newFrame.size.height);
    }
    self.frame = newFrame;
    return self;
}

- (UILabel *)xlsn0w_resizeLabelHorizontal:(CGFloat)minimumWidth {
    CGRect newFrame = self.frame;
    CGSize constrainedSize = CGSizeMake(CGFLOAT_MAX, newFrame.size.height);
    NSString *text = self.text;
    UIFont *font = self.font;
    CGSize size = CGSizeZero;
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        size = [text boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }else{
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED <= 60000)
        size = [text sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:NSLineBreakByWordWrapping];
#endif
    }
    newFrame.size.width = ceilf(size.width);
    if (minimumWidth > 0) {
        newFrame.size.width = (newFrame.size.width < minimumWidth ? minimumWidth: newFrame.size.width);
    }
    self.frame = newFrame;
    return self;
}

@end
