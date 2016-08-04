
#import "RMActionController.h"

/**
 *  RMPickerViewController is an iOS control for selecting a row using UIPickerView in a UIActionSheet like fashion. When a RMPickerViewController is shown the user gets the opportunity to select some rows using a UIPickerView.
 *  
 *  RMPickerViewController supports bouncing effects when animating the picker view controller. In addition, motion effects are supported while showing the picker view controller. Both effects can be disabled by using the properties called disableBouncingWhenShowing and disableMotionEffects.
 *
 *  On iOS 8 and later Apple opened up their API for blurring the background of UIViews. RMPickerViewController makes use of this API. The type of the blur effect can be changed by using the blurEffectStyle property. If you want to disable the blur effect you can do so by using the disableBlurEffects property.
 *
 *  @warning RMPickerViewController is not designed to be reused. Each time you want to display a RMPickerViewController a new instance should be created. If you want to select a specific row before displaying, you can do so by using the picker property.
 */
@interface RMPickerViewController : RMActionController <UIPickerView *>

/* Will return the instance of UIPickerView that is used. */
@property (nonatomic, readonly) UIPickerView *picker;

@end

/*! 创建并显示方法
 *  - (void)showStatusPickerView:(UIButton *)button {
 RMActionControllerStyle style = RMActionControllerStyleWhite;
 RMAction<RMActionController<UIPickerView *> *> *selectAction = [RMAction<RMActionController<UIPickerView *> *> actionWithTitle:@"确定" style:RMActionStyleDone andHandler:^(RMActionController<UIPickerView *> *controller) {
 NSMutableArray *selectedRows = [NSMutableArray array];
 
 for(NSInteger i=0 ; i<[controller.contentView numberOfComponents] ; i++) {
 [selectedRows addObject:@([controller.contentView selectedRowInComponent:i])];
 }
 
 
 _status = (NSString *)selectedRows;
 NSLog(@"=_status======> %@", _status);
 [_selectStatusButton setTitle:[_statusInfo objectForKey:_status] forState:(UIControlStateNormal)];
 NSLog(@"=[_statusInfo objectForKey:_status]======> %@", [_statusInfo objectForKey:@"0"]);
 }];
 
 RMAction<RMActionController<UIPickerView *> *> *cancelAction = [RMAction<RMActionController<UIPickerView *> *> actionWithTitle:@"取消" style:RMActionStyleCancel andHandler:^(RMActionController<UIPickerView *> *controller) {
 }];
 
 RMPickerViewController *pickerController = [RMPickerViewController actionControllerWithStyle:style];
 pickerController.title = @"选择状态";
 pickerController.picker.dataSource = self;
 pickerController.picker.delegate = self;
 
 [pickerController addAction:selectAction];
 [pickerController addAction:cancelAction];
 
 pickerController.disableBlurEffects = YES;
 
 [self presentViewController:pickerController animated:YES completion:nil];
 }
 
 - (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
 return 1;
 }
 
 - (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
 return 4;
 }
 
 - (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
 return [_statusInfo objectForKey:[NSString stringWithFormat:@"%ld", row]];
 }
 */
