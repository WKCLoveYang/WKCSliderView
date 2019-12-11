//
//  WKCSliderView.m
//  ABC
//
//  Created by wkcloveYang on 2019/8/22.
//  Copyright © 2019 wkcloveYang. All rights reserved.
//

#import "WKCSliderView.h"
#import "WKCWeakProxy.h"


@interface WKCSliderView()
{
    CGFloat _startLocationX;
    CGFloat _startValue;
    CGFloat _preferredValue;
    CGFloat _wantProgress;
    
    BOOL _shouldStop;
    BOOL _isDraging;
}

@property (nonatomic, strong) UIImageView * progressImageView;
@property (nonatomic, strong) UIImageView * thmubImageView;
@property (nonatomic, strong) UIImageView * trackImageView;
@property (nonatomic, strong) UIImageView * centerImageView;
@property (nonatomic, strong) UIImageView * progressLabelBgImageView;
@property (nonatomic, strong) UILabel * progressLabel;
@property (nonatomic, strong) CADisplayLink * displayLink;
@property (nonatomic, copy) void(^completionBlock)(void);

@end

@implementation WKCSliderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _sliderSize = CGSizeZero;
        _thumbSize = CGSizeZero;
        _progressLabelSize = CGSizeZero;
        _bottomMagin = 0.0;
        _horizontalMagin = 0.0;
        _cornerRadius = 0.0;
        _progress = 0.0;
        _progressLabelBottomMagin = 2.0;
        
        _progressColor = UIColor.whiteColor;
        _trackColor = UIColor.lightTextColor;
        _centerColor = UIColor.lightGrayColor;
        _thumbColor = UIColor.whiteColor;
        _progressLabelTextColor = UIColor.whiteColor;
        
        _shouldShowProgressLabel = YES;
        _couldDrag = YES;
        _touchMoveAnimate = YES;
        _wantProgress = 0;
        self.animationDutation = 2.0;
        
        
        [self addSubview:self.trackImageView];
        [self addSubview:self.progressImageView];
        [self addSubview:self.centerImageView];
        [self addSubview:self.thmubImageView];
        [self addSubview:self.progressLabelBgImageView];
        [self addSubview:self.progressLabel];
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setupSubviewsFrames];
}

#pragma mark -Lazy
- (UIImageView *)progressImageView
{
    if (!_progressImageView) {
        _progressImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _progressImageView.contentMode = UIViewContentModeScaleAspectFill;
        _progressImageView.layer.cornerRadius = 4.0;
        _progressImageView.layer.masksToBounds = YES;
        _progressImageView.backgroundColor = _progressColor;
    }
    
    return _progressImageView;
}

- (UIImageView *)trackImageView
{
    if (!_trackImageView) {
        _trackImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _trackImageView.contentMode = UIViewContentModeScaleAspectFill;
        _trackImageView.layer.cornerRadius = 4.0;
        _trackImageView.layer.masksToBounds = YES;
        _trackImageView.backgroundColor = _trackColor;
    }
    
    return _trackImageView;
}

- (UIImageView *)centerImageView
{
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _centerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _centerImageView.layer.masksToBounds = YES;
        _centerImageView.backgroundColor = _centerColor;
    }
    
    return _centerImageView;
}

- (UIImageView *)thmubImageView
{
    if (!_thmubImageView) {
        _thmubImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _thmubImageView.contentMode = UIViewContentModeScaleAspectFill;
        _thmubImageView.layer.cornerRadius = 6.0;
        _thmubImageView.layer.masksToBounds = YES;
        _thmubImageView.backgroundColor = _thumbColor;
    }
    
    return _thmubImageView;
}

- (UIImageView *)progressLabelBgImageView
{
    if (!_progressLabelBgImageView) {
        _progressLabelBgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _progressLabelBgImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _progressLabelBgImageView;
}

- (UILabel *)progressLabel
{
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _progressLabel.textColor = _progressLabelTextColor;
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.frame = CGRectZero;
    }
    
    return _progressLabel;
}

#pragma mark -Setter
- (void)setProgressColor:(UIColor *)progressColor
{
    _progressColor = progressColor;
    _progressImageView.backgroundColor = progressColor;
}

- (void)setProgressImage:(UIImage *)progressImage
{
    _progressImage = progressImage;
    _progressImageView.image = progressImage;
}

