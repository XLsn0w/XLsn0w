
#import "XLCalendarComponent.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#pragma mark - CalendarHeader

@implementation CalendarHeader

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (CAGradientLayer *)gradientLayer {
    return (CAGradientLayer *)self.layer;
}

- (void)setColors:(NSArray *)colors {
    NSMutableArray *cgColors = [NSMutableArray array];
    for (UIColor *color in colors) {
        [cgColors addObject:(__bridge id)color.CGColor];
    }
    self.gradientLayer.colors = cgColors;
}

@end

#pragma mark - DateButton

@implementation DateButton

- (void)setDate:(NSDate *)date {
    _buttonDate = date;
    if (date) {
        NSDateComponents *comps = [_buttonCalendar components:NSCalendarUnitDay | NSCalendarUnitMonth fromDate:date];
        [self setTitle:[NSString stringWithFormat:@"%ld", (long)comps.day] forState:UIControlStateNormal];
    } else {
        [self setTitle:@"" forState:UIControlStateNormal];
    }
}

@end

#pragma mark - DateCell

@implementation DateCell

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xF2F2F2);
        self.textColor = UIColorFromRGB(0x393B40);
        
        self.selectedBackgroundColor = UIColorFromRGB(0x88B6DB);
        self.selectedTextColor = UIColorFromRGB(0xF2F2F2);
    }
    return self;
}

@end

#pragma mark - XLSignCalendar

@interface XLCalendarComponent ()

@property(nonatomic, strong) UIView *highlight;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIButton *lastButton;
@property(nonatomic, strong) UIButton *nextButton;
@property(nonatomic, strong) UIView *calendarContainer;
@property(nonatomic, strong) CalendarHeader *daysHeader;
@property(nonatomic, strong) NSArray *dayOfWeekLabels;
@property(nonatomic, strong) NSMutableArray *dateButtons;

//时间格式
@property(nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) NSDate *monthShowing;


@property (nonatomic, strong) NSDate *selectedDate;


@property (nonatomic, strong) NSCalendar *calendar;

@property(nonatomic, assign) CGFloat cellWidth;

@property (nonatomic, strong) DateButton *dateButton;

@end

@implementation XLCalendarComponent

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self drawSignCalendarUI];
    }
    return self;
}

- (void)drawSignCalendarUI {
    self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [self.calendar setLocale:[NSLocale currentLocale]];
    
    self.cellWidth = 44;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    self.dateFormatter.dateFormat = @"yyyy年 MM月";
    

    self.onlyShowCurrentMonth = YES;
    self.adaptHeightToNumberOfWeeksInMonth = YES;
    
    self.layer.cornerRadius = 6.0;
    
    UIView *highlight = [[UIView alloc] initWithFrame:CGRectZero];
    highlight.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    highlight.layer.cornerRadius = 6.0f;
    [self addSubview:highlight];
    self.highlight = highlight;
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    _lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_lastButton setImage:[UIImage imageNamed:@"lastButton"] forState:UIControlStateNormal];
    _lastButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    [_lastButton addTarget:self action:@selector(_moveCalendarToPreviousMonth) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_lastButton];
    
    
    _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextButton setImage:[UIImage imageNamed:@"nextButton"] forState:UIControlStateNormal];
    _nextButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
    [_nextButton addTarget:self action:@selector(_moveCalendarToNextMonth) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nextButton];

    
    [self addSwipeGestureRecognizer];
    
    /***************************************************************************/
    
    
    UIView *calendarContainer = [[UIView alloc] initWithFrame:CGRectZero];
    calendarContainer.layer.borderWidth = 1.0f;
    calendarContainer.layer.borderColor = [UIColor blackColor].CGColor;
    calendarContainer.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    calendarContainer.layer.cornerRadius = 4.0f;
    calendarContainer.clipsToBounds = YES;
    [self addSubview:calendarContainer];
    self.calendarContainer = calendarContainer;
    
    CalendarHeader *daysHeader = [[CalendarHeader alloc] initWithFrame:CGRectZero];
    daysHeader.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    [self.calendarContainer addSubview:daysHeader];
    self.daysHeader = daysHeader;
    
    NSMutableArray *labels = [NSMutableArray array];
    for (int i = 0; i < 7; ++i) {
        UILabel *dayOfWeekLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        dayOfWeekLabel.textAlignment = NSTextAlignmentCenter;
        dayOfWeekLabel.backgroundColor = [UIColor clearColor];
        dayOfWeekLabel.shadowColor = [UIColor whiteColor];
        dayOfWeekLabel.shadowOffset = CGSizeMake(0, 1);
        [labels addObject:dayOfWeekLabel];
        [self.calendarContainer addSubview:dayOfWeekLabel];
    }
    self.dayOfWeekLabels = labels;
    [self _updateDayOfWeekLabels];
    
    /*************************************************************************************/
    
    //显示日期的DateButton
    NSMutableArray *dateButtonArray = [NSMutableArray array];
    for (NSInteger i = 1; i <= 42; i++) {
        DateButton *dateButton = [DateButton buttonWithType:UIButtonTypeCustom];
        dateButton.buttonCalendar = self.calendar;
        [dateButton addTarget:self action:@selector(clickDateButton:) forControlEvents:UIControlEventTouchUpInside];
        [dateButtonArray addObject:dateButton];
    }
    self.dateButtons = dateButtonArray;
    
    // initialize the thing
    self.monthShowing = [NSDate date];
    [self _setDefaultStyle];
    
    [self layoutSubviews];
}

