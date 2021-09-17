"
A simple utility class to build a REST API from methods


"
Class {
	#name : #TLRESTAPIBuilder,
	#superclass : #Object,
	#category : 'Tealight-Web-Tools-REST-API-Building'
}

{ #category : #'private - accessing' }
TLRESTAPIBuilder class >> allPragmas [
	"Return a collection of all the REST API pragmas"
	
	|col|
	col := (PragmaCollector new
				filter: [ :prg | prg key = self pragmaKeyword ])
				reset.
	^col collected

]

{ #category : #'private - building' }
TLRESTAPIBuilder class >> build [
	"Build a regular API (unversioned) by installing a teapot route for each pragma definition"

	self allPragmas do: [ :each | 
			self installHook: each arguments first path: (self pathFromPragma: each) pragma: each ]
]

{ #category : #building }
TLRESTAPIBuilder class >> buildAPI [
	"Build the API from the receiver and subclasses"
	<script>
	
	self withAllSubclassesDo: [:each | each build ]

]

{ #category : #'private - utilities' }
TLRESTAPIBuilder class >> installHook: httpMethod path: aPath pragma: aPragma [

	"Install a dynamic route as a hook in the current teapot"

	| action route |
	action := Send
		          message: aPragma methodSelector
		          to: aPragma method methodClass instanceSide.
	route := aPath -> action.
	self teapot perform: (httpMethod , ':') asSymbol with: route
]

{ #category : #'private - accessing' }
TLRESTAPIBuilder class >> newPathBuilder [
	^ TLRESTApiURLPathBuilder new
]

{ #category : #'private - utilities' }
TLRESTAPIBuilder class >> pathFromPragma: aPragma [
	^(self newPathBuilder)			
			function: aPragma arguments second;
			path
]

{ #category : #'private - accessing' }
TLRESTAPIBuilder class >> pragmaKeyword [
	"Return the Pragma keyword that is used to define a REST API"
	
	^#REST_API:pattern:
]

{ #category : #'private - accessing' }
TLRESTAPIBuilder class >> teapot [

	^TLWebserver teapot 
]
