tests
testVersionedPathBuilding
	self 
		buildWith: [:builder | 
			builder version: 'v1' ] 
		returnsPath: '/api/v1'