accessing
iconNamed: aSymbol
	"Returns the icon with the given name"

	^ self iconCache
		at: aSymbol
		ifAbsentPut: [ 
			Form
				fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: (self perform: (aSymbol , 'Contents') asSymbol) readStream) ]