"
A REST API for the book store

openapi: 3.0.3
info:
  title: Tealight Bookstore Example
  description: >-
    This is a simple example for an OpenAPI description file to be used with
    Teapot/Tealight
  termsOfService: http://www.pharo.org/community/
  contact:
    email: info@pharo.org
  license:
    name: MIT License
    url: https://opensource.org/license/mit
  version: 1.0.0
externalDocs:
  description: Learn about Teapot/Tealight
  url: https://github.com/astares/Tealight
servers:
  - url: http://localhost:9094/api/v1
  - url: http://localhost/api/v1
tags:
  - name: Common
    description: General infos
paths:
  /version:
    get:
      tags:
        - Common
      summary: Version Info
      description: Retrieve the version
      operationId: versionInfo
      responses:
        '200':
          description: Successful operation
  /books:
    get:
      tags:
        - Common
      summary: Book Info
      description: Retrieve the collection of books
      operationId: bookRetrieval
      responses:
        '200':
          description: Successful operation
  /book:        
    post:
      summary: store book
      description: Storing a book
      operationId: storeBook
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                id:
                  type: integer
                title:
                  type: string
      responses:
        default:
          description: Default error sample response
      tags:
        - Common

"
Class {
	#name : #TLBookStoreRestAPI,
	#superclass : #Object,
	#category : #'Tealight-Bookstore-Example-API'
}

{ #category : #common }
TLBookStoreRestAPI class >> book: aRequest [
	<REST_API: 'POST' versions: #('v1') pattern: 'book'>
	
	|dic newBook|
	dic := STON fromString: aRequest entity contents.
	newBook := TLBook id: (dic at: #id) asInteger title: (dic at: #title).	
	TLBookStore default books add: newBook.
	^ TeaResponse ok
	
]

{ #category : #common }
TLBookStoreRestAPI class >> books: aRequest [
	<REST_API: 'GET' versions: #('v1') pattern: 'books'>
	
	^ self jsonResponse: self jsonForBooks
]

{ #category : #utilities }
TLBookStoreRestAPI class >> generateAPI [
	<script>

	TLRESTAPIBuilder buildAPI.
	TLWebserver teapot.
	TLWebserver start
	  
]

{ #category : #'private - books' }
TLBookStoreRestAPI class >> jsonForBook: each [
	"Return a JSON string for the given book. Typically one would use NeoJSON"

	^ '\{ id: "{1}", title: "{2}" \}"' format: (Array with: each id with: each title)
]

{ #category : #'private - books' }
TLBookStoreRestAPI class >> jsonForBooks [
	"Write manually a JSON for the books. Typically one would use NeoJSON."
	<sampleInstance>

	^ String streamContents: [ :s |
		  s nextPut: $[.
		  TLBookStore default books
			  do: [ :each | s nextPutAll: (self jsonForBook: each) ]
			  separatedBy: [ s nextPut: $, ].
		  s nextPut: $] ]
]

{ #category : #private }
TLBookStoreRestAPI class >> jsonResponse: aJsonString [

	^ ZnResponse new
        statusLine: ZnStatusLine ok;        
        entity: (ZnEntity json: aJsonString);
        yourself  
]

{ #category : #common }
TLBookStoreRestAPI class >> version: aRequest [
	<REST_API: 'GET' versions: #('v1') pattern: 'version'>
	
	^ self jsonResponse: '{ version: "1.0.0" }'
]
