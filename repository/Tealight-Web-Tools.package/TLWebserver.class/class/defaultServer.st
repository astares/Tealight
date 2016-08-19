accessing
defaultServer
	"Return the default server"
	
	^DefaultServer ifNil: [ DefaultServer := self new ]