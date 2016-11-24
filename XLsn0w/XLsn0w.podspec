
Pod::Spec.new do |s|

  s.version      = "5.1.8"

  s.summary      = "An iOS Components Library Created by XLsn0w"

  s.requires_arc = true
  s.license      = 'MIT'
  s.platform     = :ios, "7.0"
  s.author       = { "XLsn0w" => "xlsn0w@qq.com" }

  s.name         = "XLsn0w"
  s.homepage     = "https://github.com/XLsn0w/XLsn0w"
  s.source       = { :git => "https://github.com/XLsn0w/XLsn0w.git", :tag => s.version.to_s }

  s.source_files = "XLsn0w/**/*.{h,m}"

  s.resources    = "XLsn0w/Resources/Resources.bundle"

  s.frameworks   = "ImageIO", "QuartzCore", "AssetsLibrary", "MediaPlayer"

  s.weak_frameworks = "Photos"

  s.dependency "AFNetworking"
  s.dependency "FMDB"
  s.dependency "MBProgressHUD"
  s.dependency "SDWebImage"
  s.dependency "Masonry"
  s.dependency "MJRefresh"

end
