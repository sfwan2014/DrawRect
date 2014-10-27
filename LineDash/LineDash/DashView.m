//
//  DashView.m
//  LineDash
//
//  Created by changjian on 13-12-12.
//  Copyright (c) 2013年 changjian. All rights reserved.
//

#import "DashView.h"


@implementation DashView
{
    NSMutableArray *_pointArray;
    CGPoint _startPoint;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _pointArray = [[NSMutableArray alloc] init];
        _startPoint = CGPointMake(20, 20);
//        [_pointArray addObject:[NSValue valueWithCGPoint:_startPoint]];
    }
    return self;
}

/*
 思路:
  1. 一点一点的画
  2. 保存上次所画
  3. 画上次保存的
  4. 添加动画
 */

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
//    float lengths[] = {10,10};
    // phase 跳过几个点开始画虚线
    // lengths[] = {10, 10} 画10个点, 跳过10个点, 再画10个点
    // count lengths 的长度 , 如lengths[] = {10,20,10}, count = 3
//    CGContextSetLineDash(context, 0, lengths, 2);
    
    if (_pointArray.count > 0) {
        for (int i = 1; i < _pointArray.count-1; i++) {
            
            CGPoint point1 = [_pointArray[i] CGPointValue];
            CGPoint point2 = [_pointArray[i+1] CGPointValue];
            
            CGContextMoveToPoint(context, point1.x, point1.y);
            CGContextAddLineToPoint(context, point2.x, point2.y);
            CGContextStrokePath(context);
        }
    }
}

-(void)addPiont
{
    float x = rand()%32 * 10;
    float y = rand()%30 * 10;
    
    float tx = x/y;
    [_pointArray removeAllObjects];
    for (int i = 0; i < x; i++) {
        CGPoint point = CGPointMake(i, i/tx);
        NSValue *pointValue = [NSValue valueWithCGPoint:point];
        [_pointArray addObject:pointValue];
    }
    _startPoint = CGPointMake(x, y);
    [self setNeedsDisplay];
}

@end
