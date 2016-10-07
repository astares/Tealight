tests
testFullPathBuilding
	self 
		buildWith: [:builder | 
			builder 
				apiPrefix: 'myapi';
				version: 'v1';
				function: 'foo' ] 
		returnsPath: '/myapi/v1/foo'