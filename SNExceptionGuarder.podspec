Pod::Spec.new do |s|

  s.name         = "SNExceptionGuarder"
  s.version      = "0.0.1"
  s.summary      = "Intercept system exception."
  s.author       = { "sunning" => "412255824@qq.com" }
  s.homepage     = 'https://github.com/NingSun1009/SNExceptionGuarder'
  s.source       = { :git => 'https://github.com/NingSun1009/SNExceptionGuarder.git',
  :tag => s.version.to_s }
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'SNExceptionGuarder'
  s.public_header_files = 'SNExceptionGuarder/*.h'

  s.ios.deployment_target = '7.0'

end