#pragma mark - 点击日期
- (void)clickDateButton:(DateButton *)dateButton {
    
    _selectedDate = dateButton.buttonDate;
    
    [self.xlDelegate calendarComponent:self didSelectDate:dateButton.buttonDate];
    [self setNeedsLayout];
}


#pragma mark - Override layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat containerWidth = self.bounds.size.width - (5 * 2);
    self.cellWidth = (floorf(containerWidth / 7.0)) - 1;
    
    NSInteger numberOfWeeksToShow = 6;
    if (self.adaptHeightToNumberOfWeeksInMonth) {
        numberOfWeeksToShow = [self _numberOfWeeksInMonthContainingDate:self.monthShowing];
    }
    CGFloat containerHeight = (numberOfWeeksToShow * (self.cellWidth + 1) + 22);
    
    CGRect newFrame = self.frame;
    newFrame.size.height = containerHeight + 5 + 44;
    self.frame = newFrame;
    
    self.highlight.frame = CGRectMake(1, 1, self.bounds.size.width - 2, 1);
    
    self.titleLabel.text = [self.dateFormatter stringFromDate:_monthShowing];
    self.titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, 44);
    self.lastButton.frame = CGRectMake(2, 2, 48, 38);
    self.nextButton.frame = CGRectMake(self.bounds.size.width - 48 - 2, 2, 48, 38);
    
    self.calendarContainer.frame = CGRectMake(5, CGRectGetMaxY(self.titleLabel.frame), containerWidth, containerHeight);
    self.daysHeader.frame = CGRectMake(0, 0, self.calendarContainer.frame.size.width, 22);
    
    CGRect lastDayFrame = CGRectZero;
    for (UILabel *dayLabel in self.dayOfWeekLabels) {
        dayLabel.frame = CGRectMake(CGRectGetMaxX(lastDayFrame) + 1, lastDayFrame.origin.y, self.cellWidth, self.daysHeader.frame.size.height);
        lastDayFrame = dayLabel.frame;
    }
    
    for (DateButton *dateButton in self.dateButtons) {
        dateButton.date = nil;
        [dateButton removeFromSuperview];
    }
    
    NSDate *date = [self _firstDayOfMonthContainingDate:self.monthShowing];
    if (!self.onlyShowCurrentMonth) {
        while ([self _placeInWeekForDate:date] != 0) {
            date = [self _previousDay:date];
        }
    }
    
    NSDate *endDate = [self _firstDayOfNextMonthContainingDate:self.monthShowing];
    if (!self.onlyShowCurrentMonth) {
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        //[comps setWeek:numberOfWeeksToShow];
        [comps setWeekOfMonth:numberOfWeeksToShow];
        endDate = [self.calendar dateByAddingComponents:comps toDate:date options:0];
    }
    
    NSUInteger index = 0;
    
    while ([date laterDate:endDate] != date) {
        
        _dateButton = [_dateButtons objectAtIndex:index];
        
        _dateButton.date = date;
        
        DateCell *dateCell = [[DateCell alloc] init];
        
        if ([self _dateIsToday:_dateButton.buttonDate]) {
            dateCell.textColor = [UIColor whiteColor];
            dateCell.backgroundColor = [UIColor redColor];
            
            
            
        } else if (!self.onlyShowCurrentMonth && [self _compareByMonth:date toDate:self.monthShowing] != NSOrderedSame) {
            dateCell.textColor = [UIColor lightGrayColor];
        }
        
        if (self.xlDelegate && [self.xlDelegate respondsToSelector:@selector(calendarComponent:configureDateCell:forDate:)]) {
            [self.xlDelegate calendarComponent:self configureDateCell:dateCell forDate:date];
        }
        
     
        
        
        //NSLog(@"BOOL=======> %@" ,[self date:_selectedDate isSameDayAsDate:date] ? @"YES" : @"NO");
        
        if (_selectedDate && [self selectDate:_selectedDate isEqualToDate:date]) {//点击选中状态
            [_dateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _dateButton.backgroundColor = [UIColor blueColor];
            
            
           
            
            
        } else {
            [_dateButton setTitleColor:dateCell.textColor forState:UIControlStateNormal];
            _dateButton.backgroundColor = dateCell.backgroundColor;
            
        }
        
        _dateButton.frame = [self _calculateDayCellFrame:date];
        
        [self.calendarContainer addSubview:_dateButton];
        
        date = [self _nextDay:date];
        index++;
    }
    
    if ([self.xlDelegate respondsToSelector:@selector(calendarComponent:didLayoutInRect:)]) {
        [self.xlDelegate calendarComponent:self didLayoutInRect:self.frame];
    }
}

