//
//  ViewController.m
//  SectorialAnimation
//
//  Created by Jonhory on 2016/10/17.
//  Copyright © 2016年 wujh. All rights reserved.
//

#import "ViewController.h"
#import "SectorialView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    SectorialView * view = [[SectorialView alloc]initWithFrame:CGRectMake(0, 0, 80.0, 80.0)];
    view.layer.cornerRadius = view.bounds.size.width/2;
    view.backgroundColor = [UIColor blueColor];
    view.center = self.view.center;
    [self.view addSubview:view];
    
    [view reDraw:40.0 lineWidth:10.0 color:[UIColor redColor] duration:2.0 insideOrOutside:NO];
    __block UIView * weakView = view;
    view.sectorialViewAnimationDidStop = ^(){
        [weakView removeFromSuperview];
        weakView = nil;
    };
    
    SectorialView * view2 = [[SectorialView alloc]init];
    view2.center = CGPointMake(self.view.center.x, self.view.center.y + 110);
    [self.view addSubview:view2];
    [view2 reDraw:50 lineWidth:5 color:[UIColor lightGrayColor] duration:6.0 insideOrOutside:YES];
    
    SectorialView * view3 = [[SectorialView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    view3.backgroundColor = [UIColor purpleColor];
    view3.center = CGPointMake(self.view.center.x, self.view.center.y - 110);
    [self.view addSubview:view3];
    [view3 reDraw:view3.bounds.size.width/2 lineWidth:15 color:[UIColor lightGrayColor] duration:3.0 insideOrOutside:YES];
    
    NSTimer * timer = [NSTimer timerWithTimeInterval:3.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
         [view3 reDraw:view3.bounds.size.width/2 lineWidth:15 color:[UIColor lightGrayColor] duration:3.0 insideOrOutside:YES];
    }];
    [[NSRunLoop  currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
