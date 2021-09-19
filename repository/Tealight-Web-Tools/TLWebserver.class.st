"
The Tealight server
"
Class {
	#name : #TLWebserver,
	#superclass : #Object,
	#instVars : [
		'teapot'
	],
	#classVars : [
		'DefaultPort',
		'DefaultServer'
	],
	#category : #'Tealight-Web-Tools-Runtime'
}

{ #category : #operating }
TLWebserver class >> browse [
	<script>
	|baseURL|
	baseURL := 'http://localhost'.
	self defaultPort = 80 ifFalse: [ baseURL := baseURL ,':' , self defaultPort asString].
	WebBrowser openOn: baseURL.
]

{ #category : #accessing }
TLWebserver class >> defaultPort [
	"Return the default server port"
	
	^DefaultPort ifNil: [ DefaultPort := 8080 ]
]

{ #category : #accessing }
TLWebserver class >> defaultPort: anInteger [
	"Sets the default server port"
	
	DefaultPort := anInteger 
]

{ #category : #accessing }
TLWebserver class >> defaultServer [
	"Return the default server"
	
	^DefaultServer ifNil: [ DefaultServer := self new ]
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
	
	^self defaultServer stop
]

{ #category : #accessing }
TLWebserver class >> teapot [

	^self defaultServer teapot
]

{ #category : #accessing }
TLWebserver class >> teapotRefreshed [

	^self defaultServer refreshTeapot
]

{ #category : #'private - initialization' }
TLWebserver >> initTeapot [

	teapot := Teapot configure: {
		#port -> self class defaultPort
 	}
]

{ #category : #initialization }
TLWebserver >> initialize [

	super initialize.
	self initTeapot
]

{ #category : #initialization }
TLWebserver >> refreshTeapot [
	self teapot server isRunning ifTrue: [ self stop ].
	self initTeapot.
	^ self teapot
]

{ #category : #running }
TLWebserver >> start [

	teapot start
]

{ #category : #running }
TLWebserver >> stop [

	teapot stop
]

{ #category : #accessing }
TLWebserver >> teapot [

	^teapot
]
