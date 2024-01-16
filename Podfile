platform :ios, '15.0'

def common_pod

  use_frameworks!

  # Rx
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'NSObject+Rx'
  
  # Cache
  pod 'Kingfisher'

end

def testing_pod
  use_frameworks!
  
  pod 'RxTest'
  
end

target 'iOSEngineerCodeCheck' do
  common_pod
end

target 'iOSEngineerCodeCheckTests' do
  inherit! :search_paths
  testing_pod
end
