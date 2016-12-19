
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

#import "XLsn0wLoadViewItem.h"

@implementation XLsn0wLoadViewItem


- (instancetype)init {
    if(self = [super init]){
        //todo
    }
    return self;
}


+ (instancetype)initWithImage:(UIImage*)image {
    
    XLsn0wLoadViewItem *item              = [[XLsn0wLoadViewItem alloc]init];
    item.colorCirculeLayer             = [CALayer layer];
    item.colorCirculeLayer.contents    = (id)image.CGImage;
    item.colorCirculeLayer.frame       = CGRectMake(0.0, 0.0, 10, 10);
    return item;
}

- (void)setPosition:(CGPoint)position
{
    [self.colorCirculeLayer setPosition:position];
}

@end
