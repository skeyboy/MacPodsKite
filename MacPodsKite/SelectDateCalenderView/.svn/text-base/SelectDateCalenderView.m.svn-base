//
//  SelectDateCalenderView.m
//  FLB
//
//  Created by 八月末 on 16/2/17.
//  Copyright © 2016年 Nightingale. All rights reserved.
//

#import "SelectDateCalenderView.h"
#import <JTCalendar/JTCalendar.h>

@interface SelectDateCalenderView () <JTCalendarDelegate> {
    NSString *_confirmDateStr;
    
    NSDate *_todayDate;
    NSDate *_dateSelected;
}

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (weak, nonatomic) IBOutlet UIButton *todayBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

//@property (strong, nonatomic) JTCalendar *calendar;
@property (weak, nonatomic) IBOutlet UIView *accessoryView;

@property (copy, nonatomic) DidSelectDateBlock didSelectDateBlock;
@property (copy, nonatomic) CurrentDateBlock currentDateBlock;
@property (copy, nonatomic) ConfirmDateBlock confirmDateBlock;
@property (copy, nonatomic) CancelBlock cancelBlock;

@end

@implementation SelectDateCalenderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
//    [super awakeFromNib];
//    self.accessoryView.backgroundColor = [UIColor defaultBackgroundColor];
    
    _todayDate = [NSDate date];
    CGSize mainSize = [UIScreen mainScreen].bounds.size;
    
    self.calendarManager = [JTCalendarManager new];
    self.calendarManager.delegate = self;
    self.calendarManager.settings.weekDayFormat = JTCalendarWeekDayFormatShort;
    self.calendarManager.dateHelper.calendar.timeZone = [NSTimeZone timeZoneWithName:@"CCD"];
    self.calendarManager.dateHelper.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh_Hans_CN"];
    self.calendarManager.dateHelper.calendar.firstWeekday = 2;
    
    [self.calendarManager setMenuView:_calendarMenuView];
    [self.calendarManager setContentView:_calendarContentView];
    [self.calendarManager setDate:_todayDate];
    
    _confirmDateStr = [self formatDateStringWithDefaultFormatterFromDate:_todayDate];
}
/*
- (void)layoutSubviews {
    //    [super layoutSubviews];
    [self.calendar repositionViews];
}
 */

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    
    return dateFormatter;
}

- (NSString *)formatDateStringWithDefaultFormatterFromDate:(NSDate *)date {
    return [[self dateFormatter] stringFromDate:date];
}

- (void)setCurrentDateBlock:(CurrentDateBlock)currentDateBlock
         didSelectDateBlock:(DidSelectDateBlock)didSelectDateBlock
                confirmDate:(ConfirmDateBlock)confirmDateBlock
                cancelBlock:(CancelBlock)cancelBlock {
    self.currentDateBlock   = currentDateBlock;
    self.didSelectDateBlock = didSelectDateBlock;
    self.confirmDateBlock   = confirmDateBlock;
    self.cancelBlock = cancelBlock;
}
/*
 - (void)setCurrentDate:(NSDate *)currentDate selectedDate:(NSDate *)selectedDate {
 self.calendar.currentDate = currentDate;
 self.calendar.currentDateSelected = selectedDate;
 
 [self updateConfirmDateStr];
 }
 */

- (void)updateConfirmDateStr {
    _confirmDateStr = [self formatDateStringWithDefaultFormatterFromDate:self.calendarContentView.date];
}

- (IBAction)didGoToday:(id)sender
{
    _dateSelected = _todayDate;
    [self.calendarManager setDate:_todayDate];
//    NSDate *now = [NSDate date];
//    [self.calendar setCurrentDate:now];
    
    NSString *nowDateStr = [self formatDateStringWithDefaultFormatterFromDate:_todayDate];
    if (self.currentDateBlock) {
        self.currentDateBlock(nowDateStr);
    }
}

- (IBAction)didConfirm:(id)sender
{
    if (self.confirmDateBlock) {
        self.confirmDateBlock(_confirmDateStr);
    }
}

- (IBAction)didCancel:(id)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    /*
    // Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
     */
    // Selected date
    /*else */if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    } else {
        // Today
        if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
            dayView.circleView.hidden = NO;
            dayView.circleView.backgroundColor = [UIColor blueColor];
            dayView.dotView.backgroundColor = [UIColor whiteColor];
            dayView.textLabel.textColor = [UIColor whiteColor];
        }
        // Other month
        else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
            dayView.circleView.hidden = YES;
            dayView.dotView.backgroundColor = [UIColor redColor];
            dayView.textLabel.textColor = [UIColor lightGrayColor];
        }
        // Another day of the current month
        else{
            dayView.circleView.hidden = YES;
            dayView.dotView.backgroundColor = [UIColor redColor];
            dayView.textLabel.textColor = [UIColor blackColor];
        }
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _dateSelected = dayView.date;
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                    } completion:^(BOOL finished) {
                        if (finished) {
                            NSString *dateStr = [self formatDateStringWithDefaultFormatterFromDate:_dateSelected];
                            NSLog(@"SelectedDate: %@", dateStr);
                            _confirmDateStr = dateStr;
                            if (self.didSelectDateBlock) {
                                self.didSelectDateBlock (dateStr);
                            }
                        }
                    }];
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}

#pragma mark - Views customization

- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UILabel *)menuItemView date:(NSDate *)date
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy   MMMM";
        
        dateFormatter.locale = _calendarManager.dateHelper.calendar.locale;
        dateFormatter.timeZone = _calendarManager.dateHelper.calendar.timeZone;
    }
    
    menuItemView.text = [dateFormatter stringFromDate:date];
}
@end
