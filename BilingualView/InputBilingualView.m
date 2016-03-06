//
//  InputBilingualView.m
//  TLB
//
//  Created by 李雨龙 on 16/1/25.
//  Copyright © 2016年 杰之能. All rights reserved.
//

#import "InputBilingualView.h"
#import "Masonry.h"
#import "KTSelectPickerView.h"
@implementation InputBilingualView
@synthesize bilingView = _bilingView;
-(instancetype)init{
    if (self = [super init]) {
        _bilingView = [BilingualView new];
        _bilingView.mode = BilingualModeVertical;
        
        _inputField = [UITextField new];
        _inputField.delegate = self;
        
        _inputField.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:_bilingView];
        [self addSubview:_inputField];
        [self setUpViews];
            }
    return self;
}
-(void)setEndEdite:(BOOL)endEdite{
    [_inputField endEditing:endEdite];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (_aScrollView == nil) {
        _aScrollView =    (UIScrollView *)    self.superview.superview.superview;
    }
    if ([_aScrollView isKindOfClass:[UIScrollView class]]) {
        
        _preOffSet = _aScrollView.contentOffset;
        _aScrollView.contentOffset = CGPointMake(0, 200);
    }
}
- (void)enableXIBCalender:(UITextField *) textField{
    NSString *originalText = textField.text;
    SelectDateCalenderView *calenderView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SelectDateCalenderView class]) owner:self options:nil].firstObject;;
    
    [calenderView setCurrentDateBlock:^(NSString *currentDate) {
        textField.text = currentDate;
    } didSelectDateBlock:^(NSString *didSelectDate) {
        textField.text = didSelectDate;
    } confirmDate:^(NSString *confirmDate) {
        textField.text = confirmDate;
        [textField resignFirstResponder];
    } cancelBlock:^{
        textField.text = originalText;
        [textField resignFirstResponder];
    }];
    textField.inputView = calenderView;
    textField.inputAccessoryView = calenderView.accessoryView;
}
- (void)enableXIBDateTime:(UITextField *) textField {
    _datePicker= [[NSBundle mainBundle] loadNibNamed:@"KTSelectPickerView" owner:self options:nil].lastObject;
    [_datePicker.cancleBtn addTarget:self action:@selector(datePickerCancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_datePicker.confirmBtn addTarget:self action:@selector(datePickerConfirmClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_datePicker.datePicker addTarget:self action:@selector(datePickerValueChange:) forControlEvents:UIControlEventValueChanged];
    textField.inputView = _datePicker;
}
#pragma mark -

- (void)datePickerCancelButtonClicked:(UIButton *)sender {
   _inputField.text = nil;
    [_inputField resignFirstResponder];
}

- (void)datePickerConfirmClicked:(UIButton *)sender {
   _inputField.text = [self datePickerTimeString];
    [_inputField resignFirstResponder];
}

//DatePicker值改变
- (void)datePickerValueChange:(id)sender
{
   _inputField.text = [self datePickerTimeString];
}

- (NSString *)datePickerTimeString {
    //先这么玩吧
    NSDate *date = _datePicker.datePicker.date;
    NSDate *newDate = [date dateByAddingTimeInterval:60*60*8];
    NSString *timeString = [[newDate description] componentsSeparatedByString:@"+"][0];
    
    return [timeString substringToIndex:timeString.length-4];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-mm-dd HH:mm:ss"];
    return [formatter stringFromDate:newDate];
}
-(void)setEnableCheckInterger:(BOOL)enableCheckInterger {
    _enableCheckInterger = enableCheckInterger;
    _inputField.keyboardType = UIKeyboardTypeNumberPad;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (self.inputViewSelectedBlock) {
        self.inputViewSelectedBlock(textField);
    }
    
    if (self.enableDateModel) {
        if (self.dateModel == DateModelDate) {
            [self enableXIBCalender:textField];
        }
        if (self.dateModel == DateModelTime) {
            [self enableXIBDateTime:textField];
        }
}

    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ( [_aScrollView isKindOfClass:[UIScrollView class]]) {
        
        _aScrollView.contentOffset = _preOffSet;
    }
}
-(void)setUpViews{
[_bilingView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.bottom.equalTo(self);
    make.right.equalTo(_inputField.mas_left);
    make.width.greaterThanOrEqualTo(@65);
}];
    [_inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_bilingView).offset(-2);
        make.top.equalTo(_bilingView).offset(2);

        make.right.equalTo(self);
        make.left.equalTo(_bilingView.mas_right);
        make.width.greaterThanOrEqualTo(@65);
    }];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"%@ -- %@",NSStringFromRange(range), string);
    if ([string isEqualToString:@"\n"]) {
        [textField endEditing:YES];
        return NO;
    }
    return YES;
}
-(void)setBilingualMode:(BilingualMode)bilingualMode{
    _bilingView.mode = bilingualMode;
}
-(void)setInputText:(NSString *)inputText{
    _inputField.text = inputText;
}
-(NSString *)inputText{
    NSString * text = _inputField.text;
    if ([text isKindOfClass:[NSNull class]] || [text isEqualToString:kEmptyStr]) {
        return kEmptyStr;
    }
    if (self.enableDateModel) {
        
    if (self.dateModel == DateModelTime) {
        return [NSString stringWithFormat:@"%@:00",text];
    }
    if (self.dateModel == DateModelDate ) {
        return [NSString stringWithFormat:@"%@ 00:00:00",text];

    }
    }
    
    return [_inputField.text description];
}
-(void)setPlaceHolder:(NSString *)placeHolder{
    _inputField.placeholder = placeHolder;
}

+(instancetype)new{
    return [[InputBilingualView alloc] init];
}

@end
