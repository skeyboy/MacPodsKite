//
//  SelectDateCalenderView.h
//  FLB
//
//  Created by 八月末 on 16/2/17.
//  Copyright © 2016年 Nightingale. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CurrentDateBlock)(NSString *currentDate);
typedef void(^DidSelectDateBlock)(NSString *didSelectDate);
typedef void(^ConfirmDateBlock)(NSString *confirmDate);
typedef void(^CancelBlock)(void);

@interface SelectDateCalenderView : UIView

@property (weak, nonatomic, readonly) UIView *accessoryView;

- (void)setCurrentDateBlock:(CurrentDateBlock)currentDateBlock
         didSelectDateBlock:(DidSelectDateBlock)didSelectDateBlock
                confirmDate:(ConfirmDateBlock)confirmDateBlock
                cancelBlock:(CancelBlock)cancelBlock;
- (NSString *)formatDateStringWithDefaultFormatterFromDate:(NSDate *)date;

//- (void)setCurrentDate:(NSDate *)currentDate selectedDate:(NSDate *)selectedDate;
@end
