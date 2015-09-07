Pod::Spec.new do |p|
  p.name = 'CoreParse'
  p.version = '0.1'
  p.platform = :ios
  p.source = { :git => 'https://github.com/beelsebob/CoreParse.git' }
  p.source_files = 'CoreParse/**/*.{h,m}'
end
