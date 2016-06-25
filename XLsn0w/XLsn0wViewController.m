
#import "XLsn0wViewController.h"
#import "XLsn0w.h"

@interface XLsn0wViewController ()

@end

@implementation XLsn0wViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"XLsn0w Framework";
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

@end
