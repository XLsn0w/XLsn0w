
Pod::Spec.new do |s|

  s.version      = "6.1.2"
  s.summary      = "Copyright © XLsn0w"
  s.author          = { "XLsn0w" => "xlsn0w@outlook.com" }

  s.name         = "XLsn0w"
  s.homepage     = "https://github.com/XLsn0w/XLsn0w"
  s.source       = { :git => "https://github.com/XLsn0w/XLsn0w.git", :tag => s.version.to_s }

  s.source_files    = "XLsn0wKit/**/*.{h,m}"

  s.libraries       = "sqlite3", "z"

  s.frameworks      = "UIKit", "Foundation"

  s.requires_arc    = true
  s.license         = 'MIT'
  s.platform        = :ios, "9.0"

  s.dependency "MBProgressHUD"
  s.dependency "AFNetworking"
  s.dependency "SDWebImage"
  s.dependency "Masonry"

end
