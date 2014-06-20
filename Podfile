inhibit_all_warnings!	#removes all pod warnings

platform :ios, '7.0'

#pragma mark - CoreData Wrapper
pod 'MagicalRecord', '~> 2.2'

#pragma mark - Android Like Toast
pod 'Toast', '~> 2.2'

#pragma mark - Network Libraries
pod 'MKNetworkKit'
pod 'SVProgressHUD', '~> 1.0'

# Disables all Magical Records relating LOGS
post_install do |installer|
    target = installer.project.targets.find{|t| t.to_s == "Pods-MagicalRecord"}
    target.build_configurations.each do |config|
        s = config.build_settings['GCC_PREPROCESSOR_DEFINITIONS']
        s = [ '$(inherited)' ] if s == nil;
        s.push('MR_ENABLE_ACTIVE_RECORD_LOGGING=0') if config.to_s == "Debug";
        config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] = s
    end
end