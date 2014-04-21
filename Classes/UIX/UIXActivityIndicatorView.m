//
//  UIXActivityIndicatorView.m
//  UIXKiy
//
//  Created by 汪潇翔 on 14-4-21.
//  Copyright (c) 2014年 JiaYuan. All rights reserved.
//

#import "UIXActivityIndicatorView.h"
#import "UIXStopButton.h"


 NSString *const UIXActivityIndicatorViewSpinAnimationKey = @"UIXActivityIndicatorViewSpinAnimationKey";


@interface UIXActivityIndicatorView ()

@property (nonatomic,weak) CAShapeLayer* shapeLayer;

@property (nonatomic,weak) CAShapeLayer* backgroundLayer;

@property (nonatomic,weak,readwrite) UIXStopButton* stopButton;

@end
#pragma mark - UIXActivityIndicatorView implementation
@implementation UIXActivityIndicatorView
@synthesize stopButton = _stopButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initialize];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
//        NSLog(@"初始化...initWithCoder");
        [self _initialize];
    }
    return self;
}
- (void)dealloc
{
    [self _unregisterFromNotificationCenter];
}
//MARK:初始化
-(void)_initialize
{
//    NSLog(@"初始化..._initialize");
    self.hideWhenStoped = YES;
    CAShapeLayer* shapeLayer= [CAShapeLayer new];
    shapeLayer.borderWidth =0;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:shapeLayer];
    self.shapeLayer = shapeLayer;
    
    CAShapeLayer* backgroudLayer = [CAShapeLayer new];
    backgroudLayer.borderWidth = 0;
    backgroudLayer.lineWidth = 2.0f;
    backgroudLayer.strokeColor = [UIColor colorWithWhite:0.3 alpha:0.3].CGColor;
    backgroudLayer.fillColor =[UIColor clearColor].CGColor;
    [self.layer addSublayer:backgroudLayer];
    self.backgroundLayer = backgroudLayer;
    
    UIXStopButton* stopButton = [UIXStopButton new];
    [self addSubview:stopButton];
    self.stopButton = stopButton;
    self.mayStop = NO;
//    NSLog(@"%@,%@",NSStringFromCGRect(shapeLayer.frame),stopButton);
//    NSLog(@"%@",NSStringFromCGRect(self.bounds));
}
#pragma mark - Notification
//MARK:注册通知
-(void)_registerForNotificationCenter
{
    NSNotificationCenter* center = NSNotificationCenter.defaultCenter;
    [center addObserver:self
               selector:@selector(_applicationDidEnterBackground:)
                   name:UIApplicationDidEnterBackgroundNotification
                 object:nil];
    [center addObserver:self
               selector:@selector(_applicationWillEnterForeground:)
                   name:UIApplicationWillEnterForegroundNotification
                 object:nil];
}
//MARK:删除监听者
-(void)_unregisterFromNotificationCenter
{
    NSNotificationCenter* center = NSNotificationCenter.defaultCenter;
    [center removeObserver:self];
}
//MARK:应用程序进入后台
-(void)_applicationDidEnterBackground:(NSNotificationCenter *)note
{
    [self _removeAnimation];
}
//MARK:应用程序进入前台
-(void)_applicationWillEnterForeground:(NSNotificationCenter *)note
{
    if (self.isAnimating) {
        [self _addAnimation];
    }
}
#pragma mark - Layout
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.bounds;
    if (frame.size.width != frame.size.height) {
        CGFloat s  = MIN(frame.size.width, frame.size.height);
        frame.size.width = s;
        frame.size.height = s;
    }
    self.shapeLayer.frame = frame;
    self.shapeLayer.path = [self _layoutPath:0.2].CGPath;
    self.backgroundLayer.frame = frame;
    self.backgroundLayer.path = [self _layoutPath:1.0].CGPath;
    self.stopButton.frame = [self.stopButton frameThatFits:self.bounds];
}
//MARK:获得路径
-(UIBezierPath*)_layoutPath:(CGFloat)angle
{
    const double TWO_M_PI = 2.0*M_PI;
    double startAngle = 0.75* TWO_M_PI;
    double endAngle = startAngle +TWO_M_PI*angle;
    CGFloat width = self.bounds.size.width;
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2.0, width/2.0)
                                          radius:width/2.0
                                      startAngle:startAngle
                                        endAngle:endAngle
                                       clockwise:YES];
}
#pragma mark - Hook tintColor
-(void)tintColorDidChange
{
    [super tintColorDidChange];
    self.shapeLayer.strokeColor = self.tintColor.CGColor;
    self.stopButton.tintColor = self.tintColor;
}
#pragma mark - Line width
-(void)setLineWidth:(CGFloat)lineWidth
{
    self.shapeLayer.lineWidth = lineWidth;
}
-(CGFloat)lineWidth
{
    return  self.shapeLayer.lineWidth;
}
#pragma mark - UIXStopButton's implementation
-(void)setMayStop:(BOOL)mayStop
{
    self.stopButton.hidden = !mayStop;
}
-(BOOL)mayStop
{
    return !self.stopButton.hidden;
}
#pragma mark - Control animation
//MARK:开始动画
-(void)startAnimating
{
    //是否开始动画
    if (_isAnimating) {
        return;
    }
    _isAnimating = YES;
    [self _registerForNotificationCenter];
    [self _addAnimation];
    if (self.hideWhenStoped) {
        self.hidden = NO;
    }
}
//MARK:结束动画
-(void)stopAnimating
{
    if (!_isAnimating) {
        return;
    }
    _isAnimating = NO;
    [self _unregisterFromNotificationCenter];
    [self _removeAnimation];
    if (self.hideWhenStoped) {
        self.hidden = YES;
    }
}
//MARK:是否开始动画
-(BOOL)isAnimating
{
    return _isAnimating;
}
#pragma mark - Private



//MARK:添加动画
-(void)_addAnimation{
    CABasicAnimation* spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    spinAnimation.toValue = @(1*2*M_PI);
    spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    spinAnimation.duration = 1.0;
    spinAnimation.repeatCount = INFINITY;
    [self.shapeLayer addAnimation:spinAnimation forKey:UIXActivityIndicatorViewSpinAnimationKey];
}
//MARK:删除动画
-(void)_removeAnimation
{
    [self.shapeLayer removeAnimationForKey:UIXActivityIndicatorViewSpinAnimationKey];
}
@end
