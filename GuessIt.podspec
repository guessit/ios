Pod::Spec.new do |s|
  s.name         =  'GuessIt'
  s.version      =  '0.1'
  s.summary      =  'GuessIt is a framework for creating guessing games'
  s.homepage     =  'http://github.com/marlonandrade/guess-it-framework'
  s.author       =  { 
    'Marlon Andrade' => 'marlonmandrade@gmail.com' 
  }
  s.source       =  { 
    :git => 'https://github.com/marlonandrade/guess-it-framework.git', 
    :branch => 'master' 
  }
  s.license      = { 
    :type => 'Commercial',
    :file => 'LICENSE' 
  }
  
  s.platform = :ios
  s.requires_arc = true
  s.ios.deployment_target = '6.0'

  s.source_files = 'GuessIt/**/*.{h,m}'
  s.resources = 'Resources/**/*'
  
  s.dependency 'SSToolkit'
  s.dependency 'MALazykit'
  s.dependency 'KNSemiModalViewController'
  s.dependency 'uiview-frame-helpers'
  s.dependency 'UIView+EasingFunctions', '~> 0.0.1'
  s.dependency 'AHEasing', '~> 1.1'
  
end
