# Uncomment the next line to define a global platform for your project
# platform :ios, '11.0'

target 'SDC' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SDC

  pod 'JGProgressHUD'
  pod "TPKeyboardAvoidingSwift"
  pod 'MOLH'
  pod 'SDWebImage', '~> 5.0'
  pod 'CHTCollectionViewWaterfallLayout'
pod 'OTPFieldView'
pod 'CountryPickerView'


  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'GoogleSignIn', '>= 5.0'
  pod 'OneSignal', '>= 3.0.0', '< 4.0'
  pod 'SideMenu'
  pod 'SDWebImage', '~> 5.0'
  pod'ImageSlideshow/SDWebImage'


  pod 'NVActivityIndicatorView'
  pod 'Loaf'
  pod 'CRRefresh'
  pod "CDAlertView"

  pod 'StepIndicator', '~> 1.0.8'
  pod 'LineChart'
  pod 'Charts'

  pod 'netfox', '~> 1.21.0'
  pod 'AlamofireNetworkActivityLogger', '~> 3.4'
pod 'ImageSlideshow', '~> 1.9.0'


  target 'SDCTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SDCUITests' do
    # Pods for testing
  end

end
deployment_target = '15.0'

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
            end
        end
        project.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
        end
    end
end
