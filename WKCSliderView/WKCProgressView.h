//
//  WKCPorgressView.h
//  Demo
//
//  Created by wkcloveYang on 2019/11/12.
//  Copyright © 2019 wkcloveYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WKCProgressView;

@protocol WKCProgressViewDelegate <NSObject>

@optional

/// 值改变
/// @param progressView 当前视图
/// @param value 值
- (void)wkcProgressView:(WKCProgressView *)progressView valueChanged:(CGFloat)value;

/// 将要开始
/// @param progressView 当前视图
- (void)wkcProgressViewWillStartProgress:(WKCProgressView *)progressView;

/// 将要结束
/// @param progressView 当前视图
- (void)wkcProgressViewWillStopProgress:(WKCProgressView *)progressView;

/// 已经结束
/// @param progressView 当前视图
- (void)wkcProgressViewDidStopedProgress:(WKCProgressView *)progressView;

@end


@interface WKCProgressView : UIProgressView

@property (nonatomic, weak) id<WKCProgressViewDelegate> delegate;

/// 开始动画
- (void)startProgress;

/// 结束动画
- (void)stopProgress;

/// 自定义持续时间
/// @param duration duration
- (void)setProgressAnimationDuration:(CGFloat)duration;

@end

