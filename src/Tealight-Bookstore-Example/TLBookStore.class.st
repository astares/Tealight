"
A book store
"
Class {
	#name : #TLBookStore,
	#superclass : #Object,
	#instVars : [
		'books'
	],
	#classVars : [
		'Default'
	],
	#category : #'Tealight-Bookstore-Example-Base'
}

{ #category : #'accessing - instances and variables' }
TLBookStore class >> default [
	<sampleInstance>

	^ Default ifNil: [ Default := self new ]
]

{ #category : #'class initialization' }
TLBookStore class >> initialize [ 
	"Give an initial book"

	self default books add: (TLBook id: 1 title: 'Hitchhikers Guide to Tealight')
]

{ #category : #'class initialization' }
TLBookStore class >> reset [
	<script>
	
	Default := nil

]

{ #category : #accessing }
TLBookStore >> books [

	^ books ifNil: [ books := OrderedCollection new ]
]

{ #category : #accessing }
TLBookStore >> books: anObject [

	books := anObject
]
