//
//  MFAlertView.m
//  CameraNoir
//
//  Created by Mohammad Fathi on 7/20/15.
//  Copyright (c) 2015 Mohammad Fathi. All rights reserved.
//

#import "MFAlertView.h"
#import "IndicatorProgressBar.h"
#import "LocationIndicator.h"

#define BUTTON_HEIGHT 45.0f
#define kStatusViewTag 105

#define kActivityIndicatorTag            90001
#define kActivityIndicatorTitleLabelTag  90002
#define kActivityIndicatorBackgroundTag  90003
#define kActivityIndicatorProgressBarTag 90004


typedef enum {
    AlertTypeMessage = 0,
    AlertTypeStatus
} AlertType;

@interface MFAlertView()

@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) NSMutableArray *buttons;
@property (strong, nonatomic) NSArray *buttonViews;
@property (strong, nonatomic) NSString *originalTitle;
@property (assign, nonatomic) AlertType alertType;
@property (strong, nonatomic) didDismiss dismissHandler;
@property (assign, nonatomic) CGPoint locationIndicatorCenter;
@property (strong, nonatomic) LocationIndicator *locationIndicator;

@property (strong, nonatomic) IBOutlet UIView *StatusView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *bodyLabel;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation MFAlertView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        [self addSubview:self.view];
        
        [self setup];
        
        return self;
    }
    return nil;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSString *className = NSStringFromClass([self class]);
        self.view = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
        [self addSubview:self.view];
        
        [self setup];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
        [self.view addGestureRecognizer:tapGesture];
        
        return self;
    }
    return nil;
}

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    
    self.locationIndicator = [[LocationIndicator alloc] initWithFrame:CGRectMake(0, 0, 75, 75)];
    self.locationIndicator.hidden = YES;
    [self.view addSubview:self.locationIndicator];
}

- (void)drawRect:(CGRect)rect {
    self.frame = rect;
    self.view.frame = self.bounds;
    self.locationIndicator.center = self.locationIndicatorCenter;
//    self.backgroundColor = [UIColor clearColor];
//    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
}

#pragma mark - Gesture Recognizers

- (void)handleTapGestureRecognizer:(UITapGestureRecognizer *)sender {
//    if (self.alertType == AlertTypeStatus) {
        CGPoint location = [sender locationInView:self];
        if (!CGRectContainsPoint(self.contentView.frame, location)) {
            [self dismiss];
        }
//    }
}


+ (void)showSuccessAlertWithTitle:(NSString *)title body:(NSString *)body dismiss:(didDismiss)dismiss {
    [MFAlertView showStatusWithTitle:title body:body image:[UIImage imageNamed:@"confirm"] dismiss:dismiss];
}

+ (void)showFailureAlertWithTitle:(NSString *)title body:(NSString *)body dismiss:(didDismiss)dismiss {
    [MFAlertView showStatusWithTitle:title body:body image:[UIImage imageNamed:@"cancel"] dismiss:dismiss];
}

