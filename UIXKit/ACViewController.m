//
//  ACViewController.m
//  UIXKit
//
//  Created by 潇翔 汪 on 14-4-21.
//  Copyright (c) 2014年 潇翔 汪. All rights reserved.
//

#import "ACViewController.h"
#import "UIXActivityIndicatorView.h"

@interface ACViewController ()
@property (weak, nonatomic) IBOutlet UIXActivityIndicatorView *activityIndicatorView;

@end

@implementation ACViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    __block UIXActivityIndicatorView *acView = _activityIndicatorView;
    acView.tintColor = [UIColor redColor];
    [acView startAnimating];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [acView stopAnimating];
//    });
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)_clickButton{
    [_activityIndicatorView stopAnimating];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
