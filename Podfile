source 'https://github.com/CocoaPods/Specs.git'
source 'http://gitlab.igen/caohouhong/specs.git'
platform :ios, '12.0'
use_frameworks!

target ‘TestDemo1’ do

pod 'MBProgressHUD', '~> 1.0.0'
pod 'MJRefresh', '~> 3.1.15.1'
pod 'pop', '~> 1.0'
pod 'AFNetworking', '~> 3.0'
pod 'MJExtension'
pod 'Masonry'
pod 'lottie-ios', '~> 2.5.3'
pod 'IQKeyboardManager'
pod 'KVOController'
pod 'AGGeometryKit'
pod 'FMDB'
pod 'FDFullscreenPopGesture', '1.1'
pod 'SnapKit', '~> 4.2.0'
pod 'HandyJSON', '~> 5.0.2'
pod 'CocoaAsyncSocket'
pod 'FlowDiagram_iOS', '~> 0.0.4'
# 使用版本号
pod 'SystemLayoutKit', '0.0.2'
# 使用远程地址 + 'commit'提交记录
#pod 'SystemLayoutKit', :git => 'http://gitlab.igen/caohouhong/SystemLayoutKit_iOS.git', :commit => 'aa2488299a9648e9a370a54b1025a79c95213c08'

#pod 'IgCharts', '0.0.1'
# 使用远程地址 + 'commit'提交记录
pod 'IgCharts', :git => 'http://gitlab.igen/caohouhong/IgCharts.git', :commit => '42821f59107f6d5c1d99967a4415876827c07fea'


post_install do |installer|
  # 增加后将忽略资源文件签名，pod install后Pods里面的资源文件不用配置签名
  installer.pods_project.targets.each do |target|
      if target.respond_to?(:product_type) and target.product_type == "com.apple.product-type.bundle"
        target.build_configurations.each do |config|
            config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
        end
      end
    end
end

end

