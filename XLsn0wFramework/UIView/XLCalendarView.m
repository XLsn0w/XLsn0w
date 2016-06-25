
#import "XLCalendarView.h"
#import <QuartzCore/QuartzCore.h>
#import "NSDate+XL.h"
#import "UIView+XLsn0w.h"
#import "XLCalendar.h"
#import "XLDatetime.h"
#import "NSMutableArray+XLsn0w.h"
#import "FMDB.h"

@implementation XLCalendarView

@synthesize currentMonth,delegate,labelCurrentMonth, animationView_A,animationView_B;
@synthesize markedDates,markedColors,calendarHeight,selectedDate;

#pragma mark 获取日期的相关信息
-(NSString *)readyDatabase:(NSString *)dbName {
    BOOL success;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSError *error;
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    NSString *writableDBPath=[documentsDirectory stringByAppendingPathComponent:dbName];
    success=[fileManager fileExistsAtPath:writableDBPath];
    if(!success)
    {
        NSString *defaultDBPath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:dbName];
        success=[fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        if(!success)
        {
            NSLog(@"%@",[error localizedDescription]);
        }
    }
    return writableDBPath;
}

-(NSMutableDictionary *)getChineseCalendarInfo:(NSString *)date {
    NSString *dbPath =[self readyDatabase:@"ChineseCalendar.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    [db open];
    
    NSMutableDictionary *resultDict= [[NSMutableDictionary alloc] init];
    
    FMResultSet *rs = [db executeQuery:@"select * from ChineseCalendar where RiQi = ?", date];
    while ([rs next]) {
        [resultDict setObject:[rs stringForColumn:@"GanZhi"] forKey:@"GanZhi"];
        [resultDict setObject:[rs stringForColumn:@"Yi"] forKey:@"Yi"];
        [resultDict setObject:[rs stringForColumn:@"Ji"] forKey:@"Ji"];
        [resultDict setObject:[rs stringForColumn:@"Chong"] forKey:@"Chong"];
        [resultDict setObject:[rs stringForColumn:@"WuXing"] forKey:@"WuXing"];
    }
    [rs close];
    
    return resultDict;
}

-(void)selectDate:(int)date {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:self.currentMonth];
    [comps setDay:date];
    self.selectedDate = [gregorian dateFromComponents:comps];
    
    int selectedDateYear = [selectedDate year];
    int selectedDateMonth = [selectedDate month];
    int currentMonthYear = [currentMonth year];
    int currentMonthMonth = [currentMonth month];
    
    if (selectedDateYear < currentMonthYear) {
        [self showPreviousMonth];
    } else if (selectedDateYear > currentMonthYear) {
        [self showNextMonth];
    } else if (selectedDateMonth < currentMonthMonth) {
        [self showPreviousMonth];
    } else if (selectedDateMonth > currentMonthMonth) {
        [self showNextMonth];
    } else {
        [self setNeedsDisplay];
    }
    
    XLDateTime *CYDate = [[XLDateTime alloc]init];
    CYDate.year=[selectedDate year];
    CYDate.month=[selectedDate month];
    CYDate.day = [selectedDate day];
    XLCalendar *lunarCalendar = [[CYDate convertDate] chineseCalendarDate ];
    
//    NSLog(@"%d",date);
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString* dateString = [[NSString alloc]initWithString:[formatter stringFromDate:self.selectedDate]];

    
    
    NSMutableDictionary *detailDict=[[NSMutableDictionary alloc] initWithDictionary:[self getChineseCalendarInfo:dateString]];
    [detailDict setObject:[NSString stringWithFormat:@"%d%d%d",lunarCalendar.GregorianYear,lunarCalendar.GregorianMonth,lunarCalendar.GregorianDay] forKey:@"GregorianDate"];
    
    [detailDict setObject:[NSString stringWithFormat:@"%@%@%@",lunarCalendar.IsLeap?@"闰":@"", lunarCalendar.MonthLunar,lunarCalendar.DayLunar] forKey:@"LunarDate"];
    
    [detailDict setObject:[NSString stringWithFormat:@"%@",lunarCalendar.Constellation] forKey:@"Constellation"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //每周的第一天从星期一开始
    [calendar setFirstWeekday:1];
    NSDateComponents *comps2 = [calendar components:NSWeekCalendarUnit fromDate:self.selectedDate];
    
    [detailDict setObject:[NSString stringWithFormat:@"第%ld周",(long)comps2.weekOfMonth] forKey:@"Weekday"];
    
    
    if ([delegate respondsToSelector:@selector(calendarView:dateSelected:lunarDict:)]) {
        [delegate calendarView:self dateSelected:self.selectedDate lunarDict:detailDict];
    }
}

#pragma mark - Mark Dates
//NSArray can either contain NSDate objects or NSNumber objects with an int of the day.
-(void)markDates:(NSArray *)dates {
    self.markedDates = dates;
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<[dates count]; i++) {
        [colors addObject:[UIColor colorWithHexString:@"0x079700"]];
    }
    
    self.markedColors = [NSArray arrayWithArray:colors];

    
    
    [self setNeedsDisplay];
}

