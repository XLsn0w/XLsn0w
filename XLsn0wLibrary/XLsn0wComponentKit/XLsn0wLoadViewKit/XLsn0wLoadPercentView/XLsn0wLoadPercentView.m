
/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/


#import "XLsn0wLoadPercentView.h"

#import "XLsn0wLoadView.h"

@interface XLsn0wLoadPercentView ()

@property (strong, nonatomic,readwrite) NSString    *percentStr;
@property (nonatomic,strong   ) XLsn0wLoadView *loadingView;
@property (nonatomic,strong   ) UILabel     *percentLable;
@end

@implementation XLsn0wLoadPercentView {
    unsigned int         _nLoadProcent;     // 加载百分比
    NSTimer             *_tLoadTimer;       // 加载定时器
    int                  _nLoadSeconds;     // 加载等待时间
}
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame percentStr:(NSString *)percentStr
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self p_setUp];
        [self setShowContent:percentStr];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame percentStr:(NSString *)percentStr percentColor:(UIColor *)color
{
    self = [self initWithFrame:frame percentStr:percentStr];
    [self.percentLable setTextColor:color];
    return self;
}
- (NSString *)percentStr
{
   return  self.percentLable.text;
}

#pragma mark - 私有方法 相关设置
- (void)p_setUp {
    [self setBackgroundColor:[UIColor clearColor]];
    [self setClipsToBounds:NO];
    
    //loadView
    self.loadingView  = [[XLsn0wLoadView alloc]initWithXLsn0wLoadViewStyle:XLsn0wLoadViewStyleSqureCornersClockWise];
    
    float center_y = MIN(CGRectGetMidY(self.loadingView.frame), CGRectGetMidY(self.frame));
    [self.loadingView setCenter:CGPointMake(self.frame.size.width/2.0,center_y)];
    
    __weak typeof (self.loadingView) weakLodingView = self.loadingView;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakLodingView startSquareClcokwiseAnimation];
    });
    [self addSubview:self.loadingView];
    
    //percent
    self.percentLable = [[UILabel alloc]init];
    [self.percentLable setBackgroundColor:[UIColor clearColor]];
    [self.percentLable setTextAlignment:NSTextAlignmentCenter];
    [self.percentLable setFont:[UIFont systemFontOfSize:14.0]];
    [self.percentLable setFrame:CGRectMake(0.0, CGRectGetMaxY(self.loadingView.frame)+5,CGRectGetWidth(self.frame), 30)];
    [self.percentLable setTextColor:[UIColor whiteColor]];
    [self addSubview:self.percentLable];
    
}

#pragma mark -actions

- (void)setShowContent:(NSString *)content
{
    if(content)
    self.percentLable.text = content;

}


- (void)showPercentAnimation
{
    self.percentLable.text = @"0%";
    self.hidden = NO;
    
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       [self startAdmView];
                   });
}

- (void)startAdmView
{
    _nLoadProcent = 0;
    // 开启定时器，用于启动百分比计算
    if ([_tLoadTimer isValid])
    {
        [_tLoadTimer invalidate];
    }
    _tLoadTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                   target:self
                                                 selector:@selector(updateWaitTime:)
                                                 userInfo:nil
                                                  repeats:YES];
    
}

- (void)updateWaitTime:(NSTimer *)timer
{
    [self setWaitTime];
    
    _nLoadSeconds++;
    
}

/** @fn	setWaitTime
 *  @brief  等待百分比计数
 */
- (void)setWaitTime
{
    int x = arc4random() % 15;
    if(_nLoadProcent < 85)
    {
        _nLoadProcent = _nLoadProcent + x;
    }
    
    NSString * strTips = [NSString stringWithFormat:@"%d%%", _nLoadProcent];
    self.percentLable.text = strTips;
}


- (void)hideRemovePercentAnimation
{
    self.hidden = YES;
    _nLoadProcent = 0;
    self.percentLable.text = @"0%";
    
    if ([_tLoadTimer isValid])
    {
        [_tLoadTimer invalidate];
        _tLoadTimer = nil;
    }
    

}

@end
