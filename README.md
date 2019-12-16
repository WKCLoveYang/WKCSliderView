# WKCSliderView

自定义滑块

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) [![CocoaPods compatible](https://img.shields.io/cocoapods/v/WKCSliderView?style=flat)](https://cocoapods.org/pods/WKCSliderView) [![License: MIT](https://img.shields.io/cocoapods/l/WKCSliderView?style=flat)](http://opensource.org/licenses/MIT)



WKCSliderView 适用于对滑动范围要求比较大的情况.
例如: WKCSliderView * sliderView = [[WKCSliderView alloc] initWithFrame:UIScreen.mainScreen.bounds];
此时,整个屏幕内滑动,sliderView都会响应.即:sliderView的响应范围与其frame有关.
注:WKCSliderView的frame并不是progress部分的坐标, 后者需要单独设置.

# 属性列表

| 属性  |   含义 |
| ----   |  ----   |
| delegate | 代理,处理值改变、滑动结束等回调事件|
| progressHandle | 值改变block回调, 与代理不冲突 |
| alignment | 水平对齐方式 |
| horizontalMagin | 水平非居中时的边距 |
| sliderSize | slider大小 |
| thumbSize | 滑块大小 |
| bottomMagin | 滑动条距底部间距 |
| progress | 设定初始值或者获取滑动变化后的值 |
| progressColor | 进度部分颜色 |
| trackColor | 未进度部分颜色 |
| thumbColor | 滑块颜色 |
| centerColor | 中心点颜色 | 
| progressImage | 进度部分图片 |
| trackImage | 未进度部分图片 |
| thumbImage | 滑块图片 |
| centerImage | 中心点图片 |
| cornerRadius | 进度条圆角 |
| thumbCornerRadius | 滑块圆角 |
| shouldShowProgressLabel | 是否显示进度Label, 默认YES |
| progressLabelSize | 进度label大小 |
| progressLabelBottomMagin | 进度label与thumb间距 |
| progressLabelBgImage | 进度Label背景图 |
| progressLabelBgColor | 进度Label背景颜色 |
| progressLabelFont | 进度Label字体 |
| progressLabelTextColor | 进度Label字颜色 |