//NSArray can either contain NSDate objects or NSNumber objects with an int of the day.
-(void)markDates:(NSArray *)dates withColors:(NSArray *)colors {
    self.markedDates = dates;
    self.markedColors = colors;
    
    [self setNeedsDisplay];
}

#pragma mark - Set date to now
-(void)reset {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components =
    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |
                           NSDayCalendarUnit) fromDate: [NSDate date]];
    self.currentMonth = [gregorian dateFromComponents:components]; //clean month
    
    [self updateSize];
    [self setNeedsDisplay];
    [delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:NO];
    
    [self selectDate:[NSDate date].day];
}

#pragma mark - Next & Previous
-(void)showNextMonth {
    if (isAnimating) return;
    self.markedDates=nil;
    isAnimating=YES;
    prepAnimationNextMonth=YES;
    
    [self setNeedsDisplay];
    
    int lastBlock = [currentMonth firstWeekDayInMonth]+[currentMonth numDaysInMonth]-1;
    int numBlocks = [self numRows]*7;
    BOOL hasNextMonthDays = lastBlock<numBlocks;
    
    //Old month
    float oldSize = self.calendarHeight;
    UIImage *imageCurrentMonth = [self drawCurrentState];
    
    //New month
    self.currentMonth = [currentMonth offsetMonth:1];
    if ([delegate respondsToSelector:@selector(calendarView:switchedToMonth:targetHeight: animated:)]) [delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:YES];
    prepAnimationNextMonth=NO;
    [self setNeedsDisplay];
    
    UIImage *imageNextMonth = [self drawCurrentState];
    float targetSize = fmaxf(oldSize, self.calendarHeight);
    UIView *animationHolder = [[UIView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kScreenWidth, targetSize-kTopBarHeight)];
    [animationHolder setClipsToBounds:YES];
    [self addSubview:animationHolder];
    
    //Animate
    animationView_A = [[UIImageView alloc] initWithImage:imageCurrentMonth];
    animationView_B = [[UIImageView alloc] initWithImage:imageNextMonth];
    [animationHolder addSubview:animationView_A];
    [animationHolder addSubview:animationView_B];

    
    if (hasNextMonthDays) {
        animationView_B.frameY = animationView_A.frameY + animationView_A.frameHeight - (kDayHeight+3);
    } else {
        animationView_B.frameY = animationView_A.frameY + animationView_A.frameHeight -3;
    }
    
    //Animation
    __block XLCalendarView *blockSafeSelf = self;
    [UIView animateWithDuration:.35
                     animations:^{
                         [self updateSize];
                         //blockSafeSelf.frameHeight = 100;
                         if (hasNextMonthDays) {
                             animationView_A.frameY = -animationView_A.frameHeight + kDayHeight+3;
                         } else {
                             animationView_A.frameY = -animationView_A.frameHeight + 3;
                         }
                         animationView_B.frameY = 0;
                     }
                     completion:^(BOOL finished) {
                         [animationView_A removeFromSuperview];
                         [animationView_B removeFromSuperview];
                         blockSafeSelf.animationView_A=nil;
                         blockSafeSelf.animationView_B=nil;
                         isAnimating=NO;
                         [animationHolder removeFromSuperview];
                     }
     ];
}