- (void)setTrackColor:(UIColor *)trackColor
{
    _trackColor = trackColor;
    _trackImageView.backgroundColor = trackColor;
}

- (void)setTrackImage:(UIImage *)trackImage
{
    _trackImage = trackImage;
    _trackImageView.image = trackImage;
}

- (void)setCenterColor:(UIColor *)centerColor
{
    _centerColor = centerColor;
    _centerImageView.backgroundColor = centerColor;
}

- (void)setCenterImage:(UIImage *)centerImage
{
    _centerImage = centerImage;
    _centerImageView.image = centerImage;
}

- (void)setThumbColor:(UIColor *)thumbColor
{
    _thumbColor = thumbColor;
    _thmubImageView.backgroundColor = thumbColor;
}

- (void)setThumbImage:(UIImage *)thumbImage
{
    _thumbImage = thumbImage;
    _thmubImageView.image = thumbImage;
}

- (void)setAlignment:(WKCSliderHorizontalAlignment)alignment
{
    _alignment = alignment;
    [self setupSubviewsFrames];
}

- (void)setHorizontalMagin:(CGFloat)horizontalMagin
{
    _horizontalMagin = horizontalMagin;
    if (_alignment == WKCSliderHorizontalAlignmentCenter) return;
    [self setupSubviewsFrames];
}

- (void)setSliderSize:(CGSize)sliderSize
{
    _sliderSize = sliderSize;
    [self setupSubviewsFrames];
}

- (void)setThumbSize:(CGSize)thumbSize
{
    _thumbSize = thumbSize;
    CGPoint thumbCenter = _thmubImageView.center;
    _thmubImageView.frame = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    _thmubImageView.center = thumbCenter;
}

- (void)setBottomMagin:(CGFloat)bottomMagin
{
    _bottomMagin = bottomMagin;
    [self setupSubviewsFrames];
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    _startValue = progress;
    [self setThumbFrameWithProgress:progress];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sliderViewDidValueChanged:value:)]) {
        [self.delegate sliderViewDidValueChanged:self value:progress];
    }
    
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    _progressImageView.layer.cornerRadius = cornerRadius;
}

- (void)setThumbCornerRadius:(CGFloat)thumbCornerRadius
{
    _thumbCornerRadius = thumbCornerRadius;
    _thmubImageView.layer.cornerRadius = thumbCornerRadius;
}

- (void)setShouldShowProgressLabel:(BOOL)shouldShowProgressLabel
{
    _shouldShowProgressLabel = shouldShowProgressLabel;
    _progressLabel.hidden = !shouldShowProgressLabel;
    _progressLabelBgImageView.hidden = !shouldShowProgressLabel;
}

- (void)setProgressLabelSize:(CGSize)progressLabelSize
{
    _progressLabelSize = progressLabelSize;
    CGFloat maxY = CGRectGetMaxY(_progressLabel.frame);
    CGFloat centerX = _progressLabel.center.x;
    _progressLabel.frame = CGRectMake(0, 0, progressLabelSize.width, progressLabelSize.height);
    _progressLabel.center = CGPointMake(centerX, maxY - progressLabelSize.height / 2.0);
    _progressLabelBgImageView.frame = _progressLabel.frame;
}

- (void)setProgressLabelBottomMagin:(CGFloat)progressLabelBottomMagin
{
    CGFloat changeValue = _progressLabelBottomMagin - progressLabelBottomMagin;
    _progressLabel.frame = CGRectMake(_progressLabel.frame.origin.x, _progressLabel.frame.origin.y + changeValue, _progressLabel.frame.size.width, _progressLabel.frame.size.height);
    _progressLabelBgImageView.frame = _progressLabel.frame;
}

- (void)setProgressLabelFont:(UIFont *)progressLabelFont
{
    _progressLabelFont = progressLabelFont;
    _progressLabel.font = progressLabelFont;
}

- (void)setProgressLabelTextColor:(UIColor *)progressLabelTextColor
{
    _progressLabelTextColor = progressLabelTextColor;
    _progressLabel.textColor = progressLabelTextColor;
}

- (void)setProgressLabelBgColor:(UIColor *)progressLabelBgColor
{
    _progressLabelBgColor = progressLabelBgColor;
    _progressLabel.backgroundColor = progressLabelBgColor;
}

