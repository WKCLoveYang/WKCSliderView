//
//  WKCSliderView.h
//  ABC
//
//  Created by wkcloveYang on 2019/8/22.
//  Copyright © 2019 wkcloveYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WKCSliderView;

@protocol WKCSliderViewDelegate <NSObject>

@optional

/**
  点击了sliderView
  @param sliderView 当前对象
 */
- (void)sliderViewDidTouchUpInside:(WKCSliderView *)sliderView;

/**
  值开始改变
  @param sliderView 当前对象
  @param value 初始值
 */
- (void)sliderViewDidStartChange:(WKCSliderView *)sliderView
                           value:(CGFloat)value;

/**
 值变化了
 @param sliderView 当前对象
 @param value 变化值
 */
- (void)sliderViewDidValueChanged:(WKCSliderView *)sliderView
                            value:(CGFloat)value;

/**
 值停止改变了
 @param sliderView 当前对象
 @param value 结束值
 */
- (void)sliderViewDidEndChange:(WKCSliderView *)sliderView
                         value:(CGFloat)value;

@end

typedef void(^WKCSliderBlock)(void);
typedef void(^WKCSliderValueBlock)(CGFloat progress);

/**
  进度条水平对齐方式
  @enum WKCSliderHorizontalAlignmentCenter 中心对齐
  @enum WKCSliderHorizontalAlignmentLeft 左对齐
  @enum WKCSliderHorizontalAlignmentRight 右对齐
 */
typedef NS_ENUM(NSInteger, WKCSliderHorizontalAlignment) {
    WKCSliderHorizontalAlignmentCenter = 0,
    WKCSliderHorizontalAlignmentLeft   = 1,
    WKCSliderHorizontalAlignmentRight  = 2
};

/**
   WKCSliderView 适用于对滑动范围要求比较大的情况
 例如: WKCSliderView * sliderView = [[WKCSliderView alloc] initWithFrame:UIScreen.mainScreen.bounds];
 此时,整个屏幕内滑动,sliderView都会响应.即:sliderView的响应范围与其frame有关.
 注:WKCSliderView的frame并不是progress部分的坐标, 后者需要单独设置.
 */

@interface WKCSliderView : UIView

/**
  代理
 */
@property (nonatomic, weak) id<WKCSliderViewDelegate> delegate;

/**
  进度回调(与代理不冲突, 两者都回调)
 */
@property (nonatomic, copy) WKCSliderValueBlock progressHandle;

/**
  水平对齐方式, 默认居中
  左对齐或者右对齐时,horizontalMagin有效
 */
@property (nonatomic, assign) WKCSliderHorizontalAlignment alignment;

/**
  水平非中心对齐时的间距
 */
@property (nonatomic, assign) CGFloat horizontalMagin;

/**
  slider大小
 */
@property (nonatomic, assign) CGSize sliderSize;

/**
  滑块大小
 */
@property (nonatomic, assign) CGSize thumbSize;

/**
  滑动条距底部间距
 */
@property (nonatomic, assign) CGFloat bottomMagin;


/**
 设定初始值或者获取滑动变化后的值
 */
@property (nonatomic, assign) CGFloat progress;

/**
  进度部分颜色
 */
@property (nonatomic, strong) UIColor * progressColor;

/**
  未进度部分颜色
 */
@property (nonatomic, strong) UIColor * trackColor;

/**
  滑块颜色
 */
@property (nonatomic, strong) UIColor * thumbColor;

/**
  中心点颜色
 */
@property (nonatomic, strong) UIColor * centerColor;

/**
  进度部分图片
 */
@property (nonatomic, strong) UIImage * progressImage;

/**
  未进度部分图片
 */
@property (nonatomic, strong) UIImage * trackImage;

/**
  滑块图片
 */
@property (nonatomic, strong) UIImage * thumbImage;

/**
 中心点图片
 */
@property (nonatomic, strong) UIImage * centerImage;


/**
  进度条圆角
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
  滑块圆角
 */
@property (nonatomic, assign) CGFloat thumbCornerRadius;

/**
  是否显示进度Label, 默认YES
 */
@property (nonatomic, assign) BOOL shouldShowProgressLabel;

/**
  进度label大小
 */
@property (nonatomic, assign) CGSize progressLabelSize;

/**
 进度label与thumb间距
 */
@property (nonatomic, assign) CGFloat progressLabelBottomMagin;


/**
  进度Label背景图
 */
@property (nonatomic, strong) UIImage * progressLabelBgImage;

/**
 进度Label背景颜色
 */
@property (nonatomic, strong) UIColor * progressLabelBgColor;

/**
 进度Label字体
 */
@property (nonatomic, strong) UIFont * progressLabelFont;

/**
 进度Label字颜色
 */
@property (nonatomic, strong) UIColor * progressLabelTextColor;


// 控件对象外放, 以便有阴影等内容
@property (nonatomic, strong, readonly) UIImageView * progressImageView;
@property (nonatomic, strong, readonly) UIImageView * thmubImageView;
@property (nonatomic, strong, readonly) UIImageView * trackImageView;
@property (nonatomic, strong, readonly) UIImageView * centerImageView;
@property (nonatomic, strong, readonly) UILabel * progressLabel;




/**
  显示动画(并且不需要同步处理动画和结果回调)
 */
- (void)show;

/**
 显示动画(需要同步处理动画和结果回调)
 @param animation  动画块
 @param completion 结果回调
 */
- (void)showWithAnimation:(WKCSliderBlock)animation
               completion:(WKCSliderBlock)completion;

/**
 消失动画(并且不需要同步处理动画和结果回调)
 */
- (void)dismiss;

/**
 消失动画(需要同步处理动画和结果回调)
 @param animation  动画块
 @param completion 结果回调
 */
- (void)dismissWithAnimation:(WKCSliderBlock)animation
                  completion:(WKCSliderBlock)completion;

@end
