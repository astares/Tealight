tests
testCustomPrefix
	|cls|
	cls := self defaultTestClass.
	cls useAPIPrefix: '/myapp/api'.
	self assert: cls apiPrefix equals: '/myapp/api'