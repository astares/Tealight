private - building
build
	"Build a regular API (unversioned) by installing a teapot route for each pragma definition"

	self allPragmas do: [ :each | 
			each arguments second do: [:version |
				self installHook: each arguments first path: (self pathFromPragma: each version: version) pragma: each ] ]