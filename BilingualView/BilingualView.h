//
//  BilingualView.h
//  TLB
//
//  Created by 李雨龙 on 16/1/20.
//  Copyright © 2016年 杰之能. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,BilingualMode) {
    BilingualModeVertical = 0,
    BilingualModeHorizontal = 1,
    BilingualModeDefault = BilingualModeVertical
};
@interface BilingualView : UIView
{
    UILabel * _cnView;
    UILabel * _enView;
}
-(instancetype)initCnTitle:(NSString *) title enTitle:(NSString *) enTitle;
@property(assign, nonatomic) BilingualMode mode;
@property(copy, nonatomic) NSString * enTitle;
@property(copy, nonatomic) NSString * cnTitle;

@property(copy, nonatomic) UIColor  * titleTextColor;
@property(copy, nonatomic) UIColor * enColor;
@property(copy, nonatomic) UIColor * cnColor;
@property(copy , nonatomic) UIFont * enFont;
@property(copy , nonatomic) UIFont * cnFont;

@end