- (void)setProgressLabelBgImage:(UIImage *)progressLabelBgImage
{
    _progressLabelBgImage = progressLabelBgImage;
    _progressLabelBgImageView.image = progressLabelBgImage;
}

- (void)setAnimationDutation:(CGFloat)animationDutation
{
    _animationDutation = animationDutation;
    _preferredValue = 100.0 / (60.0 * animationDutation);
}

#pragma mark -InsideMethod
- (void)actionTap:(UITapGestureRecognizer *)sender
{
    CGPoint movePoint = [sender locationInView:self];
    CGFloat movePointX = movePoint.x - self.thmubImageView.center.x;
    CGFloat width = CGRectGetWidth(self.trackImageView.frame);
    CGFloat scale = movePointX / width;
    CGFloat value = _progress + scale;
    if (value <= 0 ) value = 0;
    if (value >= 1) value = 1;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sliderViewDidTouchUpInside:atValue:)]) {
        [self.delegate sliderViewDidTouchUpInside:self atValue:value];
    }
    
    if (!_couldDrag) return;
    if (_isDraging) return;
    
    [self setProgress:value animated:_touchMoveAnimate];
}

- (void)setupSubviewsFrames
{
    CGRect sliderFrame = [self getSliderFrame];
    
    _trackImageView.frame = sliderFrame;
    _progressImageView.frame = sliderFrame;
    
    CGFloat sliderHeight = CGRectGetHeight(sliderFrame);
    CGFloat centerHeight = sliderHeight - 1.5 * 2;
    _centerImageView.frame = CGRectMake(0, 0, centerHeight, centerHeight);
    _centerImageView.center = _progressImageView.center;
    _centerImageView.layer.cornerRadius = centerHeight / 2.0;
    
    CGSize thumbSize = CGSizeEqualToSize(_thumbSize, CGSizeZero) ? CGSizeMake(12, 12) : _thumbSize;
    _thmubImageView.frame = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    _thmubImageView.center = CGPointMake(0, _progressImageView.center.y);
    
    if (_shouldShowProgressLabel) {
        CGSize progressLabelSize = CGSizeEqualToSize(_progressLabelSize, CGSizeZero) ? CGSizeMake(30, 30) : _progressLabelSize;
        _progressLabel.frame = CGRectMake(0, 0, progressLabelSize.width, progressLabelSize.height);
        _progressLabel.center = CGPointMake(0, _thmubImageView.frame.origin.y - (progressLabelSize.height - _progressLabelBottomMagin));
        _progressLabelBgImageView.frame = _progressLabel.frame;
    }
    
    [self setThumbFrameWithProgress:_progress];
}


- (CGRect)getSliderFrame
{
    CGFloat sliderViewWidth  = CGRectGetWidth(self.frame);
    CGFloat sliderViewHeight = CGRectGetHeight(self.frame);
    CGSize sliderSize = CGSizeEqualToSize(_sliderSize, CGSizeZero) ? CGSizeMake(sliderViewWidth - 30 * 2, 8) : _sliderSize;
    CGFloat y = sliderViewHeight - sliderSize.height - _bottomMagin;
    CGFloat x = 0.0;
    switch (_alignment) {
        case WKCSliderHorizontalAlignmentCenter:
        {
            x = (sliderViewWidth - sliderSize.width) / 2.0;
        }
            break;
            
        case WKCSliderHorizontalAlignmentLeft:
        {
            x = _horizontalMagin;
        }
            break;
            
        case WKCSliderHorizontalAlignmentRight:
        {
            x = sliderViewWidth - _horizontalMagin - sliderSize.width;
        }
            break;
        default:
            break;
    }
    
    return CGRectMake(x, y, sliderSize.width, sliderSize.height);
}

- (void)setThumbFrameWithProgress:(CGFloat)progress
{
    CGFloat sliderWidth = CGRectGetWidth(_trackImageView.frame);
    CGFloat progressImageWidth = sliderWidth * progress;
    CGFloat thumbCenterX = progressImageWidth + _trackImageView.frame.origin.x;
    
    _progressImageView.frame = CGRectMake(_progressImageView.frame.origin.x, _progressImageView.frame.origin.y, progressImageWidth, _progressImageView.frame.size.height);
    
    _thmubImageView.center = CGPointMake(thumbCenterX, _thmubImageView.center.y);
    
    if (_shouldShowProgressLabel) {
        _progressLabel.hidden = NO;
        _progressLabel.layer.opacity = 1.0;
        _progressLabel.center = CGPointMake(thumbCenterX, _progressLabel.center.y);
        _progressLabel.text = [NSString stringWithFormat:@"%.f", progress * 100];
        
        _progressLabelBgImageView.hidden = NO;
        _progressLabelBgImageView.layer.opacity = 1.0;
        _progressLabel.center = _progressLabel.center;
    }
}



