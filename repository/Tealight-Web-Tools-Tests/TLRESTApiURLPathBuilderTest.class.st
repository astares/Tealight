"
A test class for TLRESTApiURLPathBuilder
"
Class {
	#name : #TLRESTApiURLPathBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'backupAPIPrefix'
	],
	#category : #'Tealight-Web-Tools-Tests-REST-API-Utilities'
}

{ #category : #utilities }
TLRESTApiURLPathBuilderTest >> buildWith: aBlock returnsPath: expectedPath [
	| builder |
	builder := self defaultTestClass new.
	aBlock value: builder.
	self assert: builder path equals: expectedPath
	
]

{ #category : #'private - accessing' }
TLRESTApiURLPathBuilderTest >> defaultTestClass [

	^TLRESTApiURLPathBuilder
]

{ #category : #running }
TLRESTApiURLPathBuilderTest >> setUp [
	"Setup the test"
	super setUp.
	backupAPIPrefix := self defaultTestClass apiPrefix.
	self defaultTestClass useStandardPrefix
]

{ #category : #running }
TLRESTApiURLPathBuilderTest >> tearDown [
	self defaultTestClass useAPIPrefix: backupAPIPrefix.
	super tearDown
]

{ #category : #tests }
TLRESTApiURLPathBuilderTest >> testCustomPrefix [
	|cls|
	cls := self defaultTestClass.
	cls useAPIPrefix: '/myapp/api'.
	self assert: cls apiPrefix equals: '/myapp/api'
]

{ #category : #tests }
TLRESTApiURLPathBuilderTest >> testEmptyPathBuilding [
	self 
		buildWith: [:builder | ] 
		returnsPath: '/api'
]

{ #category : #tests }
TLRESTApiURLPathBuilderTest >> testFullPathBuilding [
	self 
		buildWith: [:builder | 
			builder 
				apiPrefix: 'myapi';
				version: 'v1';
				function: 'foo' ] 
		returnsPath: '/myapi/v1/foo'
]

{ #category : #tests }
TLRESTApiURLPathBuilderTest >> testPrefixedPathBuilding [
	self 
		buildWith: [:builder | 
			builder 
				apiPrefix: 'myPrefix';
				version: 'v1' ] 
		returnsPath: '/myPrefix/v1'
]

{ #category : #tests }
TLRESTApiURLPathBuilderTest >> testSimplePathBuilding [
	self 
		buildWith: [:builder | 
 ] 
		returnsPath: '/api'
]

{ #category : #tests }
TLRESTApiURLPathBuilderTest >> testStandardPrefix [
	|cls|
	cls := self defaultTestClass.
	self assert: cls apiPrefix equals: 'api'
]

{ #category : #tests }
TLRESTApiURLPathBuilderTest >> testVersionedPathBuilding [
	self 
		buildWith: [:builder | 
			builder version: 'v1' ] 
		returnsPath: '/api/v1'
]
