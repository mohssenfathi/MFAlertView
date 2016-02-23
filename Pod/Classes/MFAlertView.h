//
//  CNAlertView.h
//  CameraNoir
//
//  Created by Mohammad Fathi on 7/20/15.
//  Copyright (c) 2015 Mohammad Fathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityIndicator.h"

typedef void(^didDismiss)(NSInteger buttonIndex);

@interface MFAlertView : UIView

// Alerts
+ (void)showWithTitle:(NSString *)title body:(NSString *)body buttonViews:(NSArray *)buttonViews dismiss:(didDismiss)dismiss;
+ (void)showWithTitle:(NSString *)title body:(NSString *)body buttonImages:(NSArray *)buttonImages dismiss:(didDismiss)dismiss;
+ (void)showWithTitle:(NSString *)title body:(NSString *)body buttonTitles:(NSArray *)buttonTitles dismiss:(didDismiss)dismiss;
+ (void)showWithTitle:(NSString *)title body:(NSString *)body buttonTitles:(NSArray *)buttonTitles buttonColors:(NSArray *)buttonColors dismiss:(didDismiss)dismiss;
+ (void)showWithTitle:(NSString *)title body:(NSString *)body buttonTitles:(NSArray *)buttonTitles buttonViews:(NSArray *)buttonViews buttonImages:(NSArray *)buttonImages buttonColors:(NSArray *)buttonColors pointOfInterest:(CGPoint)poi dismiss:(didDismiss)dismiss;

+ (void)showSuccessAlertWithTitle:(NSString *)title body:(NSString *)body dismiss:(didDismiss)dismiss;
+ (void)showFailureAlertWithTitle:(NSString *)title body:(NSString *)body dismiss:(didDismiss)dismiss;


// Activity Indicator
+ (void)hideActivityIndicator;
+ (void)showActivityIndicator;
+ (void)showActivityIndicatorWithCompletion:(void(^)())completed;
+ (void)showActivityIndicatorWithTitle:(NSString *)title completion:(void(^)())completed;
+ (void)showActivityIndicatorWithProgress:(CGFloat)progress completion:(void(^)())completed;
+ (void)showActivityIndicatorWithProgress:(CGFloat)progress title:(NSString *)title dimBackground:(BOOL)dimBackground completion:(void(^)())completed;
+ (void)setProgress:(CGFloat)progress;
+ (void)setTitle:(NSString *)title;
+ (void)startAnimating;


// Status Updates
+ (void)dismissStatusUpdate:(void(^)())completion;
+ (void)dismissStatusUpdateAfterDelay:(CGFloat)delay completion:(void(^)())completion;
+ (void)showStatusUpdateWithTitle:(NSString *)title autoDismiss:(BOOL)autoDismiss completion:(void(^)())completion;
+ (void)showStatusUpdateWithTitle:(NSString *)title location:(CGPoint)location dark:(BOOL)dark autoDismiss:(BOOL)autoDismiss completion:(void(^)())completion;

@end
