//
//  ViewController.m
//  Demo
//
//  Created by wkcloveYang on 2019/8/22.
//  Copyright © 2019 wkcloveYang. All rights reserved.
//

#import "ViewController.h"
#import <WKCSliderView.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.blueColor;
    
    WKCSliderView * sliderView = [[WKCSliderView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:sliderView];
    
    sliderView.bottomMagin = 200;
    sliderView.progress = 0.5;
}


@end
