
Pod::Spec.new do |s|
	
	s.name             = "XCGCrashlyticsLogDestination"
	
	s.version          = "0.0.1"
	s.summary          = "Initial release"
	
	s.homepage         = "https://github.com/nekrich/XCGCrashlyticsLogDestination"
	s.license          = { :type => "MIT", :file => "LICENSE" }
	s.author           = { "Vitalii Budnik" => "inekrich@me.com" }
	s.source           = { :git => "https://github.com/nekrich/XCGCrashlyticsLogDestination.git", :tag => "#{s.version}" }
	
	s.social_media_url = "https://twitter.com/iNekrich"
	
	s.platform         = :ios, "8.0"
	s.requires_arc     = true
	
	s.source_files     = "Source/**/*.{swift}"
	
	s.dependency "XCGLogger"
	s.dependency "Crashlytics"
	
	s.ios.pod_target_xcconfig = {
		'FRAMEWORK_SEARCH_PATHS' => '$(inherited) "${PODS_ROOT}/Crashlytics/iOS"',
		'OTHER_LDFLAGS'          => '$(inherited) -undefined dynamic_lookup',
		'ENABLE_BITCODE'         => 'NO'
	}
	
end