-(void)showPreviousMonth {
    if (isAnimating) return;
    isAnimating=YES;
    self.markedDates=nil;
    //Prepare current screen
    prepAnimationPreviousMonth = YES;
    [self setNeedsDisplay];
    BOOL hasPreviousDays = [currentMonth firstWeekDayInMonth]>1;
    float oldSize = self.calendarHeight;
    UIImage *imageCurrentMonth = [self drawCurrentState];
    
    //Prepare next screen
    self.currentMonth = [currentMonth offsetMonth:-1];
    if ([delegate respondsToSelector:@selector(calendarView:switchedToMonth:targetHeight:animated:)]) [delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:YES];
    prepAnimationPreviousMonth=NO;
    [self setNeedsDisplay];
    UIImage *imagePreviousMonth = [self drawCurrentState];
    
    float targetSize = fmaxf(oldSize, self.calendarHeight);
    UIView *animationHolder = [[UIView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kScreenWidth, targetSize-kTopBarHeight)];
    
    [animationHolder setClipsToBounds:YES];
    [self addSubview:animationHolder];
    
    animationView_A = [[UIImageView alloc] initWithImage:imageCurrentMonth];
    animationView_B = [[UIImageView alloc] initWithImage:imagePreviousMonth];
    [animationHolder addSubview:animationView_A];
    [animationHolder addSubview:animationView_B];

    
    if (hasPreviousDays) {
        animationView_B.frameY = animationView_A.frameY - (animationView_B.frameHeight-kDayHeight) + 3;
    } else {
        animationView_B.frameY = animationView_A.frameY - animationView_B.frameHeight + 3;
    }
    
    __block XLCalendarView *blockSafeSelf = self;
    [UIView animateWithDuration:.35
                     animations:^{
                         [self updateSize];
                         
                         if (hasPreviousDays) {
                             animationView_A.frameY = animationView_B.frameHeight-(kDayHeight+3);
                             
                         } else {
                             animationView_A.frameY = animationView_B.frameHeight-3;
                         }
                         
                         animationView_B.frameY = 0;
                     }
                     completion:^(BOOL finished) {
                         [animationView_A removeFromSuperview];
                         [animationView_B removeFromSuperview];
                         blockSafeSelf.animationView_A=nil;
                         blockSafeSelf.animationView_B=nil;
                         isAnimating=NO;
                         [animationHolder removeFromSuperview];
                     }
     ];
}


#pragma mark - update size & row count
-(void)updateSize {
    self.frameHeight = self.calendarHeight;
    [self setNeedsDisplay];
}

-(float)calendarHeight {
    return kTopBarHeight + [self numRows]*(kDayHeight+2)+1;
}

-(int)numRows {
    float lastBlock = [self.currentMonth numDaysInMonth]+([self.currentMonth firstWeekDayInMonth]-1);
    return ceilf(lastBlock/7);
}

#pragma mark - Touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [UIView xlsn0w_showMessage:@"签到成功"];
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    self.selectedDate=nil;
    
    //Touch a specific day
    if (touchPoint.y > kTopBarHeight) {
        float xLocation = touchPoint.x;
        float yLocation = touchPoint.y-kTopBarHeight;
        
        int column = floorf(xLocation/(kDayWidth+2));
        int row = floorf(yLocation/(kDayHeight+2));
        
        int blockNr = (column+1)+row*7;
        int firstWeekDay = [self.currentMonth firstWeekDayInMonth]; //-1 because weekdays begin at 1, not 0
        int date = blockNr-firstWeekDay;
        [self selectDate:date];
        return;
    }
    
    self.markedDates=nil;
    self.markedColors=nil;  
    
    CGRect rectArrowLeft = CGRectMake(0, 0, 50, 40);
    CGRect rectArrowRight = CGRectMake(self.frame.size.width-50, 0, 50, 40);
    
    //Touch either arrows or month in middle
    if (CGRectContainsPoint(rectArrowLeft, touchPoint)) {
        [self showPreviousMonth];
    } else if (CGRectContainsPoint(rectArrowRight, touchPoint)) {
        [self showNextMonth];
    } else if (CGRectContainsPoint(self.labelCurrentMonth.frame, touchPoint)) {
        //Detect touch in current month
        int currentMonthIndex = [self.currentMonth month];
        int todayMonth = [[NSDate date] month];
        [self reset];
        if ((todayMonth!=currentMonthIndex) && [delegate respondsToSelector:@selector(calendarView:switchedToMonth:targetHeight:animated:)]) [delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:NO];
    }
}

