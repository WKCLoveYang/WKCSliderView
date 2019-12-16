//
//  WKCLoadingView.m
//  WKCTTTT
//
//  Created by wkcloveYang on 2019/12/16.
//  Copyright © 2019 wkcloveYang. All rights reserved.
//

#import "WKCLoadingView.h"
#import "WKCProgressLabel.h"

@interface WKCLoadingView()
<WKCProgressLabelDelegate>

@property (nonatomic, strong) WKCProgressLabel * progressLabel;

@end

@implementation WKCLoadingView


- (void)startLoading
{
    [self.progressLabel startProgress];
}

- (void)stopLoading
{
    [self.progressLabel stopProgress];
}

- (void)invalidateLoading
{
    [self.progressLabel invalidatePorgress];
}


#pragma mark -Lazy
- (WKCProgressLabel *)progressLabel
{
    if (!_progressLabel) {
        _progressLabel = [[WKCProgressLabel alloc] init];
        _progressLabel.delegate = self;
    }
    
    return _progressLabel;
}


#pragma mark -WKCProgressLabelDelegate
- (void)wkcProgressLabel:(WKCProgressLabel *)progressLabel valueChanged:(CGFloat)value
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wkcLoadingView:valueChanged:)]) {
        [self.delegate wkcLoadingView:self valueChanged:value];
    }
}

- (void)wkcProgressLabelWillStartProgress:(WKCProgressLabel *)progressLabel
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wkcProgressLabelWillStartProgress:)]) {
        [self.delegate wkcLoadingViewWillStartProgress:self];
    }
}

- (void)wkcProgressLabelWillStopProgress:(WKCProgressLabel *)progressLabel
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wkcProgressLabelWillStopProgress:)]) {
        [self.delegate wkcLoadingViewWillStopProgress:self];
    }
}

- (void)wkcProgressLabelDidStopedProgress:(WKCProgressLabel *)progressLabel
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wkcLoadingViewDidStopedProgress:)]) {
        [self.delegate wkcLoadingViewDidStopedProgress:self];
    }
}

@end
