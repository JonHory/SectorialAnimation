//
//  SectorialView.h
//  SectorialAnimation
//
//  Created by Jonhory on 2016/10/17.
//  Copyright © 2016年 wujh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectorialView : UIView

@property(nonatomic,copy) void  (^sectorialViewAnimationDidStop)();


/**
 360度圆环

 @param viewWidth 圆环半径
 @param lineWidth 圆环线宽
 @param color     颜色
 @param duration  动画时长
 @param inside    内切还是外切
 */
-(void)reDraw:(CGFloat)viewWidth lineWidth:(CGFloat)lineWidth color:(UIColor *)color duration:(NSTimeInterval)duration insideOrOutside:(BOOL)inside;

@end
