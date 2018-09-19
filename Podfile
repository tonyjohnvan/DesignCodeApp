# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'DesignCodeApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DesignCodeApp
  pod 'Spring', :git => 'https://github.com/MengTo/Spring.git'
  pod 'Alamofire', '~> 4.7'
  pod 'ViewAnimator'

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings.delete('CODE_SIGNING_ALLOWED')
    config.build_settings.delete('CODE_SIGNING_REQUIRED')
  end
end