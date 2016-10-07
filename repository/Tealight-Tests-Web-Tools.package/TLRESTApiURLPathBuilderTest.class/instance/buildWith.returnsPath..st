utilities
buildWith: aBlock returnsPath: expectedPath
	| builder |
	builder := self defaultTestClass new.
	aBlock value: builder.
	self assert: builder path equals: expectedPath
	