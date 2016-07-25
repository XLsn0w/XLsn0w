//
//  ChoosePicViewController.m
//  UploadPic
//
//  Created by 谢昆鹏 on 16/3/13.
//  Copyright © 2016年 谢昆鹏. All rights reserved.
//

#import "ChoosePicViewController.h"
#import "DisplayImageCell.h"
#import <Photos/Photos.h>
#define With [UIScreen mainScreen].bounds.size.width / 3.1
#define Height [UIScreen mainScreen].bounds.size.height / 4

#import "ImageArraySingleton.h"

@interface ChoosePicViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
///展示图片列表
@property (nonatomic, retain) UICollectionView *collectionView;

@end

@implementation ChoosePicViewController

- (void)dealloc {
    self.picArray = nil;
    self.dataSoure = nil;
    self.collectionView = nil;
}
- (NSMutableArray *)picArray {
    if (!_picArray) {
        self.picArray = [NSMutableArray array];
    }
    return _picArray;
}

- (NSMutableArray *)dataSoure {
    if (!_dataSoure) {
        self.dataSoure = [NSMutableArray array];
    }
    return _dataSoure;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ///将存入单例里面照片标识取出来,准备展示
    self.picArray = [NSMutableArray arrayWithArray:[ImageArraySingleton shareSingleTon].imageArray];
    
    [self designUICollectionView];
}

/**
 *  设计UICollectionView
 */
- (void)designUICollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(With, Height);
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 10;
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor colorWithRed:220 green:210 blue:200 alpha:1];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[DisplayImageCell class] forCellWithReuseIdentifier:@"cell1"];
    ///导航条右侧选取完成按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(chooseOK:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleAll:)];
}

- (void)cancleAll:(UIBarButtonItem *)sender {
    [self.dataSoure removeAllObjects];
    [self.collectionView reloadData];
}


//- (void)back:(UIBarButtonItem *)sender {
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)chooseOK:(UIBarButtonItem *)sender {
    NSLog(@"选取结束");
    ///选取结束后将选取图片传递上一界面
    [self.dataSoure addObject:[UIImage imageNamed:@"plus"]];
    self.passValue(self.dataSoure);
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)getBlockFromOutSide:(PassValue)passValue {
    self.passValue = passValue;
}

#pragma mark UICollectionView UICollectionViewDataSource, UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.picArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DisplayImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    ///调用方法展示
    [cell displayCellWith:self.picArray[indexPath.row]];
    
    if ([self.dataSoure containsObject:[self.picArray objectAtIndex:indexPath.row]]) {
    cell.choosePic.image = [UIImage imageNamed:@"photoSelected"];
    }else {
    cell.choosePic.image = nil;
    }
    return cell;

}
///创建一个view当选择的超过9个时提示
- (void)youChooseTooMuch {
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 30)];
    myView.backgroundColor = [UIColor darkGrayColor];
    myView.alpha = 0;
    UILabel *mylable = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, [UIScreen mainScreen].bounds.size.width - 60, 20)];
    mylable.text = @"最多只能选取9张.";
    mylable.textColor = [UIColor whiteColor];
    mylable.font = [UIFont systemFontOfSize:15];
    mylable.textAlignment = NSTextAlignmentCenter;
    [myView addSubview:mylable];
    [self.view addSubview:myView];
    [UIView animateWithDuration:1 animations:^{
        myView.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            myView.alpha = 0;
        }];
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSoure containsObject:[self.picArray objectAtIndex:indexPath.row]]) {
        [self.dataSoure removeObject:[self.picArray objectAtIndex:indexPath.row]];
        NSIndexPath *path = [NSIndexPath indexPathForItem:indexPath.row inSection:indexPath.section];
        [self.collectionView reloadItemsAtIndexPaths:@[path]];
    }else {
        if (self.dataSoure.count <= 8) {
            [self.dataSoure addObject:[self.picArray objectAtIndex:indexPath.row]];
            NSIndexPath *path = [NSIndexPath indexPathForItem:indexPath.row inSection:indexPath.section];
            [self.collectionView reloadItemsAtIndexPaths:@[path]];
        }else {
            [self youChooseTooMuch];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