- (void)_updateDayOfWeekLabels {
    NSArray *weekdays = [self.dateFormatter shortWeekdaySymbols];
    // adjust array depending on which weekday should be first
    NSUInteger firstWeekdayIndex = [self.calendar firstWeekday] - 1;
    if (firstWeekdayIndex > 0) {
        weekdays = [[weekdays subarrayWithRange:NSMakeRange(firstWeekdayIndex, 7 - firstWeekdayIndex)]
                    arrayByAddingObjectsFromArray:[weekdays subarrayWithRange:NSMakeRange(0, firstWeekdayIndex)]];
    }
    
    NSUInteger i = 0;
    for (NSString *day in weekdays) {
        [[self.dayOfWeekLabels objectAtIndex:i] setText:[day uppercaseString]];
        i++;
    }
}

- (void)setLocale:(NSLocale *)locale {
    [self.dateFormatter setLocale:locale];
    [self _updateDayOfWeekLabels];
    [self setNeedsLayout];
}

- (NSLocale *)locale {
    return self.dateFormatter.locale;
}

- (NSArray *)datesShowing {
    NSMutableArray *dates = [NSMutableArray array];
    // NOTE: these should already be in chronological order
    for (DateButton *dateButton in self.dateButtons) {
        if (dateButton.buttonDate) {
            [dates addObject:dateButton.buttonDate];
        }
    }
    return dates;
}

- (void)setMonthShowing:(NSDate *)aMonthShowing {
    _monthShowing = [self _firstDayOfMonthContainingDate:aMonthShowing];
    [self setNeedsLayout];
}

- (void)setOnlyShowCurrentMonth:(BOOL)onlyShowCurrentMonth {
    _onlyShowCurrentMonth = onlyShowCurrentMonth;
    [self setNeedsLayout];
}

- (void)setAdaptHeightToNumberOfWeeksInMonth:(BOOL)adaptHeightToNumberOfWeeksInMonth {
    _adaptHeightToNumberOfWeeksInMonth = adaptHeightToNumberOfWeeksInMonth;
    [self setNeedsLayout];
}

