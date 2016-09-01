
Pod::Spec.new do |s|

  s.version      = "4.5.2"

  s.name         = "XLsn0w"
  s.summary      = "A CocoaPods Library Of iOS Components via XLsn0w"
  s.description  = "Copyright © 2016年 XLsn0w Custom An iOS CocoaPods Framework"
  s.homepage     = "https://github.com/XLsn0w/XLsn0w"

  s.license      = 'MIT'
  s.author       = { "XLsn0w" => "xlsn0w@qq.com" }
  s.platform     = :ios, "7.0"
  s.requires_arc = true

  s.source       = { :git => "https://github.com/XLsn0w/XLsn0w.git", :tag => s.version.to_s }

  s.public_header_files = 'XLsn0wFramework/XLsn0w.h'
  s.source_files = 'XLsn0wFramework/XLsn0w.h'

  s.resources    = "XLsn0wFramework/XLResource/Resources.bundle"

  s.frameworks   = "ImageIO", "QuartzCore", "AssetsLibrary", "MediaPlayer"
  s.weak_frameworks = "Photos"

  s.dependency "AFNetworking"
  s.dependency "FMDB"
  s.dependency "MBProgressHUD"
  s.dependency "SDWebImage"
  s.dependency "Masonry"
  s.dependency "MJRefresh"

  s.subspec 'XLsn0wFoundation' do |ss|

    ss.ios.deployment_target = '7.0'
    ss.public_header_files = 'XLsn0wFramework/XLsn0wFoundation/XLsn0wFoundation.h'
    ss.source_files = "XLsn0wFoundation/**/*.{h,m}"

  end

end
