tests
testStandardPrefix
	|cls|
	cls := self defaultTestClass.
	self assert: cls apiPrefix equals: 'api'