#pragma mark - Drawing
- (void)drawRect:(CGRect)rect {
    int firstWeekDay = [self.currentMonth firstWeekDayInMonth]; //-1 because weekdays begin at 1, not 0
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月"];
    labelCurrentMonth.text = [formatter stringFromDate:self.currentMonth];
    [labelCurrentMonth sizeToFit];
    labelCurrentMonth.frameX = roundf(self.frame.size.width/2 - labelCurrentMonth.frameWidth/2);
    labelCurrentMonth.frameY = 10;

    
    [currentMonth firstWeekDayInMonth];
    
    CGContextClearRect(UIGraphicsGetCurrentContext(),rect);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rectangle = CGRectMake(0,0,self.frame.size.width, kTopBarHeight);
    CGContextAddRect(context, rectangle);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillPath(context);
    
    //Arrows
    int arrowSize = 12;
    int xmargin = 20;
    int ymargin = 18;
    
    //Arrow Left
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, xmargin+arrowSize/1.5, ymargin);
    CGContextAddLineToPoint(context,xmargin+arrowSize/1.5,ymargin+arrowSize);
    CGContextAddLineToPoint(context,xmargin,ymargin+arrowSize/2);
    CGContextAddLineToPoint(context,xmargin+arrowSize/1.5, ymargin);
    
    CGContextSetFillColorWithColor(context, 
                                   [UIColor blackColor].CGColor);
    CGContextFillPath(context);
    
    //Arrow right
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.frame.size.width-(xmargin+arrowSize/1.5), ymargin);
    CGContextAddLineToPoint(context,self.frame.size.width-xmargin,ymargin+arrowSize/2);
    CGContextAddLineToPoint(context,self.frame.size.width-(xmargin+arrowSize/1.5),ymargin+arrowSize);
    CGContextAddLineToPoint(context,self.frame.size.width-(xmargin+arrowSize/1.5), ymargin);
    
    CGContextSetFillColorWithColor(context, 
                                   [UIColor blackColor].CGColor);
    CGContextFillPath(context);
    
    //Weekdays
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat=@"EEE";
    //always assume gregorian with monday first
    NSMutableArray *weekdays = [[NSMutableArray alloc] initWithArray:[dateFormatter shortWeekdaySymbols]];
    [weekdays moveObjectFromIndex:0 toIndex:6];
    
    //chinese array for weekdays
    NSArray *chineseWeekdays= [NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",nil];
    
    
    for (int i =0; i<[weekdays count]; i++) {
        
        if (i==0||i==6)
        {
            CGContextSetFillColorWithColor(context,
                                           [UIColor colorWithHexString:@"0xff3333"].CGColor);
        }
        else
        {
            CGContextSetFillColorWithColor(context,
                                           [UIColor colorWithHexString:@"0x383838"].CGColor);
        }
        
        NSString *weekdayValue = (NSString *)[chineseWeekdays objectAtIndex:i];
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByClipping;
        paragraphStyle.alignment = NSTextAlignmentCenter;
       
         NSDictionary *attribute = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12], NSParagraphStyleAttributeName:paragraphStyle};
        
        [weekdayValue drawInRect:CGRectMake(i*(kDayWidth+2), 40, kDayWidth+2, 20) withAttributes:attribute];
        
    }
    
    int numRows = [self numRows];
    
    CGContextSetAllowsAntialiasing(context, NO);
    
    //Grid background
    float gridHeight = numRows*(kDayHeight+2)+1;
    CGRect rectangleGrid = CGRectMake(0, kTopBarHeight,self.frame.size.width,gridHeight);
    CGContextAddRect(context, rectangleGrid);
    CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0xf3f3f3"].CGColor);
    //CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0xff0000"].CGColor);
    CGContextFillPath(context);
    
    //Grid white lines
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, kTopBarHeight+1);
    CGContextAddLineToPoint(context, kScreenWidth, kTopBarHeight+1);
    for (int i = 1; i<7; i++) {
        CGContextMoveToPoint(context, i*(kDayWidth+1)+i*1-1, kTopBarHeight);
        CGContextAddLineToPoint(context, i*(kDayWidth+1)+i*1-1, kTopBarHeight + gridHeight);
        
        if (i>numRows-1) continue;
        //rows
        CGContextMoveToPoint(context, 0, kTopBarHeight+i*(kDayHeight+1)+i*1+1);
        CGContextAddLineToPoint(context, kScreenWidth, kTopBarHeight+i*(kDayHeight+1)+i*1+1);
    }
    
    CGContextStrokePath(context);
    
    //Grid dark lines
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"0xcfd4d8"].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, kTopBarHeight);
    CGContextAddLineToPoint(context, kScreenWidth, kTopBarHeight);
    for (int i = 1; i<7; i++) {
        //columns
        CGContextMoveToPoint(context, i*(kDayWidth+1)+i*1, kTopBarHeight);
        CGContextAddLineToPoint(context, i*(kDayWidth+1)+i*1, kTopBarHeight + gridHeight);
        
        if (i>numRows-1) continue;
        //rows
        CGContextMoveToPoint(context, 0, kTopBarHeight+i*(kDayHeight+1)+i*1);
        CGContextAddLineToPoint(context, kScreenWidth, kTopBarHeight+i*(kDayHeight+1)+i*1);
    }
    CGContextMoveToPoint(context, 0, gridHeight+kTopBarHeight);
    CGContextAddLineToPoint(context, kScreenWidth, gridHeight+kTopBarHeight);
    
    CGContextStrokePath(context);
    
    CGContextSetAllowsAntialiasing(context, YES);
    
    //Draw days
    CGContextSetFillColorWithColor(context, 
                                   [UIColor colorWithHexString:@"0x383838"].CGColor);
    
    int numBlocks = numRows*7;
    NSDate *previousMonth = [self.currentMonth offsetMonth:-1];
    int currentMonthNumDays = [currentMonth numDaysInMonth];
    int prevMonthNumDays = [previousMonth numDaysInMonth];
    
    int selectedDateBlock = ([selectedDate day]-1)+firstWeekDay;
    
    //prepAnimationPreviousMonth nog wat mee doen
    
    //prev next month
    BOOL isSelectedDatePreviousMonth = prepAnimationPreviousMonth;
    BOOL isSelectedDateNextMonth = prepAnimationNextMonth;
    
    if (self.selectedDate!=nil) {
        isSelectedDatePreviousMonth = ([selectedDate year]==[currentMonth year] && [selectedDate month]<[currentMonth month]) || [selectedDate year] < [currentMonth year];
        
        if (!isSelectedDatePreviousMonth) {
            isSelectedDateNextMonth = ([selectedDate year]==[currentMonth year] && [selectedDate month]>[currentMonth month]) || [selectedDate year] > [currentMonth year];
        }
    }
    
    if (isSelectedDatePreviousMonth) {
        int lastPositionPreviousMonth = firstWeekDay-1;
        selectedDateBlock=lastPositionPreviousMonth-([selectedDate numDaysInMonth]-[selectedDate day]);
    } else if (isSelectedDateNextMonth) {
        selectedDateBlock = [currentMonth numDaysInMonth] + (firstWeekDay-1) + [selectedDate day];
    }
    
    
    NSDate *todayDate = [NSDate date];
    int todayBlock = -1;
    
    if ([todayDate month] == [currentMonth month] && [todayDate year] == [currentMonth year]) {
        todayBlock = [todayDate day] + firstWeekDay - 1;
    }
    
    for (int i=0; i<numBlocks; i++) {
        int targetDate ;
        int targetColumn = i%7;
        int targetRow = i/7;
        int targetX = targetColumn * (kDayWidth+2);
        int targetY = kTopBarHeight + targetRow * (kDayHeight+2);
        
        XLDateTime *CYDate = [[XLDateTime alloc]init];
        
        // BOOL isCurrentMonth = NO;
        if (i<firstWeekDay)
        { //previous month
            targetDate = (prevMonthNumDays-firstWeekDay)+(i+1);
            NSString *hex = (isSelectedDatePreviousMonth) ? @"0x383838" : @"aaaaaa";
            
            if(targetColumn==0||targetColumn==6)
            {
                CGContextSetFillColorWithColor(context,
                                           [UIColor colorWithHexString:@"0xf39999"].CGColor);
            }
            else
            {
                CGContextSetFillColorWithColor(context,
                                               [UIColor colorWithHexString:hex].CGColor);
            }
            
            if([self.currentMonth month]==1)
            {
                CYDate.year=[self.currentMonth year]-1;
                CYDate.month =12;
            }
            else
            {
                CYDate.year=[self.currentMonth year];
                CYDate.month =[self.currentMonth month]-1;
            }
            
            
        }
        else if (i>=(firstWeekDay+currentMonthNumDays))
        { //next month
            targetDate = (i+1) - (firstWeekDay+currentMonthNumDays);
            NSString *hex = (isSelectedDateNextMonth) ? @"0x383838" : @"aaaaaa";
            
            if(targetColumn==0||targetColumn==6)
            {
                CGContextSetFillColorWithColor(context,
                                               [UIColor colorWithHexString:@"0xf39999"].CGColor);
            }
            else
            {
                CGContextSetFillColorWithColor(context,
                                               [UIColor colorWithHexString:hex].CGColor);
            }
            
            if([self.currentMonth month]==12)
            {
                CYDate.year=[self.currentMonth year]+1;
                CYDate.month =1;
            }
            else
            {
                CYDate.year=[self.currentMonth year];
                CYDate.month =[self.currentMonth month]+1;
            }
        }
        else
        { //current month
            // isCurrentMonth = YES;
            targetDate = (i-firstWeekDay)+1;
            NSString *hex = (isSelectedDatePreviousMonth || isSelectedDateNextMonth) ? @"0xaaaaaa" : @"0x383838";
            
            if(targetColumn==0||targetColumn==6)
            {
                CGContextSetFillColorWithColor(context,
                                               [UIColor colorWithHexString:@"0xff3333"].CGColor);
            }
            else
            {
                CGContextSetFillColorWithColor(context,
                                               [UIColor colorWithHexString:hex].CGColor);
            }
            
            CYDate.year=[self.currentMonth year];
            CYDate.month =[self.currentMonth month];
        }
        
        CYDate.day = targetDate;
        XLCalendar *lunarCalendar = [[CYDate convertDate] chineseCalendarDate ];
        NSString * lunarDate = [lunarCalendar.DayLunar isEqualToString:@"初一"]?lunarCalendar.MonthLunar :[[NSString alloc]initWithFormat:
                                @"%@",[lunarCalendar.SolarTermTitle isEqualToString:@""]?lunarCalendar.DayLunar:lunarCalendar.SolarTermTitle];
        
        
        NSString *date = [NSString stringWithFormat:@"%i",targetDate];
        
        //draw selected date
        if (selectedDate && i==selectedDateBlock) {
            CGRect rectangleGrid = CGRectMake(targetX,targetY,kDayWidth+2,kDayHeight+2);
            CGContextAddRect(context, rectangleGrid);
            CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0x006dbc"].CGColor);
            CGContextFillPath(context);
            
            CGContextSetFillColorWithColor(context, 
                                           [UIColor whiteColor].CGColor);
        } else if (todayBlock==i) {
            CGRect rectangleGrid = CGRectMake(targetX,targetY,kDayWidth+2,kDayHeight+2);
            CGContextAddRect(context, rectangleGrid);
            CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0x383838"].CGColor);
            CGContextFillPath(context);
            
            CGContextSetFillColorWithColor(context, 
                                           [UIColor whiteColor].CGColor);
        }
        
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByClipping;
        paragraphStyle.alignment = NSTextAlignmentCenter;
    
        //公历几号
        NSDictionary *attribute1 = @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17], NSParagraphStyleAttributeName:paragraphStyle};
        [date drawInRect:CGRectMake(targetX, (targetY+10), kDayWidth, kDayHeight) withAttributes:attribute1];
        
        //农历几号
        NSDictionary *attribute2 = @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:8], NSParagraphStyleAttributeName:paragraphStyle};
        [lunarDate drawInRect:CGRectMake(targetX, (targetY+30), kDayWidth, kDayHeight) withAttributes:attribute2];
        
        /*节假日纪念日
        NSString *holiday = @"";
        if ([lunarCalendar.Holiday count] > 0) {
            holiday = [[[lunarCalendar.Holiday objectAtIndex:0] componentsSeparatedByString:@" "] objectAtIndex:0];
        } else {
            holiday = @"";
        }
        NSDictionary *attributeDictionary = @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:8], NSParagraphStyleAttributeName:paragraphStyle};
        [holiday drawInRect:CGRectMake(targetX, targetY+22, kVRGCalendarViewDayWidth, kVRGCalendarViewDayHeight) withAttributes:attributeDictionary];
        */
    }
    
    //    CGContextClosePath(context);
    
    
    //Draw markings
    if (!self.markedDates || isSelectedDatePreviousMonth || isSelectedDateNextMonth) return;
    
    for (int i = 0; i<[self.markedDates count]; i++) {
        id markedDateObj = [self.markedDates objectAtIndex:i];
        
        int targetDate;
        if ([markedDateObj isKindOfClass:[NSNumber class]]) {
            targetDate = [(NSNumber *)markedDateObj intValue];
        } else if ([markedDateObj isKindOfClass:[NSDate class]]) {
            NSDate *date = (NSDate *)markedDateObj;
            targetDate = [date day];
        } else {
            continue;
        }
        
        int targetBlock = firstWeekDay + (targetDate-1);
        int targetColumn = targetBlock%7;
        int targetRow = targetBlock/7;
        
        int targetX = targetColumn * (kDayWidth+2) + 7;
        int targetY = kTopBarHeight + targetRow * (kDayHeight+2) + 38;
        
        CGRect rectangle = CGRectMake(targetX+10,targetY+4,10,4);
        CGContextAddRect(context, rectangle);
        
        UIColor *color;
        if (selectedDate && selectedDateBlock==targetBlock) {
            color = [UIColor whiteColor];
        }  else if (todayBlock==targetBlock) {
            color = [UIColor whiteColor];
        } else {
            color  = (UIColor *)[markedColors objectAtIndex:i];
        }
        
        
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillPath(context);
    }
}

#pragma mark - Draw image for animation
-(UIImage *)drawCurrentState {
    float targetHeight = kTopBarHeight + [self numRows]*(kDayHeight+2)+1;
    
    UIGraphicsBeginImageContext(CGSizeMake(kScreenWidth, targetHeight - kTopBarHeight));
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(c, 0, -kTopBarHeight);    // <-- shift everything up by 40px when drawing.
    [self.layer renderInContext:c];
    UIImage* viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

/*!
 * @author XLsn0w, 16-06-22
 * 重写init方法
 */
- (instancetype)init {
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)]) {
        self.contentMode = UIViewContentModeTop;
        self.clipsToBounds=YES;
        isAnimating=NO;
        labelCurrentMonth = [[UILabel alloc] initWithFrame:CGRectMake(34, 0, kScreenWidth-68, 40)];
        [self addSubview:labelCurrentMonth];
        labelCurrentMonth.backgroundColor=[UIColor whiteColor];
        labelCurrentMonth.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
        labelCurrentMonth.textColor = [UIColor colorWithHexString:@"0x383838"];
        labelCurrentMonth.textAlignment = NSTextAlignmentCenter;
        [self reset];
    }
    return self;
}

@end
