
Pod::Spec.new do |s|

  s.name         = "XLsn0w"
  s.version      = "2.2.4.0"
  s.summary      = "XLsn0w Create CocoaPods Framework"
  s.description  = "XLsn0w Create CocoaPods Framework via xlsn0w@qq.com"
  s.homepage     = "https://github.com/XLsn0w/XLsn0w"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author       = { "XLsn0w" => "xlsn0w@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/XLsn0w/XLsn0w.git", :tag => "2.2.4.0" }
  s.source_files = "XLsn0wFramework/**/*.{h,m}"
  s.resources    = "XLsn0wFramework/XLsn0w.bundle"
  s.framework    = "QuartzCore"
  s.dependency "AFNetworking", "~> 3.1.0"
  s.dependency "FMDB", "~> 2.6.2"
  s.dependency "MBProgressHUD", "~> 0.9.2"
  s.dependency "SDWebImage", "~> 3.8.1"
  s.requires_arc = true

end