+ (void)showStatusWithTitle:(NSString *)title body:(NSString *)body image:(UIImage *)image dismiss:(didDismiss)dismiss {
    UIWindow *window = [MFAlertView window];
    MFAlertView *alertView = [[MFAlertView alloc] initWithFrame:window.bounds];
    alertView.alertType = AlertTypeStatus;
    
    [alertView.closeButton setImage:image forState:UIControlStateNormal];
    
    if (!body || [body isEqualToString:@""]) {
        body = @"";
        [alertView.titleLabel removeFromSuperview];
        [alertView.bodyLabel removeFromSuperview];
        
        alertView.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, CGRectGetWidth(alertView.contentView.frame) - 30,
                                                                         CGRectGetHeight(alertView.contentView.frame) - BUTTON_HEIGHT)];
        alertView.titleLabel.font = [UIFont fontWithName:@"Montserrat-Bold" size:18.0f];
        alertView.titleLabel.textColor = [UIColor blackColor];
        alertView.titleLabel.textAlignment = NSTextAlignmentCenter;
        alertView.titleLabel.numberOfLines = 3;
        alertView.titleLabel.text = NSLocalizedString(title, nil);
        [alertView.contentView addSubview:alertView.titleLabel];
    }
    else if (!title || [title isEqualToString:@""]) {
        title = @"";
        [alertView.titleLabel removeFromSuperview];
        [alertView.bodyLabel removeFromSuperview];
        
        alertView.bodyLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, CGRectGetWidth(alertView.contentView.frame) - 30,
                                                                         CGRectGetHeight(alertView.contentView.frame) - BUTTON_HEIGHT)];
        alertView.bodyLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:16.0f];
        alertView.bodyLabel.textColor = [UIColor blackColor];
        alertView.bodyLabel.textAlignment = NSTextAlignmentCenter;
        alertView.bodyLabel.numberOfLines = 3;
        alertView.bodyLabel.text = NSLocalizedString(title, nil);
        [alertView.contentView addSubview:alertView.bodyLabel];
    }
    
    alertView.titleLabel.text = NSLocalizedString(title, nil);
    alertView.bodyLabel.text  = NSLocalizedString(body, nil).uppercaseString;
    alertView.dismissHandler  = dismiss;
    alertView.alpha           = 0.0;
    
    [window addSubview:alertView];
    [alertView show];
}

+ (UIWindow *)window {    
    NSInteger index = [UIApplication sharedApplication].windows.count - 1;
    UIWindow *window = [UIApplication sharedApplication].windows[index];
    while ([window.description containsString:@"Keyboard"] && index > 0) {
        index--;
        window = [UIApplication sharedApplication].windows[index];
    }
    return window;
}

+ (void)showWithTitle:(NSString *)title body:(NSString *)body buttonTitles:(NSArray *)buttonTitles dismiss:(didDismiss)dismiss {
    [MFAlertView showWithTitle:title body:body buttonTitles:buttonTitles buttonImages:@[] buttonColors:@[] dismiss:dismiss];
}

+ (void)showWithTitle:(NSString *)title body:(NSString *)body buttonViews:(NSArray *)buttonViews dismiss:(didDismiss)dismiss {
    [MFAlertView showWithTitle:title body:body buttonTitles:@[] buttonViews:buttonViews buttonImages:@[] buttonColors:@[] dismiss:dismiss];
}

+ (void)showWithTitle:(NSString *)title body:(NSString *)body buttonTitles:(NSArray *)buttonTitles buttonColors:(NSArray *)buttonColors dismiss:(didDismiss)dismiss {
    [MFAlertView showWithTitle:title body:body buttonTitles:buttonTitles buttonImages:@[] buttonColors:buttonColors dismiss:dismiss];
}

+ (void)showWithTitle:(NSString *)title body:(NSString *)body buttonImages:(NSArray *)buttonImages dismiss:(didDismiss)dismiss {
    [MFAlertView showWithTitle:title body:body buttonTitles:@[] buttonImages:buttonImages buttonColors:@[] dismiss:dismiss];
}

+ (void)showWithTitle:(NSString *)title body:(NSString *)body buttonTitles:(NSArray *)buttonTitles buttonImages:(NSArray *)buttonImages buttonColors:(NSArray *)buttonColors dismiss:(didDismiss)dismiss {
    [self showWithTitle:title body:body buttonTitles:buttonTitles buttonViews:@[] buttonImages:buttonImages buttonColors:buttonColors dismiss:dismiss];
}

+ (void)showWithTitle:(NSString *)title body:(NSString *)body buttonTitles:(NSArray *)buttonTitles buttonViews:(NSArray *)buttonViews buttonImages:(NSArray *)buttonImages buttonColors:(NSArray *)buttonColors dismiss:(didDismiss)dismiss {
    [self showWithTitle:title body:body buttonTitles:buttonTitles buttonViews:buttonViews buttonImages:buttonImages
           buttonColors:buttonColors pointOfInterest:CGPointZero dismiss:dismiss];
}

