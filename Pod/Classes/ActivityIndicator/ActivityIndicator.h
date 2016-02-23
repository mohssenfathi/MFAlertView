//
//  ActivityIndicator.h
//
//  Code generated using QuartzCode 1.23 on 9/15/15.
//  www.quartzcodeapp.com
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE 
@interface ActivityIndicator : UIView

@property (nonatomic, assign) CGFloat progress;

- (IBAction)startAllAnimations:(id)sender;
- (IBAction)stopAllAnimations:(id)sender;
- (IBAction)startReverseAnimations:(id)sender;

- (void)removeRing;

@end