- (void)_setDefaultStyle {
    self.backgroundColor = UIColorFromRGB(0x393B40);
    
    [self setTitleColor:[UIColor whiteColor]];
    [self setTitleFont:[UIFont boldSystemFontOfSize:17.0]];
    
    [self setDayOfWeekFont:[UIFont boldSystemFontOfSize:12.0]];
    [self setDayOfWeekTextColor:[UIColor blueColor]];
    
    
    [self setDayOfWeekBottomColor:UIColorFromRGB(0xCCCFD5) topColor:[UIColor whiteColor]];
    
    [self setDateFont:[UIFont boldSystemFontOfSize:16.0f]];
    [self setDateBorderColor:UIColorFromRGB(0xDAE1E6)];
}

- (CGRect)_calculateDayCellFrame:(NSDate *)date {
    NSInteger numberOfDaysSinceBeginningOfThisMonth = [self _numberOfDaysFromDate:self.monthShowing toDate:date];
    NSInteger row = (numberOfDaysSinceBeginningOfThisMonth + [self _placeInWeekForDate:self.monthShowing]) / 7;
    
    NSInteger placeInWeek = [self _placeInWeekForDate:date];
    
    return CGRectMake(placeInWeek * (self.cellWidth + 1), (row * (self.cellWidth + 1)) + CGRectGetMaxY(self.daysHeader.frame) + 1, self.cellWidth, self.cellWidth);
}

- (void)addSwipeGestureRecognizer {
    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(_moveCalendarToNextMonth)];
    swipLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipLeft];
    
    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(_moveCalendarToPreviousMonth)];
    swipRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipRight];
}

- (void)_moveCalendarToNextMonth {
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^(void) {
        NSDateComponents* comps = [[NSDateComponents alloc] init];
        [comps setMonth:1];
        NSDate *newMonth = [self.calendar dateByAddingComponents:comps toDate:self.monthShowing options:0];
        if ([self.xlDelegate respondsToSelector:@selector(calendarComponent:willChangeToMonth:)] && ![self.xlDelegate calendarComponent:self willChangeToMonth:newMonth]) {
            return;
        } else {
            self.monthShowing = newMonth;
            if ([self.xlDelegate respondsToSelector:@selector(calendarComponent:didChangeToMonth:)] ) {
                [self.xlDelegate calendarComponent:self didChangeToMonth:self.monthShowing];
            }
        }
    } completion:nil];
}

- (void)_moveCalendarToPreviousMonth {
   // [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^(void) {
        NSDateComponents* comps = [[NSDateComponents alloc] init];
        [comps setMonth:-1];
        NSDate *newMonth = [self.calendar dateByAddingComponents:comps toDate:self.monthShowing options:0];
        if ([self.xlDelegate respondsToSelector:@selector(calendarComponent:willChangeToMonth:)] && ![self.xlDelegate calendarComponent:self willChangeToMonth:newMonth]) {
            return;
        } else {
            self.monthShowing = newMonth;
            if ([self.xlDelegate respondsToSelector:@selector(calendarComponent:didChangeToMonth:)] ) {
                [self.xlDelegate calendarComponent:self didChangeToMonth:self.monthShowing];
            }
        }
    //} completion:nil];
}

#pragma mark - Theming getters/setters

- (void)setTitleFont:(UIFont *)font {
    self.titleLabel.font = font;
}
- (UIFont *)titleFont {
    return self.titleLabel.font;
}

- (void)setTitleColor:(UIColor *)color {
    self.titleLabel.textColor = color;
}
- (UIColor *)titleColor {
    return self.titleLabel.textColor;
}

- (void)setMonthButtonColor:(UIColor *)color {
    [self.lastButton setImage:[XLCalendarComponent _imageNamed:@"left_arrow.png" withColor:color] forState:UIControlStateNormal];
    [self.nextButton setImage:[XLCalendarComponent _imageNamed:@"right_arrow.png" withColor:color] forState:UIControlStateNormal];
}

- (void)setInnerBorderColor:(UIColor *)color {
    self.calendarContainer.layer.borderColor = color.CGColor;
}

- (void)setDayOfWeekFont:(UIFont *)font {
    for (UILabel *label in self.dayOfWeekLabels) {
        label.font = font;
    }
}
- (UIFont *)dayOfWeekFont {
    return (self.dayOfWeekLabels.count > 0) ? ((UILabel *)[self.dayOfWeekLabels lastObject]).font : nil;
}

