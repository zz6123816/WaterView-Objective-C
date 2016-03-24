//
//  WaterView.m
//  GiftBox
//
//  Created by 康健 on 15/11/23.
//  Copyright © 2015年 xinyihezi. All rights reserved.
//

#import "WaterView.h"
@interface WaterView()
/** 波动量 */
@property (nonatomic, assign) CGFloat a;
/** 波动量 */
@property (nonatomic, assign) CGFloat b;

/** 当前水的方向 */
@property (nonatomic, assign) BOOL isUp;

@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, assign) CGFloat currentLinePointY;
@end
@implementation WaterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.a = 1.5;
    self.b = 0;
    self.isUp = NO;
    self.percent = 0;
    self.currentLinePointY = self.bounds.size.height;
    self.timer = [NSTimer timerWithTimeInterval:0.02 target:self selector:@selector(animateWave) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}
- (void)animateWave {
    if (self.isUp) {
        self.a += 0.01;
    }else{
        self.a -= 0.01;
    }
    if (self.a<=1) {
        self.isUp = YES;
    }
    if (self.a>=1.5) {
        self.isUp = NO;
    }
    self.b += 0.1;
    
    CGFloat per = (1 - self.percent);
    if (per == 1) {
        per = 0.95;
    }
    CGFloat needHeight = self.bounds.size.height * per;
    if (self.currentLinePointY - needHeight >= -0.8 && self.currentLinePointY - needHeight <= 0.8) {
        self.currentLinePointY = needHeight;
    } else if (self.currentLinePointY < needHeight) {
        self.currentLinePointY += 0.8;
    } else {
        self.currentLinePointY -= 0.8;
    }
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    //画水
    CGContextSetLineWidth(context, 1);
    CGContextSetFillColorWithColor(context, [_waterColor CGColor]);
    
    float y=_currentLinePointY;
    CGPathMoveToPoint(path, NULL, 0, y);
    for(float x = 0; x <= 320; x++){
        y= self.a * sin( x / 180 * M_PI + 4 * self.b / M_PI ) * 5 + self.currentLinePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, kDeviceWidth, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.currentLinePointY);
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
    
    
}
@end
