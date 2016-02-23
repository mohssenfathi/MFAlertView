# MFAlertView

[![CI Status](http://img.shields.io/travis/mohssenfathi/MFAlertView.svg?style=flat)](https://travis-ci.org/mohssenfathi/MFAlertView)
[![Version](https://img.shields.io/cocoapods/v/MFAlertView.svg?style=flat)](http://cocoapods.org/pods/MFAlertView)
[![License](https://img.shields.io/cocoapods/l/MFAlertView.svg?style=flat)](http://cocoapods.org/pods/MFAlertView)
[![Platform](https://img.shields.io/cocoapods/p/MFAlertView.svg?style=flat)](http://cocoapods.org/pods/MFAlertView)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

MFAlertView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MFAlertView"
```

## Usage

MFAlertView contains 3 main components:

  1. Alert View - The alert view is an alternative to the native iOS UIAlertView. It allows for a few customization options, but it's main purpose is to provide a quick way to present a dialog with an arbitrary number of actions. The alert view provides a very quick and easy way to present a range of buttons with text, images, or custom views.
  
  To create a basic alert view with text buttons:
  ```Objective-C
  [MFAlertView showWithTitle:@"Alert"
                        body:@"These are some basic text buttons."
                buttonTitles:@[@"Cool", @"Wow", @"Meh"]
                     dismiss:nil];
  ```
  ![Text Alert](https://github.com/mohssenfathi/MFAlertView/blob/master/Screenshots/text-alert.png)
  
  or with images:
  ```Objective-C
  [MFAlertView showWithTitle:@"Alert"
                        body:@"These are some image buttons."
                buttonImages:@[[UIImage imageNamed:@"new"], [UIImage imageNamed:@"edit"], [UIImage imageNamed:@"delete"]]
                     dismiss:nil];
  ```
  ![Image Alert](https://github.com/mohssenfathi/MFAlertView/blob/master/Screenshots/image-alert.png)
  
  or with custom views:
  ```Objective-C
  [MFAlertView showWithTitle:@"Alert" 
                        body:@"These are custom views." 
                 buttonViews:@[view1, view2, view3] 
                     dismiss:nil];

  ```
  
  to indicate success/failure:
  ```Objective-C
  [MFAlertView showSuccessAlertWithTitle:@"Success" body:@"Whatever it was. It worked." dismiss:nil];
  
  [MFAlertView showFailureAlertWithTitle:@"Uh Oh" body:@"There was a problem." dismiss:nil];

  ```
  ![Success Alert](https://github.com/mohssenfathi/MFAlertView/blob/master/Screenshots/success.png)
  
  <br/>
  
  2. Activity Indicator - The activity indicator can be presented and dismissed on command, or it can be used as a progress indicator.
  
  Adding an activity indicator is as simple as:
  ```Objective-C
  [MFAlertView showActivityIndicator];
  ```
  
  then to remove it:
  ```Objective-C  
  [MFAlertView hideActivityIndicator];
  ```
  
  the activity indicator can show progress as well:
  ```Objective-C  
  [MFAlertView showActivityIndicatorWithProgress:0 title:@"Downloading" dimBackground:YES completion:^{
      [MFAlertView setProgress:0.1];
      [MFAlertView setProgress:0.2];
      .
      .
      [MFAlertView setProgress:1.0];
      [MFAlertView hideActivityIndicator];
  }];
  ```
  ![Activity Indicator](https://github.com/mohssenfathi/MFAlertView/blob/master/Screenshots/activity-indicator.png)
  
  <br/>
  
  3. Status Updates - Status updates are labels that will appear on top of the main view for a brief period to indicate some change in state.

  To show a status update:
  ```Objective-C  
  [MFAlertView showStatusUpdateWithTitle:@"Status Update" autoDismiss:YES completion:^{
      . . .
  }];
  ```
  
  to present the status update at a custom location:
  ```Objective-C  
  [MFAlertView showStatusUpdateWithTitle:@"Dark Status" 
                                location:CGPointMake(200, 200)
                                    dark:YES 
                             autoDismiss:YES 
                              completion:nil];

  ```

## TODO

  1. Divide compoments into separate classes. One for the alert view, activity indicator, and status update.
  2. Add more customization options, like background color, dim color, etc. Maybe by changing from class methods to instance methods to reduce method length.
  3. Fix issued with the progress activity indicator jumping around.
  4. Fix lag/choppiness when animating views in.

## Author

mohssenfathi, mmohssenfathi@gmail.com

## License

MFAlertView is available under the MIT license. See the LICENSE file for more info.
