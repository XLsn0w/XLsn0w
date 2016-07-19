
/*
   Cell View 在此只是继承 UITableView 
   如果自定义Cell 那必须增加 index 属性 ，本人比较懒直接使用 index 做些机制的处理
   自定义时没增加属性会导致奔溃
 */

#import <UIKit/UIKit.h>

@interface XLRecycleTableView : UITableView

@property (nonatomic, assign) NSInteger index;

@end
