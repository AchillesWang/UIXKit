//
//  UIXActivityIndicatorView.h
//  UIXKiy
//
//  Created by 汪潇翔 on 14-4-21.
//  Copyright (c) 2014年 JiaYuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIXStopableView.h"

@interface UIXActivityIndicatorView : UIView<UIXStopableView>
{
    @package
    BOOL _isAnimating;
}
@property(nonatomic) CGFloat lineWidth UI_APPEARANCE_SELECTOR;

@property(nonatomic) BOOL    hideWhenStoped;

-(void)startAnimating;

-(void)stopAnimating;

-(BOOL)isAnimating;

@end
