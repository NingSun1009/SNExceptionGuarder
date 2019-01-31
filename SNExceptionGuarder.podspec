Pod::Spec.new do |s|

  s.name         = "SNExceptionGuarder"
  s.version      = "0.0.3"
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
  s.requires_arc = 
  [ 'SNExceptionGuarder/NSArray+SNExceptionGuarder.m',
    'SNExceptionGuarder/NSAttributedString+SNExceptionGuarder.m',
    'SNExceptionGuarder/NSDictionary+SNExceptionGuarder.m',
    'SNExceptionGuarder/NSMutableArray+SNExceptionGuarder.m',
    'SNExceptionGuarder/NSMutableAttributedString+SNExceptionGuarder.m',
    'SNExceptionGuarder/NSMutableDictionary+SNExceptionGuarder.m',
    'SNExceptionGuarder/NSMutableSet+SNExceptionGuarder.m',
    'SNExceptionGuarder/NSMutableString+SNExceptionGuarder.m',
    'SNExceptionGuarder/NSObject+SNExceptionGuarder.m',
    'SNExceptionGuarder/NSObject+SNSwizzle.m',
    'SNExceptionGuarder/NSSet+SNExceptionGuarder.m',
    'SNExceptionGuarder/NSString+SNExceptionGuarder.m',
    'SNExceptionGuarder/NSTimer+SNExceptionGuarder.m',
    'SNExceptionGuarder/SNExceptionGuarder.m',
    'SNExceptionGuarder/SNExceptionGuarderProxy.m'
  ]
  s.ios.deployment_target = '7.0'

end
