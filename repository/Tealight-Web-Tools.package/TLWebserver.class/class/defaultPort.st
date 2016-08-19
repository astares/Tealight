accessing
defaultPort
	"Return the default server port"
	
	^DefaultPort ifNil: [ DefaultPort := 8080 ]