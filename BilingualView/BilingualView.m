//
//  BilingualView.m
//  TLB
//
//  Created by 李雨龙 on 16/1/20.
//  Copyright © 2016年 杰之能. All rights reserved.
//

#import "BilingualView.h"
#import "Masonry.h"
@implementation BilingualView

-(void)awakeFromNib{
    _cnView = [UILabel new];
    _enView = [UILabel new];
    
    _cnView.numberOfLines = 0;
    _enView.numberOfLines = 0;
    
    [self addSubview:_cnView];
    [self addSubview:_enView];
   
    [_enView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        make.width.greaterThanOrEqualTo(@75);
        make.top.equalTo(self).offset(5);
        make.height.greaterThanOrEqualTo(@0);
        make.bottom.equalTo(_cnView.mas_top);
        
    }];
    
    [_cnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_enView.mas_bottom);
        make.leading.and.trailing.equalTo(self);
        make.height.greaterThanOrEqualTo(@0);
        make.width.greaterThanOrEqualTo(@75);
        make.bottom.equalTo(self).offset(-5);
    } ];
}
-(void)setMode:(BilingualMode)mode{
    if (_mode == mode) {
        return;
    }
    switch (mode) {
        case BilingualModeHorizontal:
        {
            return;
            [_enView removeFromSuperview];
            [_cnView removeFromSuperview];
            
            
        [ _enView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                make.right.equalTo(_cnView.mas_left);
                make.width.lessThanOrEqualTo(@150);
                make.top.equalTo(self);
                make.bottom.equalTo(self);
        }];
            [_cnView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_enView.mas_right);
                make.top.and.bottom.equalTo(self);
                make.trailing.equalTo(self);
                make.width.lessThanOrEqualTo(@150);
            }];
            
        }
            break;
        case BilingualModeVertical:
            
        default:
            break;
    }
}
+(instancetype)new{
    return [[BilingualView alloc] init];
}
-(instancetype)init{
    return [self initCnTitle:@"" enTitle:@""];
}
-(instancetype)initCnTitle:(NSString *)title enTitle:(NSString *)enTitle{
    if (self = [super init]) {
        [self awakeFromNib];
        _cnView.text = title;
        _enView.text = enTitle;
    }
    
    return self;
}
-(void)setEnTitle:(NSString *)enTitle{
    _enView.text = enTitle;
}
-(void)setCnTitle:(NSString *)cnTitle{
    _cnView.text = cnTitle;
}
-(void)setEnFont:(UIFont *)enFont{
    _enView.font = enFont;
}
-(void)setCnFont:(UIFont *)enFont{
    _cnView.font = enFont;
}
-(void)setEnColor:(UIColor *)enColor{
    _enView.textColor = enColor;
}
-(void)setCnColor:(UIColor *)cnColor{
    _cnView.textColor = cnColor;
}
-(void)setTitleTextColor:(UIColor *)titleTextColor{
    [self setEnColor:titleTextColor];
    [self setCnColor:titleTextColor];
}
@end
