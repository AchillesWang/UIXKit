//
//  UIXStopableView.h
//  UIXKiy
//
//  Created by 汪潇翔 on 14-4-21.
//  Copyright (c) 2014年 JiaYuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIXButton.h"
@protocol UIXStopableView <NSObject>
/**
 *  是否可以停止
 */
@property(nonatomic,assign) BOOL mayStop;
/**
 *  停止按钮
 */
@property(nonatomic,readonly,weak) UIXButton* stopButton;
@end
