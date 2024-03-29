"
An API builder for a versioned REST API
"
Class {
	#name : #TLVersionedRESTAPIBuilder,
	#superclass : #TLRESTAPIBuilder,
	#category : #'Tealight-Web-Tools-REST-API-Building'
}

{ #category : #accessing }
TLVersionedRESTAPIBuilder class >> pragmaKeyword [
	"Return the Pragma keyword that is used to define a versioned REST API"

	^ #REST_API:versions:pattern:
]

{ #category : #building }
TLVersionedRESTAPIBuilder >> build [
	"Build a regular API (unversioned) by installing a teapot route for each pragma definition"

	self allPragmas do: [ :each |
		each arguments second do: [ :version |
			self
				installHook: each arguments first
				path: (self pathFromPragma: each version: version)
				pragma: each ] ]
]

{ #category : #'private - utilities' }
TLVersionedRESTAPIBuilder >> pathFromPragma: aPragma [

	^ self newPathBuilder
		  version: aPragma arguments second;
		  function: aPragma arguments third;
		  path
]

{ #category : #'private - utilities' }
TLVersionedRESTAPIBuilder >> pathFromPragma: aPragma version: aVersion [

	^ self newPathBuilder
		  version: aVersion;
		  function: aPragma arguments third;
		  path
]
