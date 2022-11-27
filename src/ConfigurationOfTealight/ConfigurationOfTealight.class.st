"
Configuration for GitHub API
"
Class {
	#name : #ConfigurationOfTealight,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : 'ConfigurationOfTealight'
}

{ #category : #'development support' }
ConfigurationOfTealight class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>
]

{ #category : #private }
ConfigurationOfTealight class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #'ConfigurationOf'
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #'ConfigurationOf' ifAbsent: aBlock ].
]

{ #category : #catalog }
ConfigurationOfTealight class >> catalogChangeLog [
	"Returns a paragraph describing the most important changes in the configuration class."
	^ ''
]

{ #category : #catalog }
ConfigurationOfTealight class >> catalogContactInfo [
	"Returns a paragraph describing contact information such as email, mailing lists and website."
	^ ''
]

{ #category : #catalog }
ConfigurationOfTealight class >> catalogDescription [
	"Returns a paragraph describing the project"
	^ 'Tealight is a project defining a few extensions to the Teapot framework to make the (tea) time you spend with the Pharo Teapot system even easier..'
]

{ #category : #catalog }
ConfigurationOfTealight class >> catalogKeyClassesAndExample [
	"Returns a paragraph or more describing the key classes of your project. You can use Pillar/Pier syntax to layout out the text i.e., ==Code== and - for bullet."
	^ ''
]

{ #category : #catalog }
ConfigurationOfTealight class >> catalogKeywords [
	"Returns an array of symbols"
	^ #(git github api) 
]

{ #category : #private }
ConfigurationOfTealight class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfTealight class >> ensureMetacelloBaseConfiguration [
  Smalltalk
    at: #'ConfigurationOf'
    ifAbsent: [ 
      | repository version |
      repository := MCHttpRepository
        location: 'http://smalltalkhub.com/mc/dkh/metacello/main'
        user: ''
        password: ''.
      repository
        versionReaderForFileNamed: 'Metacello-Base-dkh.107'
        do: [ :reader | 
          version := reader version.
          version load.
          version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfTealight class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfTealight class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfTealight class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfTealight class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfTealight class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfTealight class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #accessing }
ConfigurationOfTealight >> customProjectAttributes [
    "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes "

    ^ #()
]

{ #category : #versions }
ConfigurationOfTealight >> dev: spec [
	<version: 'dev'>

	spec for: #'common' do: [ 
		spec blessing: #'development'.
		spec
			baseline: 'Tealight' with: [ 
				spec 
					className: 'BaselineOfTealight';
					repository: 'github://astares/Tealight:master/repository' ]].
]

{ #category : #'symbolic versions' }
ConfigurationOfTealight >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: 'dev'.

]

{ #category : #accessing }
ConfigurationOfTealight >> project [
    ^ project
        ifNil: [ 
            "Bootstrap Metacello if it is not already loaded"
            self class ensureMetacello.
            project := MetacelloMCProject new projectAttributes: self customProjectAttributes.	"Create the Metacello project"
            (Smalltalk at: #'MetacelloVersionConstructor') on: self project: project.	"Construct the project"
            project loadType: #'linear'.	"change to #atomic if desired"
            project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfTealight >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '0.0.3'.
	spec for: #'pharo5.x' version: '0.0.3'.
	spec for: #'pharo6.x' version: '0.0.3'.	
]

{ #category : #versions }
ConfigurationOfTealight >> v0_0_1: spec [
	<version: '0.0.1'>

	spec for: #'common' do: [ 
		spec blessing: #'stable'.
		spec
			baseline: 'Tealight' with: [ 
				spec 
					className: 'BaselineOfTealight';
					repository: 'github://astares/Tealight:0.0.1/repository' ]]
]

{ #category : #versions }
ConfigurationOfTealight >> v0_0_2: spec [
	<version: '0.0.2'>

	spec for: #'common' do: [ 
		spec blessing: #'stable'.
		spec
			baseline: 'Tealight' with: [ 
				spec 
					className: 'BaselineOfTealight';
					repository: 'github://astares/Tealight:0.0.2/repository' ]]
]

{ #category : #versions }
ConfigurationOfTealight >> v0_0_3: spec [
	<version: '0.0.3'>

	spec for: #'common' do: [ 
		spec blessing: #'stable'.
		spec
			baseline: 'Tealight' with: [ 
				spec 
					className: 'BaselineOfTealight';
					repository: 'github://astares/Tealight:0.0.3/repository' ]]
]
