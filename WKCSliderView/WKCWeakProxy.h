//
//  WKCWeakProxy.h
//  Demo
//
//  Created by wkcloveYang on 2019/11/12.
//  Copyright © 2019 wkcloveYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKCWeakProxy : NSProxy <NSObject>

@property (nonatomic, weak, readonly) id target;

- (instancetype)initWithTarget:(id)target;

+ (instancetype)proxyWithTarget:(id)target;

@end
