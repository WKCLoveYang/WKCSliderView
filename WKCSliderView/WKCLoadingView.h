//
//  WKCLoadingView.h
//  WKCTTTT
//
//  Created by wkcloveYang on 2019/12/16.
//  Copyright © 2019 wkcloveYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WKCLoadingView;

@protocol WKCLoadingViewDelegate <NSObject>

@optional
/// 值改变
/// @param loadingView 当前视图
/// @param value 值
- (void)wkcLoadingView:(WKCLoadingView *)loadingView valueChanged:(CGFloat)value;

/// 将要开始
/// @param loadingView 当前视图
- (void)wkcLoadingViewWillStartProgress:(WKCLoadingView *)loadingView;

/// 将要结束
/// @param loadingView 当前视图
- (void)wkcLoadingViewWillStopProgress:(WKCLoadingView *)loadingView;

/// 已经结束
/// @param loadingView 当前视图
- (void)wkcLoadingViewDidStopedProgress:(WKCLoadingView *)loadingView;

@end


// 自定义loadingView继承此视图完善界面
@interface WKCLoadingView : UIView

@property (nonatomic, weak) id<WKCLoadingViewDelegate> delegate;

/// 开始动画
- (void)startLoading;

/// 结束动画, 会跑完
- (void)stopLoading;

/// 完全结束动画, 不管跑没跑完
- (void)invalidateLoading;

@end

