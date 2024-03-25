"
A book
"
Class {
	#name : #TLBook,
	#superclass : #Object,
	#instVars : [
		'id',
		'title'
	],
	#category : #'Tealight-Bookstore-Example-Base'
}

{ #category : #'instance creation' }
TLBook class >> id: anID title: aString [

	^ (self new)
			id: anID;
			title: aString;
			yourself
			
]

{ #category : #accessing }
TLBook >> id [

	^ id
]

{ #category : #accessing }
TLBook >> id: anObject [

	id := anObject
]

{ #category : #printing }
TLBook >> printOn: aStream [

	aStream 
		nextPutAll: self id asString;
		nextPut: $:;
		nextPutAll: self title asString
]

{ #category : #accessing }
TLBook >> title [

	^ title
]

{ #category : #accessing }
TLBook >> title: anObject [

	title := anObject
]
