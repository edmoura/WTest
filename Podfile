# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'
inhibit_all_warnings!

def mainPods
  pod 'Moya'
  pod 'Kingfisher'
  pod 'Disk'
  pod 'SnapKit'
end

# Disable Code Coverage for Pods projects
post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
        end
    end
end


target 'WTest' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  mainPods
  # Pods for WTest

  target 'WTestTests' do
    inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
  end

  target 'WTestUITests' do
    inherit! :search_paths
    mainPods
  end

end
