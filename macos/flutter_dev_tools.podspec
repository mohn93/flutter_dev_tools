#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_dev_tools.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_dev_tools'
  s.version          = '0.0.1'
  s.summary          = 'A versatile Flutter package providing an HTTP request logger for efficient network monitoring and debugging, setting the stage for an expanding suite of development and QA tools'
  s.description      = <<-DESC
A versatile Flutter package providing an HTTP request logger for efficient network monitoring and debugging, setting the stage for an expanding suite of development and QA tools
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }

  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
