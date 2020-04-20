Pod::Spec.new do |s|
  s.name                  = 'JudoKitObjC'
  s.version               = '8.2.1'
  s.summary               = 'Judo Pay Full iOS Client Kit'
  s.homepage              = 'https://www.judopay.com/'
  s.license               = 'MIT'
  s.author                = { "Judopay" => 'developersupport@judopayments.com' }
  s.source                = { :git => 'https://github.com/Judopay/JudoKitObjC.git', :tag => s.version.to_s }

  s.documentation_url     = 'https://docs.judopay.com'

  s.ios.deployment_target = '10.3'
  s.requires_arc          = true
  s.source_files          = 'Source/**/*.{m,h}'

  s.dependency 'DeviceDNA'
  s.dependency 'TrustKit'
  s.dependency 'PayCardsRecognizer'

  s.frameworks            = 'CoreLocation', 'Security', 'CoreTelephony'
  s.pod_target_xcconfig   = { 'FRAMEWORK_SEARCH_PATHS'   => '$(inherited) ${PODS_ROOT}/DeviceDNA/Source' }
  s.resource_bundles = { "JudoKitObjC" => ["Resources/*.lproj/*.strings"] }
  s.resources = ['Resources/icons.bundle', 'Resources/resources.bundle']
end