- (void)setDayOfWeekTextColor:(UIColor *)color {
    for (UILabel *label in self.dayOfWeekLabels) {
        label.textColor = color;
    }
}
- (UIColor *)dayOfWeekTextColor {
    return (self.dayOfWeekLabels.count > 0) ? ((UILabel *)[self.dayOfWeekLabels lastObject]).textColor : nil;
}

- (void)setDayOfWeekBottomColor:(UIColor *)bottomColor topColor:(UIColor *)topColor {
    [self.daysHeader setColors:[NSArray arrayWithObjects:topColor, bottomColor, nil]];
}

- (void)setDateFont:(UIFont *)font {
    for (DateButton *dateButton in self.dateButtons) {
        dateButton.titleLabel.font = font;
    }
}
- (UIFont *)dateFont {
    return (self.dateButtons.count > 0) ? ((DateButton *)[self.dateButtons lastObject]).titleLabel.font : nil;
}

- (void)setDateBorderColor:(UIColor *)color {
    self.calendarContainer.backgroundColor = color;
}
- (UIColor *)dateBorderColor {
    return self.calendarContainer.backgroundColor;
}

#pragma mark - Calendar helpers

- (NSDate *)_firstDayOfMonthContainingDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    comps.day = 1;
    return [self.calendar dateFromComponents:comps];
}

- (NSDate *)_firstDayOfNextMonthContainingDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    comps.day = 1;
    comps.month = comps.month + 1;
    return [self.calendar dateFromComponents:comps];
}

- (BOOL)dateIsInCurrentMonth:(NSDate *)date {
    return ([self _compareByMonth:date toDate:self.monthShowing] == NSOrderedSame);
}

- (NSComparisonResult)_compareByMonth:(NSDate *)date toDate:(NSDate *)otherDate {
    NSDateComponents *day = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:date];
    
    
    NSDateComponents *day2 = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:otherDate];
    
    if (day.year < day2.year) {
        return NSOrderedAscending;
    } else if (day.year > day2.year) {
        return NSOrderedDescending;
    } else if (day.month < day2.month) {
        return NSOrderedAscending;
    } else if (day.month > day2.month) {
        return NSOrderedDescending;
    } else {
        return NSOrderedSame;
    }
}

- (NSInteger)_placeInWeekForDate:(NSDate *)date {
    NSDateComponents *compsFirstDayInMonth = [self.calendar components:NSCalendarUnitWeekday fromDate:date];
    return (compsFirstDayInMonth.weekday - 1 - self.calendar.firstWeekday + 8) % 7;
}

- (BOOL)_dateIsToday:(NSDate *)date {
    return [self selectDate:[NSDate date] isEqualToDate:date];
}

- (BOOL)selectDate:(NSDate *)selectDate isEqualToDate:(NSDate *)date {
    if (selectDate == nil || date == nil) {
        return NO;
    }
    
    NSDateComponents *day = [self.calendar components:NSCalendarUnitEra|NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay fromDate:selectDate];
    
    
    NSDateComponents *day2 = [self.calendar components:NSCalendarUnitEra|NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay fromDate:date];
    
    return ([day2 day] == [day day] &&
            [day2 month] == [day month] &&
            [day2 year] == [day year] &&
            [day2 era] == [day era]);
}

- (NSInteger)_numberOfWeeksInMonthContainingDate:(NSDate *)date {
    return [self.calendar rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:date].length;
}

- (NSDate *)_nextDay:(NSDate *)date {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    return [self.calendar dateByAddingComponents:comps toDate:date options:0];
}

- (NSDate *)_previousDay:(NSDate *)date {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:-1];
    return [self.calendar dateByAddingComponents:comps toDate:date options:0];
}

- (NSInteger)_numberOfDaysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate {
    NSInteger startDay = [self.calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitEra forDate:startDate];
    
    
    
    
    NSInteger endDay = [self.calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitEra forDate:endDate];
    return endDay - startDay;
}

+ (UIImage *)_imageNamed:(NSString *)name withColor:(UIColor *)color {
    UIImage *img = [UIImage imageNamed:name];
    
    UIGraphicsBeginImageContextWithOptions(img.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextDrawImage(context, rect, img.CGImage);
    
    CGContextClipToMask(context, rect, img.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return coloredImg;
}

@end