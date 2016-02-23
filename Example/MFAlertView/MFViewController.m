//
//  MFViewController.m
//  MFAlertView
//
//  Created by mohssenfathi on 02/22/2016.
//  Copyright (c) 2016 mohssenfathi. All rights reserved.
//

#import "MFViewController.h"
#import "MFAlertView.h"

@interface MFViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - UITableView
#pragma mark DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 6;
        case 1: return 3;
        case 2: return 4;
        default: break;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0: return @"Alert View";
        case 1: return @"Activity Indicator";
        case 2: return @"Status Update";
        default: break;
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    NSString *title = @"";
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: title = @"Text Buttons";         break;
                case 1: title = @"Image Buttons";        break;
                case 2: title = @"Colored Text Buttons"; break;
                case 3: title = @"Custom Buttons";       break;
                case 4: title = @"Success";              break;
                case 5: title = @"Failure";              break;
                default: break;
            }
            break;
        }
        case 1: {
            switch (indexPath.row) {
                case 0: title = @"Basic";              break;
                case 1: title = @"Completion Handler"; break;
                case 2: title = @"Progress Indicator"; break;
                default: break;
            }
            break;
        }
        case 2: {
            switch (indexPath.row) {
                case 0: title = @"Light";    break;
                case 1: title = @"Dark";     break;
                case 2: title = @"Location"; break;
                case 3: title = @"Long";     break;
                default: break;
            }
            break;
        }
        default: break;
    }
    
    cell.textLabel.text = title;
}

#pragma mark Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0: [self showAlertForIndexPath:indexPath];             return;
        case 1: [self showActivityIndicatorForIndexPath:indexPath]; return;
        case 2: [self showStatusUpdateForIndexPath:indexPath];      return;
    }
}


#pragma mark - Alerts

- (void)showAlertForIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [MFAlertView showWithTitle:@"Alert"
                                  body:@"These are some basic text buttons."
                          buttonTitles:@[@"Cool", @"Wow", @"Meh"]
                               dismiss:nil];
            break;
        
        case 1:
            [MFAlertView showWithTitle:@"Alert"
                                  body:@"These are some image buttons."
                          buttonImages:@[[UIImage imageNamed:@"new"], [UIImage imageNamed:@"edit"], [UIImage imageNamed:@"delete"]]
                               dismiss:nil];
            break;
            
        case 2:
            [MFAlertView showWithTitle:@"Alert"
                                  body:@"These are some colored text buttons."
                          buttonTitles:@[@"Red", @"Green", @"Blue"]
                          buttonColors:@[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]]
                               dismiss:nil];
            break;
        
        case 3: {
            UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
            UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
            circle.center = view1.center;
            circle.backgroundColor = [UIColor redColor];
            circle.layer.cornerRadius = 15;
            [view1 addSubview:circle];
            
            UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.frame = view2.bounds;
            UIBezierPath* path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(25, 12.5)];
            [path addLineToPoint:CGPointMake(10, 37.5)];
            [path addLineToPoint:CGPointMake(40, 37.5)];
            [path closePath];
            shapeLayer.fillColor = [UIColor greenColor].CGColor;
            shapeLayer.path = path.CGPath;
            [view2.layer addSublayer:shapeLayer];
            
            UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
            UIView *square = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
            square.center = view3.center;
            square.backgroundColor = [UIColor blueColor];
            [view3 addSubview:square];
            
            [MFAlertView showWithTitle:@"Alert" body:@"These are custom views." buttonViews:@[view1, view2, view3] dismiss:nil];
        }
            break;
        case 4:
            [MFAlertView showSuccessAlertWithTitle:@"Success" body:@"Whatever it was. It worked." dismiss:nil];
            break;
        case 5:
            [MFAlertView showFailureAlertWithTitle:@"Uh Oh" body:@"There was a problem." dismiss:nil];
            break;
            
        default:
            break;
    }
}

- (void)showActivityIndicatorForIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [MFAlertView showActivityIndicatorWithCompletion:^{
                sleep(5);
                [MFAlertView hideActivityIndicator];
            }];
            break;

        case 1:
            [MFAlertView showActivityIndicatorWithCompletion:^{
                sleep(5);
                [MFAlertView hideActivityIndicator];
                [MFAlertView showWithTitle:@"Dismissed!" body:nil buttonTitles:@[@"Close"] dismiss:nil];
            }];
            break;
            
        case 2:{
            [MFAlertView showActivityIndicatorWithProgress:0 title:@"Downloading" dimBackground:YES completion:^{
                for (NSInteger i = 1; i < 6; i++) {
                    [self performSelector:@selector(setProgress:) withObject:@(((CGFloat)i)/5.0) afterDelay:i];
                }
                [self performSelector:@selector(hide) withObject:nil afterDelay:7.0];
            }];
        }
            break;
            
        default:
            break;
    }
}

- (void)showStatusUpdateForIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [MFAlertView showStatusUpdateWithTitle:@"Light Status" location:self.view.center dark:NO autoDismiss:YES completion:nil];
            break;
        case 1:
            [MFAlertView showStatusUpdateWithTitle:@"Dark Status" location:self.view.center dark:YES autoDismiss:YES completion:nil];
            break;
        case 2: {
            [MFAlertView showStatusUpdateWithTitle:@"Over Here" location:CGPointMake(self.view.frame.size.width - 100, 100) dark:YES autoDismiss:YES completion:^{
                [MFAlertView showStatusUpdateWithTitle:@"Now Over Here" location:CGPointMake(125, self.view.frame.size.height - 50) dark:YES autoDismiss:YES completion:^{
                    [MFAlertView showStatusUpdateWithTitle:@"One More Time" location:CGPointMake(self.view.center.x, self.view.center.y + 100) dark:YES autoDismiss:YES completion:nil];
                }];
            }];
        }
            break;
        case 3:
            [MFAlertView showStatusUpdateWithTitle:@"This is a really long status." location:self.view.center dark:YES autoDismiss:YES completion:nil];
            break;
        default: break;
    }
}


- (void)setProgress:(NSNumber *)progress {
//    NSLog(@"Setting Progress %f", [progress floatValue]);
    [MFAlertView setProgress:[progress floatValue]];
}

- (void)hide {
    [MFAlertView hideActivityIndicator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
