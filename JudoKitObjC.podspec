Pod::Spec.new do |s|
  s.name                  = 'JudoKitObjC'
  s.version               = '8.0.0'
  s.summary               = 'Judopay iOS Client (Objective-C)'
  s.homepage              = 'https://www.judopay.com/'
  s.license               = 'MIT'
  s.author                = { "Judopay" => 'developersupport@judopayments.com' }
  s.source                = { :git => 'https://github.com/Judopay/JudoKitObjC.git', :tag => s.version.to_s }

  s.documentation_url     = 'https://judopay.github.io/JudoKitObjC/'

  s.ios.deployment_target = '10.0'
  s.requires_arc          = true
  s.source_files          = 'Source/**/*.{m,h}'

  s.dependency 'DeviceDNA', '~> 0.1'
  s.dependency 'TrustKit', '~> 1.6.0'

  s.frameworks            = 'CoreLocation', 'Security', 'CoreTelephony'
  s.pod_target_xcconfig   = { 'FRAMEWORK_SEARCH_PATHS'   => '$(inherited) ${PODS_ROOT}/DeviceDNA/Source' }

end
