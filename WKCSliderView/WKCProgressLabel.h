//
//  WKCProgressLabel.h
//  Demo
//
//  Created by wkcloveYang on 2019/11/12.
//  Copyright © 2019 wkcloveYang. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WKCProgressLabel;

@protocol WKCProgressLabelDelegate <NSObject>

@optional

/// 值改变
/// @param progressLabel 当前视图
/// @param value 值
- (void)wkcProgressLabel:(WKCProgressLabel *)progressLabel valueChanged:(CGFloat)value;

/// 将要开始
/// @param progressLabel 当前视图
- (void)wkcProgressLabelWillStartProgress:(WKCProgressLabel *)progressLabel;

/// 将要结束
/// @param progressLabel 当前视图
- (void)wkcProgressLabelWillStopProgress:(WKCProgressLabel *)progressLabel;

/// 已经结束
/// @param progressLabel 当前视图
- (void)wkcProgressLabelDidStopedProgress:(WKCProgressLabel *)progressLabel;

@end

/// 值显示类型
typedef NS_ENUM(NSInteger, WKCProgressLabelValueType) {
    WKCProgressLabelValueTypePercent = 0, // 按百分比显示
    WKCProgressLabelValueTypeFloat1  = 1, // 小数保留小数点后一位
    WKCProgressLabelValueTypeFloat2  = 2  // 小数保留小数点后两位
};

@interface WKCProgressLabel : UILabel

@property (nonatomic, weak) id<WKCProgressLabelDelegate> delegate;
@property (nonatomic, assign) WKCProgressLabelValueType valueType;

/// 开始动画
- (void)startProgress;

/// 结束动画, 会跑完
- (void)stopProgress;

/// 完全结束动画, 不管跑没跑完
- (void)invalidatePorgress;

/// 自定义持续时间
/// @param duration duration
- (void)setProgressAnimationDuration:(CGFloat)duration;

@end

