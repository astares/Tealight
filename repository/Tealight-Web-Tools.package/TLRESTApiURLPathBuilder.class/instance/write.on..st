private  - writing
write: part on: aStream
	part isEmpty ifTrue: [ ^self ].
	(part beginsWith: '/')
		ifFalse: [ aStream nextPut: $/ ].
	aStream nextPutAll: part	