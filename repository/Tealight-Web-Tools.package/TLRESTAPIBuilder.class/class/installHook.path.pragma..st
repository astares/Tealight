private - utilities
installHook: httpMethod path: aPath pragma: aPragma  
	"Install a dynamic route as a hook in the current teapot"
	| action route |
	action := Send
					message: aPragma methodSelector
					to: aPragma method methodClass.
	route := aPath -> action.
	self teapot 
				perform: (httpMethod , ':') asSymbol with: route

