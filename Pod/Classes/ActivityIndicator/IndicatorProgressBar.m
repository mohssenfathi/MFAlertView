//
//  ProgressBar.m
//  CameraNoir
//
//  Created by Mohammad Fathi on 11/24/15.
//  Copyright © 2015 Mohammad Fathi. All rights reserved.
//

#import "IndicatorProgressBar.h"

@interface IndicatorProgressBar()

@property (strong, nonatomic) CAShapeLayer *circle;

@end

@implementation IndicatorProgressBar

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        [self setup];
        return self;
    }
    return nil;
}

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    
    _progress = 0.0f;
    
    _circle = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect textRect = self.bounds; // CGRectMake(self.bounds.size.width/4, (self.bounds.size.height-self.bounds.size.width/2)/2, self.bounds.size.width/2, self.bounds.size.width/2);
    float midX = CGRectGetMidX(textRect);
    float midY = CGRectGetMidY(textRect);
    CGAffineTransform t = CGAffineTransformConcat( CGAffineTransformConcat(
                                                                           CGAffineTransformMakeTranslation(-midX, -midY),
                                                                           CGAffineTransformMakeRotation(-1.57079633/0.99)),
                                                  CGAffineTransformMakeTranslation(midX, midY));
    CGPathAddEllipseInRect(path, &t, textRect);
    _circle.path = path;
    _circle.frame = self.bounds;
    _circle.fillColor = [UIColor clearColor].CGColor;
    _circle.strokeColor = [UIColor whiteColor].CGColor;
    _circle.lineWidth = 2.0f;
    _circle.cornerRadius = 1.0f;
    _circle.lineCap = @"round";
    
    CGPathRelease(path);
    
    [self.layer addSublayer:_circle];
}

- (void)setProgress:(CGFloat)progress {

    CGFloat from = MIN(progress, _progress);
    CGFloat to   = MAX(progress, _progress);

    if (to <= from) return;
    
    NSLog(@"From: %f   To: %f", from, to);
    
    [_circle removeAllAnimations];
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1.0/(to - from) * (to - from);
    animation.fromValue = [NSNumber numberWithFloat:from];
    animation.toValue = [NSNumber numberWithFloat:to];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [_circle addAnimation:animation forKey:@"strokeEnd"];
    
    _progress = progress;
}

@end