"
Utility class to build the REST API URL path

The path is built from 
  - an optional API prefix
  - an optional version
  - the actual path

  
"
Class {
	#name : #TLRESTApiURLPathBuilder,
	#superclass : #Object,
	#instVars : [
		'apiPrefix',
		'version',
		'function'
	],
	#classVars : [
		'APIPrefix'
	],
	#category : #'Tealight-Web-Tools-REST-API-Utilities'
}

{ #category : #accessing }
TLRESTApiURLPathBuilder class >> apiPrefix [
	"Return the API prefix"
	
	^APIPrefix 
]

{ #category : #'class initialization' }
TLRESTApiURLPathBuilder class >> initialize [
	"initializes the receiver"
	
	self useStandardPrefix
]

{ #category : #actions }
TLRESTApiURLPathBuilder class >> useAPIPrefix: aString [
	"Use the given string as API prefix"
	
	APIPrefix := aString
]

{ #category : #actions }
TLRESTApiURLPathBuilder class >> useStandardPrefix [
	"Use the standard API prefix"
	
	APIPrefix := 'api'
]

{ #category : #actions }
TLRESTApiURLPathBuilder class >> withoutPrefix [
	"Do not use any prefix"
		
	APIPrefix := ''
]

{ #category : #accessing }
TLRESTApiURLPathBuilder >> apiPrefix [

	^ apiPrefix
]

{ #category : #accessing }
TLRESTApiURLPathBuilder >> apiPrefix: anObject [

	apiPrefix := anObject
]

{ #category : #accessing }
TLRESTApiURLPathBuilder >> function [

	^ function
]

{ #category : #accessing }
TLRESTApiURLPathBuilder >> function: anObject [

	function := anObject
]

{ #category : #initialization }
TLRESTApiURLPathBuilder >> initialize [
	"Initializes the receiver"

	super initialize.
	apiPrefix := self class apiPrefix.
	version := String empty.
	function := String empty
]

{ #category : #accessing }
TLRESTApiURLPathBuilder >> path [

	^ String streamContents: [ :s |
		  self
			  write: self apiPrefix on: s;
			  write: self version on: s;
			  write: self function on: s ]
]

{ #category : #accessing }
TLRESTApiURLPathBuilder >> version [

	^ version
]

{ #category : #accessing }
TLRESTApiURLPathBuilder >> version: anObject [

	version := anObject
]

{ #category : #'private  - writing' }
TLRESTApiURLPathBuilder >> write: part on: aStream [

	part isEmpty ifTrue: [ ^ self ].
	(part beginsWith: '/') ifFalse: [ aStream nextPut: $/ ].
	aStream nextPutAll: part
]
