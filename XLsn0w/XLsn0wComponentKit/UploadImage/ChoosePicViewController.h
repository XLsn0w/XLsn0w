
#import <UIKit/UIKit.h>

//定义一个Block类型
typedef void(^PassValue) (NSMutableArray *array);

@interface ChoosePicViewController : UIViewController

///获取本地所有图片
@property (nonatomic , retain) NSMutableArray *picArray;
///定义一个passvalue类型
@property (nonatomic, copy) PassValue passValue;

///记录被点击的cell的图片路径
@property (nonatomic, retain) NSMutableArray *dataSoure;

///定义方法接受外界传递来的block
- (void)getBlockFromOutSide :(PassValue)passValue;

@end
