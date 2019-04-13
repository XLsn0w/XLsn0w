
#import <UIKit/UIKit.h>

@interface UILabel (XLsn0w)

/**
 *  Calculate the text height with the systemFontSize & constrain width
 *
 *  @param text     The Calculate text
 *  @param fontSize The System font size
 *  @param width    The constraint
 *
 *  @return The calculated height
 */
+ (CGFloat)xlsn0w_heightOfText:(NSString *)text
                  fontSize:(CGFloat)fontSize
           constraintWidth:(CGFloat)width;

/**
 *  Calculate the text height with the systemFontSize & constrain width then return a minimum height
 *
 *  @param text     The calculate text
 *  @param fontSize The system font size
 *  @param width    The constraint
 *  @param height   The minimum height
 *
 *  @return The calculated height with the minimum height
 */
+ (CGFloat)xlsn0w_heightOfText:(NSString *)text
                  fontSize:(CGFloat)fontSize
           constraintWidth:(CGFloat)width
             minimumHeight:(CGFloat)height;

/**
 *  Calculate the text height with the font & constrain width then return a minimum height
 *
 *  @param text     The calculate text
 *  @param font     The font
 *  @param width    The constraint
 *  @param height   The minimum height
 *
 *  @return The calculated height with the minimum height
 */
+ (CGFloat)xlsn0w_heightOfText:(NSString *)text
                      font:(UIFont *)font
           constraintWidth:(CGFloat)width
             minimumHeight:(CGFloat)height;

/**
 *  文本是一行就能显示
 */
@property (nonatomic,assign,setter=setSingleLine:)BOOL isSingleLine;

@property (nonatomic,assign)CGSize lbTextSize;  //属性不可以是textSize


/**
 *  设置文本多行可控间距显示
 *
 *  @param text        文本
 *  @param lines       行数，lines = 0不限制行数,文本显示不足lines，正常显示。超过lines,结尾部分的内容以……方式省略
 *  @param lineSpacing 行间距
 *  @param cSize       文本显示的最大区域
 *
 *  @return 文本占用的size
 */


- (CGSize)setText:(NSString *)text lines:(NSInteger)lines andLineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)cSize;


/**
 *  计算文本占用的size
 *
 *  @param text        文本
 *  @param lines       行数，lines = 0不限制行数
 *  @param font        字体类型
 *  @param lineSpacing 行间距
 *  @param cSize       文本显示的最大区域
 *
 *  @return 文本占用的size
 */
+ (CGSize)sizeWithText:(NSString *)text lines:(NSInteger)lines font:(UIFont*)font andLineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)cSize;

@end

@interface UILabel (XLAutoSize)

/**
 * 垂直方向固定获取动态宽度的UILabel的方法
 *
 * @return 原始UILabel修改过的Rect的UILabel(起始位置相同)
 */
- (UILabel *)xlsn0w_resizeLabelHorizontal;

/**
 *  水平方向固定获取动态宽度的UILabel的方法
 *
 *  @return 原始UILabel修改过的Rect的UILabel(起始位置相同)
 */
- (UILabel *)xlsn0w_resizeLabelVertical;

/**
 *  垂直方向固定获取动态宽度的UILabel的方法
 *
 *  @param minimumWidth minimum width
 *
 *  @return 原始UILabel修改过的Rect的UILabel(起始位置相同)
 */
- (UILabel *)xlsn0w_resizeLabelHorizontal:(CGFloat)minimumWidth;

/**
 *  水平方向固定获取动态宽度的UILabel的方法
 *
 *  @param minimumHeigh minimum height
 *
 *  @return 原始UILabel修改过的Rect的UILabel(起始位置相同)
 */
- (UILabel *)xlsn0w_resizeLabelVertical:(CGFloat)minimumHeigh;

@end
