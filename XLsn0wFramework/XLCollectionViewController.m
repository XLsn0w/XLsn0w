
#import "XLCollectionViewController.h"
#import "XLCollectionViewCell.h"

@interface XLCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation XLCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionViewUI];
}
//根据item个数 自定义item之间的空隙大小
#define kItemCount 3
#define kItemSpace 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (CGRectGetWidth(collectionView.bounds) - kItemSpace * (kItemCount+1+2)) / kItemCount;
    return CGSizeMake(width, width);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(kItemSpace, kItemSpace, kItemSpace, kItemSpace);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kItemSpace;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kItemSpace;
}

#pragma mark - setup CollectionViewUI
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width) 
- (void)setupCollectionViewUI {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)
                                         collectionViewLayout:flowLayout];
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[XLCollectionViewCell class] forCellWithReuseIdentifier:@"XLCollectionViewCell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeader"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SectionFooter"];
//    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(parseData)];
//    [self.collectionView.mj_header beginRefreshing];
}

//- (void)parseData {
//    [self.collectionView.mj_header endRefreshing];
//}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 24;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLCollectionViewCell" forIndexPath:indexPath];
    [cell addValueWithImageUrl:@"imageUrl" title:@"title"];
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *sectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SectionHeader" forIndexPath:indexPath];
        sectionHeader.backgroundColor = [UIColor whiteColor];
        //绘制UI
        return sectionHeader;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *sectionFooter = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SectionFooter" forIndexPath:indexPath];
        sectionFooter.backgroundColor = [UIColor whiteColor];
        //绘制UI
        return sectionFooter;
    }
    return nil;
}

#define kSectionHeaderWidth ([UIScreen mainScreen].bounds.size.width)
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kSectionHeaderWidth, 100);
}

#define kSectionFooterWidth ([UIScreen mainScreen].bounds.size.width)
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kSectionFooterWidth, 100);
}

- (void)addHeaderUIWithHeader:(UICollectionReusableView *)header {
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
