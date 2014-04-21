//
//  UIXStopButton.m
//  UIXKiy
//
//  Created by 汪潇翔 on 14-4-21.
//  Copyright (c) 2014年 JiaYuan. All rights reserved.
//

#import "UIXStopButton.h"
#import "UIXHelper.h"


@interface UIXStopButton()

@property(nonatomic,readwrite,weak) CAShapeLayer* shapeLayer;

@end


#pragma mark - UIXStopButton implementation
@implementation UIXStopButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initialize];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self _initialize];
    }
    return self;
}
-(CGRect)frameThatFits:(CGRect)frame
{
    CGFloat sizeValue = MIN(frame.size.width, frame.size.height);
    CGSize viewSize = CGSizeMake(sizeValue, sizeValue);
    const CGFloat sizeRatio = 0.35f;
    return CGRectInset(UIXCenterCGSizeInCGRect(viewSize, frame),
                       sizeValue*sizeRatio, sizeRatio*sizeValue);
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.bounds;
    if (self.tracking && self.touchInside) {
        const CGFloat insetSizeRatio  = 0.033;
        frame = CGRectInset(frame, frame.size.width*insetSizeRatio, frame.size.height*insetSizeRatio);
    }
    self.shapeLayer.frame = frame;
}
-(void)tintColorDidChange
{
    [super tintColorDidChange];
    self.shapeLayer.backgroundColor = self.tintColor.CGColor;
}
#pragma mark -  private
//MARK:初始化
-(void)_initialize
{
    CAShapeLayer* shapLayer = [CAShapeLayer new];
    [self.layer addSublayer:shapLayer];
    self.shapeLayer = shapLayer;
    
    [self addTarget:self action:@selector(_didTouchDown) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(_didTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - Event
-(void)_didTouchDown
{
//    NSLog(@"_didTouchDown");
    [UIView animateWithDuration:0.1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self layoutSubviews];
                     }
                     completion:nil];
}
-(void)_didTouchUpInside{
//    NSLog(@"_didTouchUpInside");
    [UIView animateWithDuration:0.2
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self layoutSubviews];
                     }
                     completion:nil];
}
@end