+ (void)showWithTitle:(NSString *)title body:(NSString *)body buttonTitles:(NSArray *)buttonTitles buttonViews:(NSArray *)buttonViews buttonImages:(NSArray *)buttonImages buttonColors:(NSArray *)buttonColors pointOfInterest:(CGPoint)poi dismiss:(didDismiss)dismiss {

    // Button Images not working yet //
    
    UIWindow *window = [MFAlertView window];
    MFAlertView *alertView = [[MFAlertView alloc] initWithFrame:window.bounds];

    poi = [alertView convertPoint:poi fromView:alertView.superview];
    if (!CGPointEqualToPoint(poi, CGPointZero)) {
        alertView.locationIndicator.hidden = NO;
        alertView.locationIndicatorCenter = poi;
        [alertView.locationIndicator setNeedsLayout];
        [alertView.locationIndicator layoutIfNeeded];
    }
    
    CGFloat buttonHeight = BUTTON_HEIGHT;
    if (buttonViews.count) {
        CGFloat height = ((UIView *)buttonViews.firstObject).frame.size.height;
        buttonHeight = MIN(height, 80.0f);
    }
    
    alertView.alertType = AlertTypeMessage;
    
    alertView.buttonViews = buttonViews;
    alertView.originalTitle = title;
    
    if (!body || [body isEqualToString:@""]) {
        body = @"";
        [alertView.titleLabel removeFromSuperview];
        [alertView.bodyLabel removeFromSuperview];
        
        alertView.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, CGRectGetWidth(alertView.contentView.frame) - 30,
                                                                         CGRectGetHeight(alertView.contentView.frame) - buttonHeight)];
        alertView.titleLabel.font = [UIFont fontWithName:@"Montserrat-Bold" size:18.0f];
        alertView.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        alertView.titleLabel.numberOfLines = 3;
        alertView.titleLabel.textColor = [UIColor blackColor];
        alertView.titleLabel.textAlignment = NSTextAlignmentCenter;
        alertView.titleLabel.text = NSLocalizedString(title, nil);
        [alertView.contentView addSubview:alertView.titleLabel];
    }
    
    alertView.closeButton.hidden = YES;
    alertView.titleLabel.text    = NSLocalizedString(title, nil);
    alertView.bodyLabel.text     = NSLocalizedString(body, nil).uppercaseString;
    alertView.dismissHandler     = dismiss;
    alertView.alpha              = 0.0;
    
    alertView.bodyLabel.lineBreakMode = NSLineBreakByWordWrapping;
    alertView.bodyLabel.numberOfLines = 3;
    
    if (!buttonImages) buttonImages = @[];
    if (!buttonTitles) buttonTitles = @[];
    if (!buttonViews)  buttonViews  = @[];
    
    // Top divider
    UIView *topDivider = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(alertView.contentView.frame) - buttonHeight - 0.5, CGRectGetWidth(alertView.contentView.frame), 1)];
    topDivider.backgroundColor = [UIColor lightGrayColor];
    [alertView.contentView addSubview:topDivider];
    
    CGFloat width = CGRectGetWidth(alertView.contentView.frame)/(buttonTitles.count + buttonImages.count + buttonViews.count);
    NSInteger index = 0;
    
    alertView.buttons = [[NSMutableArray alloc] init];
    
    UIButton *button;
    for (NSString *title in buttonTitles) {
        button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(width * index, CGRectGetHeight(alertView.contentView.frame) - buttonHeight, width, buttonHeight);
        [button addTarget:alertView action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:NSLocalizedString(title, nil).uppercaseString forState:UIControlStateNormal];
        button.titleLabel.numberOfLines = 0;
        
        UIColor *color = [UIColor blackColor];
        if (buttonColors.count > index) color = buttonColors[index];
        [button setTitleColor:color forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:12.0f];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.tag = index;
        index++;
        [alertView.contentView addSubview:button];
        
        [alertView.buttons addObject:button];
        
        // Side divider
        if (title != buttonTitles.lastObject) {
            UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(width * index - 0.5, CGRectGetHeight(alertView.contentView.frame) - buttonHeight, 1, buttonHeight)];
            divider.backgroundColor = [UIColor lightGrayColor];
            [alertView.contentView addSubview:divider];
        }
    }
    
    for (UIImage *image in buttonImages) {
        button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(width * index, CGRectGetHeight(alertView.contentView.frame) - buttonHeight, width, buttonHeight);
        [button addTarget:alertView action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:image forState:UIControlStateNormal];
        button.tintColor = [UIColor blackColor];
        button.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        UIColor *color = [UIColor blackColor];
        if (buttonColors.count > index) color = buttonColors[index];
        [button setTitleColor:color forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:12.0f];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.tag = index;
        index++;
        [alertView.contentView addSubview:button];
        
        [alertView.buttons addObject:button];
        
        // Side divider
        if (title != buttonTitles.lastObject) {
            UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(width * index - 0.5, CGRectGetHeight(alertView.contentView.frame) - buttonHeight, 1, buttonHeight)];
            divider.backgroundColor = [UIColor lightGrayColor];
            [alertView.contentView addSubview:divider];
        }
    }
    
    for (UIView *view in buttonViews) {
        button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(width * index, CGRectGetHeight(alertView.contentView.frame) - buttonHeight, width, buttonHeight);
        [button addTarget:alertView action:@selector(buttonPressed:)       forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:alertView action:@selector(buttonHighlighted:)   forControlEvents:UIControlEventTouchDown];
        [button addTarget:alertView action:@selector(buttonHighlighted:)   forControlEvents:UIControlEventTouchDragEnter];
        [button addTarget:alertView action:@selector(buttonUnHighlighted:) forControlEvents:UIControlEventTouchDragExit];
        
        view.center = CGPointMake(button.frame.size.width/2, button.frame.size.height/2);
        view.userInteractionEnabled = NO;
        [button addSubview:view];
        
        button.tag = index;
        index++;
        [alertView.contentView addSubview:button];
        
        [alertView.buttons addObject:button];
        
        // Side divider
        if (view != buttonViews.lastObject) {
            UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(width * index - 0.5, CGRectGetHeight(alertView.contentView.frame) - buttonHeight, 1, buttonHeight)];
            divider.backgroundColor = [UIColor lightGrayColor];
            [alertView.contentView addSubview:divider];
        }
    }
    
    // add images here...
    
    [window addSubview:alertView];
    [alertView show];
}

