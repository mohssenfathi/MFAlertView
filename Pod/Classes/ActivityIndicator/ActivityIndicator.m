//
//  ActivityIndicator.m
//
//  Code generated using QuartzCode 1.23 on 9/15/15.
//  www.quartzcodeapp.com
//

#import "ActivityIndicator.h"
#import "QCMethod.h"


@interface ActivityIndicator () {
    CGFloat lastProgress;
}

@property (nonatomic, strong) NSArray*  layerWithAnims;
@property (nonatomic, assign) BOOL animationAdded;

@property (nonatomic, strong) CAShapeLayer * Ring;

@end

@implementation ActivityIndicator

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setupLayers];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		[self setupLayers];
	}
	return self;
}


- (void)setupLayers{
	self.backgroundColor = [UIColor colorWithRed:0 green: 0 blue:0 alpha:0];
	
    lastProgress = 0.0;
    
	CAShapeLayer * Ring = [CAShapeLayer layer];
	Ring.frame       = CGRectMake(1, 1, 50, 50);
	Ring.lineCap     = kCALineCapRound;
	Ring.fillColor   = nil;
	Ring.strokeColor = [UIColor whiteColor].CGColor;
	Ring.lineWidth   = 2;
	Ring.strokeStart = 1;
	Ring.path        = [self RingPath].CGPath;
	[self.layer addSublayer:Ring];
	_Ring = Ring;
	
	CAShapeLayer * Circle = [CAShapeLayer layer];
	Circle.frame       = CGRectMake(4.5, 4.5, 43, 43);
	Circle.fillColor   = [UIColor whiteColor].CGColor;
	Circle.strokeColor = [UIColor colorWithRed:0.329 green: 0.329 blue:0.329 alpha:0].CGColor;
	Circle.path        = [self CirclePath].CGPath;
	[self.layer addSublayer:Circle];
	
	self.layerWithAnims = @[Ring];
}

- (void)removeRing {
    [_Ring removeFromSuperlayer];
}

- (IBAction)startAllAnimations:(id)sender{
	self.animationAdded = NO;
	for (CALayer *layer in self.layerWithAnims){
		layer.speed = 1;
	}
	[self.Ring addAnimation:[self RingAnimation] forKey:@"RingAnimation"];
}

- (IBAction)stopAllAnimations:(id)sender{
    [self.Ring removeAllAnimations];
}


- (IBAction)startReverseAnimations:(id)sender{
	self.animationAdded = NO;
	for (CALayer *layer in self.layerWithAnims){
		layer.speed = 1;
	}
	CGFloat totalDuration = 2;
	[self.Ring addAnimation:[QCMethod reverseAnimation:[self RingAnimation] totalDuration:totalDuration] forKey:@"RingAnimation"];
}

- (void)setProgress:(CGFloat)progress {
    if (progress == lastProgress) return;
    
    if(!self.animationAdded){
		[self startAllAnimations:nil];
		self.animationAdded = YES;
		for (CALayer *layer in self.layerWithAnims){
			layer.speed = 0;
			layer.timeOffset = 0;
		}
	}
	else{
//        for (CALayer *layer in self.layerWithAnims){
//            layer.speed = 1;
//        }
//            
//        [self.Ring removeAllAnimations];
//        [self.Ring addAnimation:[self RingAnimationWithProgress:progress] forKey:@"progressUpdate"];
        
        CGFloat totalDuration = 1;
        CGFloat offset = progress * totalDuration;
        for (CALayer *layer in self.layerWithAnims){
            layer.timeOffset = offset;
        }
	}
}


- (CAAnimationGroup*)RingAnimationWithProgress:(CGFloat)progress {
    CABasicAnimation * strokeStartAnim = [CABasicAnimation animationWithKeyPath:@"strokeEndNIL"];
    strokeStartAnim.fromValue          = @0;
    strokeStartAnim.toValue            = @0;
    strokeStartAnim.duration           = 0.875;
    strokeStartAnim.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation * strokeEndAnim = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeEndAnim.fromValue          = @(1.0 - lastProgress);
    strokeEndAnim.toValue            = @(1.0 - progress);
    strokeEndAnim.duration           = progress/1.5;
    strokeEndAnim.beginTime          = 0;
    strokeEndAnim.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    lastProgress = progress;
    
    CABasicAnimation * opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.toValue            = @1;
    opacityAnim.duration           = 0.25;
    opacityAnim.beginTime          = 0.875;
    
    CAAnimationGroup *oval2AnimGroup   = [CAAnimationGroup animation];
    oval2AnimGroup.animations          = @[strokeStartAnim, strokeEndAnim, opacityAnim];
    [oval2AnimGroup.animations setValue:kCAFillModeForwards forKeyPath:@"fillMode"];
    oval2AnimGroup.fillMode            = kCAFillModeForwards;
    oval2AnimGroup.removedOnCompletion = NO;
    oval2AnimGroup.duration = [QCMethod maxDurationFromAnimations:oval2AnimGroup.animations];
    oval2AnimGroup.removedOnCompletion = YES;
//    oval2AnimGroup.repeatCount = INFINITY;
    
    return oval2AnimGroup;
}

- (CAAnimationGroup*)RingAnimation{
	CABasicAnimation * strokeStartAnim = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
	strokeStartAnim.toValue            = @0;
	strokeStartAnim.duration           = 0.875;
	strokeStartAnim.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	
	CABasicAnimation * strokeEndAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
	strokeEndAnim.toValue            = @0;
	strokeEndAnim.duration           = 0.875;
	strokeEndAnim.beginTime          = 1.12;
	strokeEndAnim.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	
	CABasicAnimation * opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
	opacityAnim.toValue            = @1;
	opacityAnim.duration           = 0.25;
	opacityAnim.beginTime          = 0.875;
	
	CAAnimationGroup *oval2AnimGroup   = [CAAnimationGroup animation];
	oval2AnimGroup.animations          = @[strokeStartAnim, strokeEndAnim, opacityAnim];
	[oval2AnimGroup.animations setValue:kCAFillModeForwards forKeyPath:@"fillMode"];
	oval2AnimGroup.fillMode            = kCAFillModeForwards;
	oval2AnimGroup.removedOnCompletion = NO;
	oval2AnimGroup.duration = [QCMethod maxDurationFromAnimations:oval2AnimGroup.animations];
	oval2AnimGroup.repeatCount = INFINITY;
	
	return oval2AnimGroup;
}

#pragma mark - Bezier Path

- (UIBezierPath*)RingPath{
	UIBezierPath *RingPath = [UIBezierPath bezierPath];
	[RingPath moveToPoint:CGPointMake(25, 0)];
	[RingPath addCurveToPoint:CGPointMake(0, 25) controlPoint1:CGPointMake(11.193, -0) controlPoint2:CGPointMake(0, 11.193)];
	[RingPath addCurveToPoint:CGPointMake(25, 50) controlPoint1:CGPointMake(0, 38.807) controlPoint2:CGPointMake(11.193, 50)];
	[RingPath addCurveToPoint:CGPointMake(50, 25) controlPoint1:CGPointMake(38.807, 50) controlPoint2:CGPointMake(50, 38.807)];
	[RingPath addCurveToPoint:CGPointMake(25, 0) controlPoint1:CGPointMake(50, 11.193) controlPoint2:CGPointMake(38.807, 0)];
	
	return RingPath;
}

- (UIBezierPath*)CirclePath{
	UIBezierPath*  CirclePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 43, 43)];
	return CirclePath;
}

@end