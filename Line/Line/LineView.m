//
//  LineView.m
//  Line
//
//  Created by changjian on 13-12-11.
//  Copyright (c) 2013年 changjian. All rights reserved.
//

#import "LineView.h"

#define Kheight 200
#define kStartTop 50
#define kStartLeft 20

@implementation LineView
{
    NSArray *_data;
    NSMutableArray *_points;
    CGSize _pointSize;
    CGSize _highlightSize;
    UILabel *_label;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"array.plist" ofType:nil];
        _data = [[NSArray alloc] initWithContentsOfFile:filePath];
        _points = [[NSMutableArray alloc] initWithCapacity:_data.count];
        _pointSize = CGSizeMake(20, 20);

        self.tag = NSNotFound;
        
        if (_label == nil) {
            _label = [[UILabel alloc] initWithFrame:CGRectZero];
            [self addSubview:_label];
            _label.backgroundColor = [UIColor grayColor];
            _label.textColor = [UIColor whiteColor];
            _label.textAlignment = NSTextAlignmentCenter;
        }
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i < _points.count; i++) {
        if (self.tag == i) {
            NSValue *value = _points[i];
            CGPoint point = [value CGPointValue];
            point.x -= 20;
            point.y += 20;
            
            NSDictionary *dict = _data[i];
            NSString *text = [dict objectForKey:@"num"];
            text = [NSString stringWithFormat:@"%@", text];
            CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(1000, 30)];
            
            CGRect frame = CGRectMake(point.x, point.y, size.width+20, size.height);
            
            _label.frame = frame;
            _label.text = text;
        }
    }
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(contextRef, 1.f);
    CGContextSetStrokeColorWithColor(contextRef, [UIColor blackColor].CGColor);
    CGContextBeginPath(contextRef);
    
    float width = self.frame.size.width/_data.count;
    CGContextMoveToPoint(contextRef, kStartLeft, kStartTop+Kheight);
    CGContextAddLineToPoint(contextRef, kStartLeft + (_data.count-1) * width, kStartTop+Kheight);
    
    // 画坐标系
    for (int i = 0; i < _data.count; i++) {
        CGContextMoveToPoint(contextRef, kStartLeft+i*width, kStartTop);
        CGContextAddLineToPoint(contextRef, kStartLeft+i*width, kStartTop+Kheight);
        break;
    }

    // 画折线
    for (int i = 0; i < _data.count-1; i++) {
        NSDictionary *dict1 = _data[i];
        CGPoint point1 = [self point:dict1];
        NSDictionary *dict2 = _data[i+1];
        CGPoint point2 = [self point:dict2];
        
        CGContextMoveToPoint(contextRef, point1.x, point1.y);
        CGContextAddLineToPoint(contextRef, point2.x, point2.y);
        
    }
    
    // 画点
    float pointWidth = _pointSize.width;
    float pointHeight = _pointSize.height;
    for (int i = 0; i < _data.count; i++) {
        NSDictionary *dict = _data[i];
        CGPoint point = [self point:dict];
        
        CGRect frame = CGRectMake((point.x-pointWidth/2), (point.y-pointHeight/2), pointWidth, pointHeight);
        if (self.tag == i) {
            frame = CGRectMake((point.x-_highlightSize.width/2), (point.y-_highlightSize.height/2), _highlightSize.width, _highlightSize.height);
//            NSString *text = [dict objectForKey:@"num"];
//            NSAttributedString *txt = [[NSAttributedString alloc] initWithString:text];
//            CGSize size = txt.size;
//            
//            CGRect textRect = CGRectMake(point.x-5, point.y+pointHeight, size.width, size.height);
//            
//            CALayer *layer = [CALayer layer];
//            layer.frame = textRect;
//            layer.backgroundColor = [UIColor yellowColor].CGColor;
////            [txt drawLayer:layer inContext:contextRef];
////            [text drawInRect:textRect withFont:[UIFont systemFontOfSize:7]];
//            [txt drawInRect:textRect];
            
            self.tag = NSNotFound;
        }
        UIImage *image = [UIImage imageNamed:@"aboutLogo.png"];
        [image drawInRect:frame];
        
        NSValue *pointValue = [NSValue valueWithCGPoint:point];
        [_points addObject:pointValue];
    }
    
    CGContextStrokePath(contextRef);
}

-(CGPoint)point:(NSDictionary *)dict
{
    CGPoint point = CGPointZero;
    float width = self.frame.size.width/_data.count;
    float num = [[dict objectForKey:@"num"] floatValue];
    float time = [[dict objectForKey:@"time"] floatValue];
    time *=100;
    point.x = (time - 908)*width + kStartLeft;

    point.y = num *self.frame.size.height/Kheight + kStartTop;
    
    return point;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGRect rect = CGRectMake((point.x-20/2), (point.y-20/2), 20, 20);
    
    int tag = [self touchInRect:rect];
    
    if (tag<0) {
        return;
    }
    self.tag = tag;
    NSLog(@"%d", tag);
    [self setHighlight:YES];
    
}

-(void)setHighlight:(BOOL)isHighlight
{
    [self setNeedsLayout];
    
    if (isHighlight) {
        _highlightSize = CGSizeMake(30, 30);
        _label.alpha = 1;
        [self setNeedsDisplay];
        [self performSelector:@selector(setHighlight:) withObject:NO afterDelay:3];
    } else {
        _highlightSize = CGSizeMake(20, 20);
        _label.alpha = 0;
        [self setNeedsDisplay];
    }
}

-(int)touchInRect:(CGRect)rect
{
    float width = rect.size.width;
    float height = rect.size.height;
    CGPoint origin = rect.origin;
    
    CGPoint point = CGPointMake(origin.x+width/2, origin.y+height/2);
    for (int i = 0; i < _points.count; i++) {
        NSValue *pointValue = _points[i];
        CGPoint p = [pointValue CGPointValue];
        
//        NSLog(@"%@ --- %@", NSStringFromCGPoint(point), NSStringFromCGPoint(p));
        
        if (ABS(point.x - p.x) <20 && ABS(point.y - p.y) < 20) {
            return i;
        }
    }
    
    return -1;
}

@end