#pragma mark - Statue Update

+ (void)showStatusUpdateWithTitle:(NSString *)title {
    [MFAlertView showStatusUpdateWithTitle:title autoDismiss:NO completion:nil];
}

+ (void)showStatusUpdateWithTitle:(NSString *)title completion:(void(^)())completion {
    [MFAlertView showStatusUpdateWithTitle:title autoDismiss:NO completion:completion];
}

+ (void)showStatusUpdateWithTitle:(NSString *)title autoDismiss:(BOOL)autoDismiss completion:(void(^)())completion {
    CGPoint location = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds)/2, CGRectGetHeight([UIScreen mainScreen].bounds)/2);
    [self showStatusUpdateWithTitle:title location:location dark:NO autoDismiss:autoDismiss completion:completion];
}

+ (void)showStatusUpdateWithTitle:(NSString *)title location:(CGPoint)location dark:(BOOL)dark autoDismiss:(BOOL)autoDismiss completion:(void(^)())completion {
    [MFAlertView dismissStatusUpdate:nil];
    
    UIFont *font = [UIFont fontWithName:@"Montserrat-Regular" size:20.0];
    CGSize labelSize = [title sizeWithAttributes:@{NSFontAttributeName : font}];
    
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    CGRect frame = CGRectMake(0, 0, labelSize.width + 60, labelSize.height + 30);
    if (fabs(labelSize.width - labelSize.height) < 30.0) {
        CGFloat max = MAX(labelSize.width, labelSize.height);
        frame = CGRectMake(0, 0, max + 30, max + 30);
    }
    UIView *statusView = [[UIView alloc] initWithFrame:frame];
    statusView.tag = kStatusViewTag;
    
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:dark?UIBlurEffectStyleDark:UIBlurEffectStyleLight]];
    blurView.frame = statusView.bounds;
    
    statusView.center = location;
    statusView.backgroundColor = [UIColor clearColor];
    statusView.layer.cornerRadius = statusView.frame.size.height/2;
    statusView.layer.masksToBounds = YES;
    statusView.alpha = 0.0;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((statusView.frame.size.width - labelSize.width)/2, (statusView.frame.size.height - labelSize.height)/2,
                                                               labelSize.width, labelSize.height)];
    label.text = title;
    label.minimumScaleFactor = 0.5;
    label.lineBreakMode = NSLineBreakByTruncatingMiddle;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = font;
    
    [statusView addSubview:blurView];
    [statusView addSubview:label];
    [window addSubview:statusView];
    
    [UIView animateWithDuration:0.35f animations:^{
        statusView.alpha = 1.0;
    } completion:^(BOOL finished) {
        if (autoDismiss) {
            [UIView animateWithDuration:0.35f delay:1.0f options:0 animations:^{
                statusView.alpha = 0.0;
            } completion:^(BOOL finished) {
                [statusView removeFromSuperview];
                if (completion) completion();
            }];
        } else if (completion) completion();
    }];
    
}

