

@import Foundation;
@import UIKit;

/**
 *  This category adds some useful methods to UITableView
 */
@interface UITableView (BFKit)

/**
 *  Create an UITableView and set some parameters
 *
 *  @param frame              TableView's frame
 *  @param style              TableView's style
 *  @param cellSeparatorStyle Cell separator style
 *  @param separatorInset     Cell separator inset
 *  @param dataSource         TableView's data source
 *  @param delegate           TableView's delegate
 *
 *  @return Returns the created UITableView
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                                  style:(UITableViewStyle)style
                     cellSeparatorStyle:(UITableViewCellSeparatorStyle)cellSeparatorStyle
                         separatorInset:(UIEdgeInsets)separatorInset
                             dataSource:(id <UITableViewDataSource> _Nullable)dataSource
                               delegate:(id <UITableViewDelegate> _Nullable)delegate;

/**
 *  Retrive all the IndexPaths for the section
 *
 *  @param section The section
 *
 *  @return Return an array with all the IndexPaths
 */
- (NSArray * _Nonnull)getIndexPathsForSection:(NSUInteger)section;

/**
 *  Retrive the next index path for the given row at section
 *
 *  @param row     Row of the index path
 *  @param section Section of the index path
 *
 *  @return Returns the next index path
 */
- (NSIndexPath * _Nonnull)getNextIndexPath:(NSUInteger)row
                                forSection:(NSUInteger)section;

/**
 *  Retrive the previous index path for the given row at section
 *
 *  @param row     Row of the index path
 *  @param section Section of the index path
 *
 *  @return Returns the previous index path
 */
- (NSIndexPath * _Nonnull)getPreviousIndexPath:(NSUInteger)row
                                    forSection:(NSUInteger)section;

@end
