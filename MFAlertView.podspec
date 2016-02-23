#
# Be sure to run `pod lib lint MFAlertView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MFAlertView"
  s.version          = "0.1.0"
  s.summary          = "MFAlertView is a quick alternative to the native iOS UIAlertView or UIAlertController."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
  MFAlertView contains three main components:
  1. Alert View - The alert view is an alternative to the native iOS UIAlertView. It allows for a few customization options, but it's main purpose is to provide a quick way to present a dialog with an arbitrary number of actions. The alert view provides a very quick and easy way to present a range of buttons with text, images, or custom views.
  2. Activity Indicator - The activity indicator can be presented and dismissed on command, or it can be used as a progress indicator.
  2. Status Updates - Status updates are labels that will appear on top of the main view for a brief period to indicate some change in state.
                       DESC

  s.homepage         = "https://github.com/mohssenfathi/MFAlertView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "mohssenfathi" => "mmohssenfathi@gmail.com" }
  s.source           = { :git => "https://github.com/mohssenfathi/MFAlertView.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resources = 'Pod/Resources/**/*'
  s.resource_bundles = {
    'MFAlertView' => ['Pod/Assets/*.png']
  }

end
