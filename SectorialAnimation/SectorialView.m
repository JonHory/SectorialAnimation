//
//  SectorialView.m
//  SectorialAnimation
//
//  Created by Jonhory on 2016/10/17.
//  Copyright © 2016年 wujh. All rights reserved.
//

#import "SectorialView.h"

@interface SectorialView ()<CAAnimationDelegate>

@end

@implementation SectorialView
{
    CAShapeLayer *chartLine;
}


-(void)reDraw:(CGFloat)viewWidth lineWidth:(CGFloat)lineWidth color:(UIColor *)color duration:(NSTimeInterval)duration insideOrOutside:(BOOL)inside{
    if (chartLine!=nil){
        [chartLine removeAllAnimations];//这样就能重复绘制饼状图了
    }
    else{
        chartLine = [CAShapeLayer layer];
        chartLine.lineWidth = lineWidth;//这里设置填充线的宽度，这个参数很重要
        chartLine.lineCap = kCALineCapButt;//设置线端点样式，这个也是非常重要的一个参数
        chartLine.strokeColor = [color CGColor];//绘制的线的颜色
        chartLine.fillColor = nil;
        self.clipsToBounds = NO;//该属性表示如果图形绘制超过的容器的范围是否被裁掉，这里我们设置为YES ，表示要裁掉超出范围的绘制
        [self.layer addSublayer:chartLine];
        
    }
    CGMutablePathRef pathRef  = CGPathCreateMutable();
    CGFloat sectorialWidth = inside?viewWidth - lineWidth/2:viewWidth+lineWidth/2;
    CGPathAddArc(pathRef, &CGAffineTransformIdentity,
                 CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2, sectorialWidth, -M_PI_2, M_PI_2*3, NO);
    chartLine.path = pathRef;
    CGPathRelease(pathRef);
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = duration;//设置绘制动画持续的时间
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;//是否翻转绘制
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.repeatCount = 0;
    pathAnimation.delegate = self;
    [pathAnimation setValue:@"sectorialPath" forKey:@"sectorialPath"];
    NSLog(@"gogogo");
    [chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    chartLine.strokeEnd = 1.0f;//表示绘制到百分比多少就停止，这个我们用1表示完全绘制
    
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([anim valueForKey:@"sectorialPath"]) {
        if (self.sectorialViewAnimationDidStop) {
            self.sectorialViewAnimationDidStop();
        }
    }
}
@end