+ (void)dismissStatusUpdate:(void(^)())completion {
    [self dismissStatusUpdateAfterDelay:0.0f completion:completion];
}

+ (void)dismissStatusUpdateAfterDelay:(CGFloat)delay completion:(void(^)())completion {
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    for (UIView *subview in window.subviews) {
        if (subview.tag == kStatusViewTag) {
            [UIView animateWithDuration:0.5f delay:delay options:0 animations:^{
                subview.alpha = 0.0;
            } completion:^(BOOL finished) {
                [subview removeFromSuperview];
                if (completion) completion();
            }];
        }
    }
}


#pragma mark - Activity Indicator

+ (void)showActivityIndicator {
    [MFAlertView showActivityIndicatorWithCompletion:nil];
}

+ (void)showActivityIndicatorWithCompletion:(void(^)())completed {
    [MFAlertView showActivityIndicatorWithTitle:nil completion:completed];
}

+ (void)showActivityIndicatorWithTitle:(NSString *)title completion:(void(^)())completed {
    [MFAlertView showActivityIndicatorWithProgress:-1 title:title dimBackground:YES completion:completed];
}

+ (void)showActivityIndicatorWithProgress:(CGFloat)progress completion:(void(^)())completed {
    [MFAlertView showActivityIndicatorWithProgress:progress dimBackground:YES completion:completed];
}

+ (void)showActivityIndicatorWithProgress:(CGFloat)progress dimBackground:(BOOL)dimBackground completion:(void(^)())completed {
    [MFAlertView showActivityIndicatorWithProgress:progress title:nil dimBackground:dimBackground completion:completed];
}

+ (void)showActivityIndicatorWithProgress:(CGFloat)progress title:(NSString *)title dimBackground:(BOOL)dimBackground completion:(void(^)())completed {
    UIWindow *window = [MFAlertView window];
    
    UIView *backgroundView;
    IndicatorProgressBar *progressBar;
    
    if (dimBackground) {
        backgroundView = [[UIView alloc] initWithFrame:window.bounds];
        backgroundView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.9];
        backgroundView.tag = kActivityIndicatorBackgroundTag;
        backgroundView.alpha = 0.0;
        [window addSubview:backgroundView];
    }
    
    ActivityIndicator *indicator = [[ActivityIndicator alloc] initWithFrame:CGRectMake(0, 0, 52, 52)];
    indicator.center = window.center;
    indicator.progress = 0.0;
    indicator.alpha = 0.0;
    indicator.tag = kActivityIndicatorTag;
    [window addSubview:indicator];
    
    if (progress >= 0.0) {
        [indicator removeRing];
        progressBar = [[IndicatorProgressBar alloc] initWithFrame:CGRectMake(0, 0, 53, 53)];
        progressBar.center = window.center;
        progressBar.tag = kActivityIndicatorProgressBarTag;
        progressBar.progress = 0;
        [window addSubview:progressBar];
    }

    if (!title) title = @"";
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(window.frame), CGRectGetHeight(window.frame))];
    label.text = title.uppercaseString;
    label.center = CGPointMake(window.center.x, window.center.y + 75.0f);
    label.font = [UIFont fontWithName:@"Montserrat-Regular" size:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.alpha = 0.0;
    label.tag = kActivityIndicatorTitleLabelTag;
    [window addSubview:label];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (progress < 0.0) [indicator startAllAnimations:self];
        [UIView animateWithDuration:0.5f animations:^{
            if (backgroundView) backgroundView.alpha = 1.0;
            indicator.alpha = 1.0;
            label.alpha = 1.0;
        } completion:^(BOOL finished) {
            if (completed) completed();
        }];
    });
}


