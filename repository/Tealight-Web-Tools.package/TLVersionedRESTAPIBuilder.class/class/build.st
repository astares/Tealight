private - building
build
 	"Build a versioned API by installing a teapot route for each pragma definition"
	|delimiter|
	self allPragmas do: [:each | 
		each arguments second  do: [:version |
			delimiter := (each arguments third beginsWith: '/')
							ifTrue: [ String empty ]
							ifFalse: [ '/' ]. 			
			self installVersionedHook: each arguments first path: ('/',version, delimiter, each arguments third) pragma: each ]]