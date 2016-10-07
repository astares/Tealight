initialization
initialize
	"Initializes the receiver"
	super initialize.
	apiPrefix := self class apiPrefix.
	version := String empty.
	function := String empty.