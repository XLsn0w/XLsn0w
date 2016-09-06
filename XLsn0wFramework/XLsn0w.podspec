
Pod::Spec.new do |s|

  s.version      = "4.5.8"

  s.name         = "XLsn0w"
  s.summary      = "A CocoaPods Library Of iOS Components via XLsn0w"
  s.description  = "Copyright © 2016年 XLsn0w Custom An iOS CocoaPods Framework"

  s.license      = 'MIT'

  s.author       = { "XLsn0w" => "xlsn0w@qq.com" }
  s.homepage     = "https://github.com/XLsn0w/XLsn0w"
  s.platform     = :ios, "7.0"

  s.requires_arc = true

  s.source       = { :git => "https://github.com/XLsn0w/XLsn0w.git", :tag => s.version.to_s }
  s.source_files = "XLsn0wFramework/**/*.{h,m}"

  s.resources    = "XLsn0wFramework/XLResource/Resources.bundle"

  s.frameworks   = "ImageIO", "QuartzCore", "AssetsLibrary", "MediaPlayer"
  s.weak_frameworks = "Photos"

  s.dependency "AFNetworking"
  s.dependency "FMDB"
  s.dependency "MBProgressHUD"
  s.dependency "SDWebImage"
  s.dependency "Masonry"
  s.dependency "MJRefresh"

end
