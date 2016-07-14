
Pod::Spec.new do |s|

  s.name         = "XLsn0w"
  s.summary      = "XLsn0w Custom An iOS CocoaPods Framework"
  s.description  = "Copyright © 2016年 XLsn0w Custom An iOS CocoaPods Framework"
  s.homepage     = "https://github.com/XLsn0w/XLsn0w"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author       = { "XLsn0w" => "xlsn0w@qq.com" }
  s.platform     = :ios, "7.0"
  s.requires_arc = true

  s.version      = "3.2.0"
  s.source       = { :git => "https://github.com/XLsn0w/XLsn0w.git", :tag => "3.2.0" }

  s.source_files = "XLsn0wFramework/**/*.{h,m}"

  s.resources    = "XLsn0wFramework/Resources/XLsn0w.bundle"
  s.resources    = "XLsn0wFramework/XLNSObject/JSPatch/JSPatch.js"

  s.framework    = "QuartzCore"

  s.dependency "AFNetworking"
  s.dependency "FMDB"
  s.dependency "MBProgressHUD"
  s.dependency "SDWebImage"
  s.dependency "Masonry"

end

