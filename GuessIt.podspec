Pod::Spec.new do |s|
  s.name                  =  'GuessIt'
  s.version               =  '0.1'
  s.summary               =  'GuessIt is a framework for creating guessing games'
  s.homepage              =  'http://github.com/marlonandrade/guess-it-framework'
  s.author                =  { 
    'Marlon Andrade' => 'marlonmandrade@gmail.com' 
  }
  s.source                =  { 
    :git => 'https://github.com/marlonandrade/guess-it-framework.git', 
    :branch => 'master' 
  }
  s.license               = { 
    :type => 'Commercial',
    :file => 'LICENSE' 
  }
  
  s.platform              = :ios
  s.requires_arc          = true
  s.ios.deployment_target = '6.0'

  s.source_files          = 'GuessIt/**/*.{h,m}'
  s.resources             = [
    'Resources/localization/*.{lproj}', 
    'Resources/fonts/*', 
    'Resources/sounds/*', 
    'Resources/images/*',
    'vendor/mobfox/MRAID.bundle'
  ]

  s.frameworks            = ['MediaPlayer', 'CoreLocation', 'AdSupport', 'StoreKit', 'iAd', 'Social']

  s.vendored_libraries = [
    'vendor/mobfox/libGoogleAdMobAdapter_MobFoxSDK_iOS_4.1.6.a',
    'vendor/iad/libAdapterIAd.a',
    'vendor/flurry/libFlurry_4.2.3.a',
    'vendor/flurry/libFlurryAds_4.2.3.a',
    'vendor/flurry/libAdapterSDKFlurryAppCircle.a'
  ]

  s.dependency 'SSToolkit'
  s.dependency 'MALazykit'
  s.dependency 'MASimplestSemiModalViewController'
  s.dependency 'uiview-frame-helpers'
  s.dependency 'UIView+EasingFunctions', '~> 0.0.1'
  s.dependency 'AHEasing', '~> 1.1'
  s.dependency 'UAModalPanel'
  s.dependency 'Finch', '~> 0.1'
  s.dependency 'AdMob'
  s.dependency 'AFNetworking', '1.3.1'
  s.dependency 'CargoBay'
  s.dependency 'FontAwesome+iOS'
  
end
