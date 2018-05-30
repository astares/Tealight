accessing
iconNamed: aSymbol
	"Returns the icon with the given name"

	(self class canUnderstand: aSymbol) ifFalse: [ ^super iconNamed: aSymbol ].
	^ self iconCache
		at: aSymbol
		ifAbsentPut: [ 
			Form
				fromBinaryStream: (self perform: (aSymbol , 'Contents') asSymbol) base64Decoded readStream ]