+ (void)startAnimating {
    ActivityIndicator *activityIndicator = [[MFAlertView window] viewWithTag:kActivityIndicatorTag];
    if (activityIndicator) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [activityIndicator startAllAnimations:self];
        });
    }
}

+ (void)setTitle:(NSString *)title {
    UILabel *label = [[MFAlertView window] viewWithTag:kActivityIndicatorTitleLabelTag];
    if (label) {
        dispatch_async(dispatch_get_main_queue(), ^{
            label.text = title;
        });
    }
}

+ (void)setProgress:(CGFloat)progress {
    IndicatorProgressBar *progressBar = [[MFAlertView window] viewWithTag:kActivityIndicatorProgressBarTag];
    if (progressBar) {
        dispatch_async(dispatch_get_main_queue(), ^{
            progressBar.progress = progress;
        });
    }
}

- (void)show {
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        if (self.locationIndicator) [self.locationIndicator startAllAnimations:self];
    }];
}

+ (void)hideActivityIndicator {
    UIWindow *window = [MFAlertView window];
    ActivityIndicator *indicator      = [window viewWithTag:kActivityIndicatorTag];
    IndicatorProgressBar *progressBar = [window viewWithTag:kActivityIndicatorProgressBarTag];
    UIView *background                = [window viewWithTag:kActivityIndicatorBackgroundTag];
    UILabel *label                    = [window viewWithTag:kActivityIndicatorTitleLabelTag];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.4f animations:^{
            background.alpha = 0.0;
            progressBar.alpha = 0.0;
            indicator.alpha = 0.0;
            label.alpha = 0.0;
        } completion:^(BOOL finished) {
            [indicator stopAllAnimations:self];
            [progressBar removeFromSuperview];
            [background removeFromSuperview];
            [indicator removeFromSuperview];
            [label removeFromSuperview];
        }];
    });
}

- (void)dismiss {
    [self closeButtonPressed:self.closeButton];
}

- (void)buttonPressed:(UIButton *)button {
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 0.0;
        button.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        if (finished) {
            if (self.dismissHandler) {
                self.dismissHandler(button.tag);
                self.dismissHandler = nil;
            }
        }
    }];
}

- (void)buttonHighlighted:(UIButton *)button {
    button.backgroundColor = [UIColor lightGrayColor];
}

- (void)buttonUnHighlighted:(UIButton *)button {
    button.backgroundColor = [UIColor clearColor];
}

+ (MFAlertView *)currentAlertView {
    MFAlertView *alertView = nil;
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    for (id subview in window.subviews) {
        if ([subview isKindOfClass:[MFAlertView class]]) alertView = subview;
    }
    return alertView;
}

- (void)removeAllAlertViews {
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    for (__strong id subview in window.subviews) {
        if ([subview isKindOfClass:[MFAlertView class]]) {
            [subview removeFromSuperview];
            subview = nil;
        }
    }
}

- (IBAction)closeButtonPressed:(UIButton *)sender {
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            if (self.dismissHandler) self.dismissHandler(-1);
            [self removeAllAlertViews];
        }
        [MFAlertView hideActivityIndicator];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
