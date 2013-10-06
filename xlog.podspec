Pod::Spec.new do |s|
  s.name     = 'xlog'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.platform = :ios
  s.summary  = "An lightweight iOS customizable logger"
  s.homepage = 'https://github.com/sunnyxx/xlog'
  s.author = { 'sunnyxx' => 'sunnyxx.github.io' }
  s.source = { :git => 'https://github.com/sunnyxx/xlog.git'}
  s.source_files = 'xlog/xlog/src/*.{h,m}'
  s.resources = ['xlog/xlog/src/xlogconfig.plist']
  s.requires_arc = true
 # s.public_header_files
end