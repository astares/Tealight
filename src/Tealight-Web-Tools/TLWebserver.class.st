"
The Tealight server
"
Class {
	#name : #TLWebserver,
	#superclass : #Object,
	#instVars : [
		'teapot',
		'configuration'
	],
	#classVars : [
		'DefaultPort',
		'DefaultServer'
	],
	#category : #'Tealight-Web-Tools-Runtime'
}

{ #category : #defaults }
TLWebserver class >> defaultConfiguration [
	"Override to set more default values"

	^ { (#port -> self defaultPort) }
]

{ #category : #defaults }
TLWebserver class >> defaultPort [
	"Return the default server port"

	^DefaultPort ifNil: [ DefaultPort := 8080 ]
]

{ #category : #defaults }
TLWebserver class >> defaultPort: anInteger [
	"Sets the default server port"

	DefaultPort := anInteger
]

{ #category : #defaults }
TLWebserver class >> defaultServer [
	"Return the default server"

	DefaultServer ifNil: [ self installAsDefaultServer ].
	^DefaultServer
]

{ #category : #defaults }
TLWebserver class >> defaultServer: aTLWebServer [

	DefaultServer := aTLWebServer
]

{ #category : #'class initialization' }
TLWebserver class >> initialize [

	DefaultPort := nil.
	DefaultServer := nil
]

{ #category : #private }
TLWebserver class >> installAsDefaultServer [

	self defaultServer: self new
]

{ #category : #operating }
TLWebserver class >> openWebbrowser [
	<script>

	| baseURL |
	baseURL := 'http://localhost'.
	self defaultPort = 80 ifFalse: [
		baseURL := baseURL , ':' , self defaultPort asString ].
	WebBrowser openOn: baseURL
]

{ #category : #running }
TLWebserver class >> start [
	"Start the server"
	<script>

	^self defaultServer start
]

{ #category : #running }
TLWebserver class >> startOn: aPort [
	"start on the given port"

	self
		defaultPort: aPort;
		start
]

{ #category : #running }
TLWebserver class >> stop [
	"Stop the server"
	<script>

	^ self defaultServer stop
]

{ #category : #accessing }
TLWebserver class >> teapot [

	^ self defaultServer teapot
]

{ #category : #accessing }
TLWebserver class >> teapotRefreshed [

	^ self defaultServer refreshTeapot
]

{ #category : #accessing }
TLWebserver >> configuration [

	^ configuration ifNil: [
		  configuration := self class defaultConfiguration ]
]

{ #category : #accessing }
TLWebserver >> configuration: anObject [

	configuration := anObject
]

{ #category : #'private - initialization' }
TLWebserver >> initTeapot [

	teapot := Teapot configure: self configuration
]

{ #category : #initialization }
TLWebserver >> initialize [

	super initialize.
	self initTeapot
]

{ #category : #testing }
TLWebserver >> isRunning [

	^ self teapot server isRunning
]

{ #category : #printing }
TLWebserver >> printOn: aStream [

	aStream nextPutAll: 'a '.
	aStream nextPutAll: self className.
	aStream nextPut: $(.
	aStream nextPutAll: (self isRunning
			 ifTrue: [ 'running' ]
			 ifFalse: [ 'stopped' ]).
	aStream nextPut: $).
	self configuration printOn: aStream
]

{ #category : #initialization }
TLWebserver >> refreshTeapot [

	self teapot server isRunning ifTrue: [ self stop ].
	self initTeapot.
	^ self teapot
]

{ #category : #running }
TLWebserver >> start [

	self teapot start
]

{ #category : #running }
TLWebserver >> stop [

	self teapot stop
]

{ #category : #accessing }
TLWebserver >> teapot [

	^ teapot
]
