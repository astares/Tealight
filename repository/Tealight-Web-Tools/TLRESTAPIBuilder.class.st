"
A simple utility class to build a REST API from methods


"
Class {
	#name : #TLRESTAPIBuilder,
	#superclass : #Object,
	#instVars : [
		'teapot'
	],
	#category : #'Tealight-Web-Tools-REST-API-Building'
}

{ #category : #accessing }
TLRESTAPIBuilder class >> allPragmas [
	"Return a collection of all the REST API pragmas"
	
	^ (PragmaCollector selectors: {self pragmaKeyword}) pragmas
]

{ #category : #building }
TLRESTAPIBuilder class >> buildAPI [
	"Build the API from the receiver and subclasses"
	<script>
	
	self buildAPIFor: self teapotRefreshed
]

{ #category : #building }
TLRESTAPIBuilder class >> buildAPIFor: aTeapot [

	"Build the API from the receiver and subclasses"

	<script>
	self withAllSubclassesDo: [ :each | (each on: aTeapot) build ]
]

{ #category : #'instance creation' }
TLRESTAPIBuilder class >> on: aTeapot [
	^ self new teapot: aTeapot; yourself
]

{ #category : #accessing }
TLRESTAPIBuilder class >> pragmaKeyword [
	"Return the Pragma keyword that is used to define a REST API"
	
	^#REST_API:pattern:
]

{ #category : #accessing }
TLRESTAPIBuilder class >> teapot [

	^TLWebserver teapot
]

{ #category : #accessing }
TLRESTAPIBuilder class >> teapotRefreshed [

	^TLWebserver teapotRefreshed 
]

{ #category : #accessing }
TLRESTAPIBuilder >> allPragmas [
	
	^ self class allPragmas
]

{ #category : #building }
TLRESTAPIBuilder >> build [

	"Build a regular API (unversioned) by installing a teapot route for each pragma definition"

	self allPragmas do: [ :each | 
		self
			installHook: each arguments first
			path: (self pathFromPragma: each)
			pragma: each ]
]

{ #category : #installing }
TLRESTAPIBuilder >> installHook: httpMethod path: aPath pragma: aPragma [

	"Install a dynamic route as a hook in the current teapot"

	| action route |
	action := Send
		          message: aPragma methodSelector
		          to: aPragma method methodClass instanceSide.
	route := aPath -> action.
	self teapot perform: (httpMethod , ':') asSymbol with: route
]

{ #category : #'private - factory' }
TLRESTAPIBuilder >> newPathBuilder [
	^ TLRESTApiURLPathBuilder new
]

{ #category : #'private - utilities' }
TLRESTAPIBuilder >> pathFromPragma: aPragma [
	^(self newPathBuilder)			
			function: aPragma arguments second;
			path
]

{ #category : #accessing }
TLRESTAPIBuilder >> pragmaKeyword [
	^ self class pragmaKeyword
]

{ #category : #accessing }
TLRESTAPIBuilder >> teapot [

	^ teapot
]

{ #category : #accessing }
TLRESTAPIBuilder >> teapot: anObject [

	teapot := anObject
]