#pragma mark -Touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_couldDrag) return;

    CGPoint startPoint = [touches.allObjects.lastObject locationInView:self];
    _startLocationX = startPoint.x;
    _startValue = _progress;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sliderViewDidStartChange:value:)]) {
        [self.delegate sliderViewDidStartChange:self value:_progress];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_couldDrag) return;
    _isDraging = YES;

    CGPoint movePoint = [touches.allObjects.lastObject locationInView:self];
    CGFloat movePointX = movePoint.x - _startLocationX;
    CGFloat width = CGRectGetWidth(_trackImageView.frame);
    CGFloat scale = movePointX / width;
    CGFloat value = _startValue + scale;
    if (value <= 0 ) value = 0;
    if (value >= 1) value = 1;
    _progress = value;
    
    [self setThumbFrameWithProgress:value];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sliderViewDidValueChanged:value:)]) {
        [self.delegate sliderViewDidValueChanged:self value:value];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_couldDrag) return;
    _isDraging = NO;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sliderViewDidEndChange:value:)]) {
        [self.delegate sliderViewDidEndChange:self value:_progress];
    }
    
    [self autoDimissProgressLabel];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _isDraging = NO;
}

- (void)autoDimissProgressLabel
{
    if (!_shouldShowProgressLabel) return;
    [UIView animateWithDuration:0.3f delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.progressLabel.layer.opacity = 0.0;
        self.progressLabelBgImageView.layer.opacity = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            self.progressLabel.hidden = YES;
            self.progressLabelBgImageView.hidden = YES;
        }
    }];
}

#pragma mark -OutsideMethod
- (void)setProgress:(CGFloat)progress
           animated:(BOOL)animated
{
    [self setProgress:progress
             animated:animated
       completeHandle:nil];
}

- (void)setProgress:(CGFloat)progress
           animated:(BOOL)animated
     completeHandle:(void(^)(void))handle
{
    [self setProgress:progress
             animated:animated
                delay:0.0
       completeHandle:handle];
}

- (void)setProgress:(CGFloat)progress
           animated:(BOOL)animated
              delay:(CGFloat)delay
     completeHandle:(void(^)(void))handle
{
    if (animated) {
        _wantProgress = progress;
        _preferredValue = progress > self.progress ? fabs(_preferredValue) : -fabs(_preferredValue);
        self.completionBlock = handle;
        [self performSelector:@selector(startAnimation)
                   withObject:nil
                   afterDelay:delay];
    } else {
        self.progress = progress;
    }
}

- (void)startAnimation
{
    _shouldStop = NO;
    [_displayLink invalidate];
    _displayLink = nil;
    _displayLink = [CADisplayLink displayLinkWithTarget:[WKCWeakProxy proxyWithTarget:self] selector:@selector(displayAnimation:)];
    _displayLink.preferredFramesPerSecond = 60;
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                       forMode:NSRunLoopCommonModes];
}

- (void)displayAnimation:(CADisplayLink *)sender
{
    CGFloat stepValue = self.progress;
    stepValue += (_preferredValue / 100.0);
    if (stepValue >= 1.0) stepValue = 1.0;
    if (stepValue <= 0.0) stepValue = 0.0;
    self.progress = stepValue;
    
    // 判断结束
    // 在递减
    if (_preferredValue < 0) {
        if (self.progress <= _wantProgress) {
            self.progress = _wantProgress;
            [sender invalidate];
            sender = nil;
            if (self.completionBlock && !_shouldStop) {
                self.completionBlock();
            }
        }
    } else {
        // 在递加
        if (self.progress >= _wantProgress) {
            self.progress = _wantProgress;
            [sender invalidate];
            sender = nil;
            if (self.completionBlock && !_shouldStop) {
                self.completionBlock();
            }
        }
    }
}


- (void)stopProgressAnimation
{
    _shouldStop = YES;
    [_displayLink invalidate];
    _displayLink = nil;
}

@end
