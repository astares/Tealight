tests
testPrefixedPathBuilding
	self 
		buildWith: [:builder | 
			builder 
				apiPrefix: 'myPrefix';
				version: 'v1' ] 
		returnsPath: '/myPrefix/v1'