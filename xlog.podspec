Pod::Spec.new do |s|
  s.name     = 'XLog'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.platform = :ios
  s.summary  = "A lightweight iOS customizable logger"
  s.homepage = 'https://github.com/sunnyxx/XLog'
  s.author = { 'sunnyxx' => 'sunnyxx.github.io' }
  s.source = { :git => 'https://github.com/sunnyxx/XLog.git'}
  s.source_files = 'XLog/*.{h,m}'
  s.requires_arc = true
end