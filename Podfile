platform :ios, '13.0'
use_frameworks!

#source 'https://github.com/CocoaPods/Specs.git'

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
        # отключения предупреждения LD_NO_PIE
            config.build_settings['LD_NO_PIE'] = 'NO'
        # отключения предупреждения кода
        config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
        config.build_settings['SWIFT_SUPPRESS_WARNINGS'] = "YES"
        # отключения предупреждения минимальный ios 12
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = "13.0"
      
      
      # отключения обязательного подписи библиотеки CropViewController
      config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
      config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
      config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
      # ин ошибка факат Xcode 14 ва мебуромад
      
      
      #Xcode 14.3 fix
      config.build_settings['CODE_SIGN_IDENTITY'] = ""
      #config.build_settings['ENABLE_MODULE_VERIFIER'] = "No"
      #config.build_settings['ENABLE_MODULE_VERIFIER'] = "$(CLANG_MODULES_ENABLE_VERIFIER_TOOL)"
      #config.build_settings.delete('ENABLE_MODULE_VERIFIER')
      
      
        end
    end
end

def shared_pods
   pod 'Alamofire'
   pod 'IQKeyboardManagerSwift'
   pod 'PanModal'
   pod 'SwiftyJSON'
   pod 'SnapKit'
   pod 'SDWebImage'
end


target 'IOSUtils' do
  shared_pods
end

