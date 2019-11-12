//
//  WKCPorgressView.m
//  Demo
//
//  Created by wkcloveYang on 2019/11/12.
//  Copyright © 2019 wkcloveYang. All rights reserved.
//

#import "WKCProgressView.h"
#import "WKCWeakProxy.h"

@interface WKCProgressView ()

@property (nonatomic, assign) NSInteger percent;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) CADisplayLink *loadingDisplayLink;

@end

@implementation WKCProgressView

- (void)startProgress
{
    self.index = 0;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(wkcProgressViewWillStartProgress:)]) {
        [self.delegate wkcProgressViewWillStartProgress:self];
    }

    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:[WKCWeakProxy proxyWithTarget:self] selector:@selector(didProgressStep:)];
    displayLink.preferredFramesPerSecond = 10;// 每秒10帧
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    self.loadingDisplayLink = displayLink;
}

- (void)didProgressStep:(CADisplayLink *)sender
{
    self.percent = [self getCurrentPercent:self.index];
    self.index += 1;
}

- (void)stopProgress
{
    [self.loadingDisplayLink invalidate];
    self.loadingDisplayLink = nil;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(wkcProgressViewWillStopProgress:)]) {
        [self.delegate wkcProgressViewWillStopProgress:self];
    }
    
    self.index = 0;
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:[WKCWeakProxy proxyWithTarget:self] selector:@selector(didProgressCompletion:)];
    displayLink.preferredFramesPerSecond = 20;// 每秒10帧
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.loadingDisplayLink = displayLink;
}

- (void)didProgressCompletion:(CADisplayLink *)sender
{
    self.index += 1;
    
    if (self.index <= 20) {
        // 1 秒之内跑完剩下的进度到100%
        self.percent = (NSInteger)(self.percent + ((100-self.percent)*self.index/20.0));
    }
    
    if (self.index >= 24) { // 到100%之后停留0.2秒结束
        [sender invalidate];
        sender = nil;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(wkcProgressViewDidStopedProgress:)]) {
            [self.delegate wkcProgressViewDidStopedProgress:self];
        }
    }
}


- (NSInteger)getCurrentPercent:(NSInteger)index
{
    if (index <= 0) {
        return 0;
    } else if (index < 50) {
        return (NSInteger)(100.0*(1.0-50.0/(index+50))); // 5秒内，0 - 50 刚开始快，后面减速到达50
    } else if (index < 100) {
        return (NSInteger)(20.0*(index-50)/50+50); // 5-10秒，50 - 70 匀速
    } else if (index < 200) {
        return (NSInteger)(20.0*(index-100)/100+70); // 10-20秒，70 - 90 匀速
    } else if (index < 600) {
        return (NSInteger)(9*(index-200)/400+90); // 20-60秒，90 - 99 匀速
    }
    return 99;
}


- (void)setProgressAnimationDuration:(CGFloat)duration
{
    [self startProgress];
    
    [self performSelector:@selector(stopProgress)
               withObject:nil
               afterDelay:(duration - 0.5)];
}

#pragma mark -Setter
- (void)setPercent:(NSInteger)percent
{
    _percent = percent;
    
    CGFloat value = percent * 1.0 / 100.0;
    self.progress = value;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(wkcProgressView:valueChanged:)]) {
        [self.delegate wkcProgressView:self valueChanged:value];
    }
}

@end
