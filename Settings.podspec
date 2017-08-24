Pod::Spec.new do |s|
  s.name             = "Settings"
  s.version          = "1.0.3"
  s.summary          = "A tiny library for iOS Settings app."
  s.homepage         = "https://github.com/Meniny/Settings"
  s.license          = 'MIT'
  s.author           = { "Elias Abel" => "Meniny@qq.com" }
  s.source           = { :git => "https://github.com/Meniny/Settings.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Settings/*.*'
  s.module_name = 'Settings'
  s.public_header_files = 'Settings/*.h'
  s.frameworks = 'Foundation'
end
