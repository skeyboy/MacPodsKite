//
//  InputBilingualView.h
//  TLB
//
//  Created by 李雨龙 on 16/1/25.
//  Copyright © 2016年 杰之能. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BilingualView.h"
#import "SelectDateCalenderView.h"
#import "KTSelectPickerView.h"
typedef NS_ENUM(NSInteger,DateModel) {
DateModelDate,
    DateModelTime
};
@interface InputBilingualView : UIView<UITextFieldDelegate>
{
    BilingualView * _bilingView;
    UITextField * _inputField;
    CGPoint _preOffSet;
    UIScrollView * _aScrollView;
    KTSelectPickerView * _datePicker;
}

@property(readwrite, nonatomic) BilingualView *bilingView;
@property(assign, nonatomic) BilingualMode bilingualMode;
@property(assign, nonatomic) BOOL canEdite;
@property(assign, nonatomic) BOOL endEdite;
@property(readwrite, nonatomic) NSString * inputText;
@property(copy, nonatomic) NSString * placeHolder;
@property(assign, nonatomic) BOOL enableDateModel;
@property(assign, nonatomic) BOOL enableCheckInterger;
@property(assign, nonatomic) DateModel dateModel;

@property(copy, nonatomic) void(^inputViewSelectedBlock)(UITextField * textField);
@end
