
Pod::Spec.new do |s|

  s.name         = "XLsn0w"
  s.summary      = "XLsn0w Custom An iOS CocoaPods Framework"
  s.description  = "Copyright © 2016年 XLsn0w Custom An iOS CocoaPods Framework"
  s.homepage     = "https://github.com/XLsn0w/XLsn0w"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author       = { "XLsn0w" => "xlsn0w@qq.com" }
  s.platform     = :ios, "7.0"
  s.requires_arc = true

  s.version      = "4.2.1"
  s.source       = { :git => "https://github.com/XLsn0w/XLsn0w.git", :tag => "4.2.1" }

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
