//
//  ViewController.m
//  DrawCircle
//
//  Created by Yeming on 13-8-27.
//  Copyright (c) 2013年 Yeming. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()
{
    CAShapeLayer *arcLayer;
    BOOL _isIntroduceVC;
    NSInteger numberOfHeight;
    BOOL _isIos5;
    BOOL _isAnimation;
    BOOL _isPressButton;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self intiUIOfView];
    self.view.backgroundColor=[UIColor grayColor];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)intiUIOfView
{
    UIBezierPath *path=[UIBezierPath bezierPath];
  
    NSArray *firstArray = @[@2,@1,@3,@5,@4,@7];
    NSArray *secondArray = @[@2,@5,@9,@7,@6,@8];
    
    
    for (int i=0; i<secondArray.count-1; i++) {
        CGPoint point = CGPointMake([firstArray[i] integerValue]*10, [secondArray[i] integerValue]*20);
        CGPoint nextPoint = CGPointMake([firstArray[i+1] integerValue]*10, [secondArray[i+1] integerValue]*20);
        [path moveToPoint:point];
        //    [path addArcWithCenter:CGPointMake(rect.size.width/2,rect.size.height/2-20) radius:100 startAngle:0 endAngle:2*M_PI clockwise:NO];
        [path addLineToPoint:nextPoint];
        arcLayer=[CAShapeLayer layer];
        arcLayer.path=path.CGPath;//46,169,230
        arcLayer.fillColor=[UIColor colorWithRed:46.0/255.0 green:169.0/255.0 blue:230.0/255.0 alpha:1].CGColor;
        arcLayer.strokeColor=[UIColor colorWithWhite:1 alpha:0.7].CGColor;
        arcLayer.lineWidth=1;
        arcLayer.lineDashPattern = @[@4, @2];  //先画4个再空2个
        arcLayer.frame=self.view.frame;
        [self.view.layer addSublayer:arcLayer];
        [self drawLineAnimation:arcLayer];
        
    }
    
//    CGRect rect=[UIScreen mainScreen].applicationFrame;
    
    
}
-(void)drawLineAnimation:(CALayer*)layer
{
    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration=1;
    bas.delegate=self;
    bas.fromValue=[NSNumber numberWithInteger:0];
    bas.toValue=[NSNumber numberWithInteger:1];
    [layer addAnimation:bas forKey:@"key"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
