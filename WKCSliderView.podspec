Pod::Spec.new do |s|
s.name         = "WKCSliderView"
s.version      = "1.3.6"
s.summary      = "自定义滑动进度条"
s.homepage     = "https://github.com/WKCLoveYang/WKCSliderView.git"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "WKCLoveYang" => "wkcloveyang@gmail.com" }
s.platform     = :ios, "10.0"
s.source       = { :git => "https://github.com/WKCLoveYang/WKCSliderView.git", :tag => "1.3.6" }
s.source_files  = "WKCSliderView/**/*.{h,m}"
s.public_header_files = "WKCSliderView/**/*.h"
s.frameworks = "Foundation", "UIKit"
s.requires_arc = true

end
