private - utilities
installVersionedHook: httpMethod path: aString  pragma: aPragma

	| action route |
	action := Send
		message: aPragma methodSelector
		to: aPragma method methodClass.
	route := aString -> action.
	self teapot perform: (httpMethod , ':') asSymbol with: route

