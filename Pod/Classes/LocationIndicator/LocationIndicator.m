//
//  LocationIndicator.m
//
//  Code generated using QuartzCode on 11/5/15.
//  www.quartzcodeapp.com
//

#import "LocationIndicator.h"
#import "QCMethod.h"


@interface LocationIndicator ()

@property (nonatomic, strong) NSArray*  layerWithAnims;
@property (nonatomic, assign) BOOL animationAdded;

@property (nonatomic, strong) CAShapeLayer *Ring;

@end

@implementation LocationIndicator

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
	
	CAShapeLayer * Ring = [CAShapeLayer layer];
	Ring.frame       = CGRectMake(17.5, 17.59, 40, 39.81);
	Ring.fillColor   = nil;
	Ring.strokeColor = [UIColor whiteColor].CGColor;
	Ring.lineWidth   = 5;
	Ring.path        = [self RingPath].CGPath;
	[self.layer addSublayer:Ring];
	_Ring = Ring;
	
	CAShapeLayer * oval = [CAShapeLayer layer];
	oval.frame     = CGRectMake(13.64, 13.61, 47.71, 47.79);
	oval.opacity   = 0.85;
	oval.fillColor = [UIColor whiteColor].CGColor;
	oval.lineWidth = 0;
	oval.path      = [self ovalPath].CGPath;
	[self.layer addSublayer:oval];
	
	self.layerWithAnims = @[Ring];
}


- (IBAction)startAllAnimations:(id)sender{
	self.animationAdded = NO;
	for (CALayer *layer in self.layerWithAnims){
		layer.speed = 1;
	}
	[self.Ring addAnimation:[self oval2Animation] forKey:@"oval2Animation"];
}


- (IBAction)startReverseAnimations:(id)sender{
	self.animationAdded = NO;
	for (CALayer *layer in self.layerWithAnims){
		layer.speed = 1;
	}
	CGFloat totalDuration = 1000;
	[self.Ring addAnimation:[QCMethod reverseAnimation:[self oval2Animation] totalDuration:totalDuration] forKey:@"oval2Animation"];
}

- (void)setProgress:(CGFloat)progress{
	if(!self.animationAdded){
		[self startAllAnimations:nil];
		self.animationAdded = YES;
		for (CALayer *layer in self.layerWithAnims){
			layer.speed = 0;
			layer.timeOffset = 0;
		}
	}
	else{
		CGFloat totalDuration = 1000;
		CGFloat offset = progress * totalDuration;
		for (CALayer *layer in self.layerWithAnims){
			layer.timeOffset = offset;
		}
	}
}

- (CAAnimationGroup*)oval2Animation{
	CABasicAnimation * opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
	opacityAnim.toValue            = @0;
	opacityAnim.duration           = 1.25;
	opacityAnim.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	opacityAnim.repeatCount        = INFINITY;
	
	CABasicAnimation * transformAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
	transformAnim.toValue            = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2, 2, 1)];;
	transformAnim.duration           = 1.25;
	transformAnim.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	transformAnim.repeatCount        = INFINITY;
	
	CABasicAnimation * lineWidthAnim = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
	lineWidthAnim.toValue            = @0;
	lineWidthAnim.duration           = 1.25;
	lineWidthAnim.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	lineWidthAnim.repeatCount        = INFINITY;
	
	CAAnimationGroup *ovalAnimGroup   = [CAAnimationGroup animation];
	ovalAnimGroup.animations          = @[opacityAnim, transformAnim, lineWidthAnim];
	[ovalAnimGroup.animations setValue:kCAFillModeForwards forKeyPath:@"fillMode"];
	ovalAnimGroup.fillMode            = kCAFillModeForwards;
	ovalAnimGroup.removedOnCompletion = NO;
	ovalAnimGroup.duration = [QCMethod maxDurationFromAnimations:ovalAnimGroup.animations];
	
	
	return ovalAnimGroup;
}

#pragma mark - Bezier Path

- (UIBezierPath*)RingPath{
	UIBezierPath *RingPath = [UIBezierPath bezierPath];
	[RingPath moveToPoint:CGPointMake(20, 0)];
	[RingPath addCurveToPoint:CGPointMake(0, 19.905) controlPoint1:CGPointMake(8.954, 0) controlPoint2:CGPointMake(0, 8.912)];
	[RingPath addCurveToPoint:CGPointMake(20, 39.811) controlPoint1:CGPointMake(0, 30.899) controlPoint2:CGPointMake(8.954, 39.811)];
	[RingPath addCurveToPoint:CGPointMake(40, 19.905) controlPoint1:CGPointMake(31.046, 39.811) controlPoint2:CGPointMake(40, 30.899)];
	[RingPath addCurveToPoint:CGPointMake(20, 0) controlPoint1:CGPointMake(40, 8.912) controlPoint2:CGPointMake(31.046, 0)];
	
	return RingPath;
}

- (UIBezierPath*)ovalPath{
	UIBezierPath*  ovalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 48, 48)];
	return ovalPath;
}

@end