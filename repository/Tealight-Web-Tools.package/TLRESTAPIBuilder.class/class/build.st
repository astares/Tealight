private - building
build
 	"Build a regular API (unversioned) by installing a teapot route for each pragma definition"
	
	self allPragmas do: [:each | 
		self installHook: each arguments first path: each arguments second pragma: each ]
