"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestTealightWebTools,
	#superclass : #PackageManifest,
	#category : #'Tealight-Web-Tools-Manifest'
}

{ #category : #'code-critics' }
ManifestTealightWebTools class >> ruleBadMessageRule2V1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#'TLIconCache class' #iconNamed: #true)) #'2023-09-21T16:42:44.549902+02:00') )
]

{ #category : #'code-critics' }
ManifestTealightWebTools class >> ruleLiteralArrayContainsSuspiciousTrueFalseOrNilRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMetaclassDefinition #(#'ManifestTealightWebTools class' #ManifestTealightWebTools)) #'2023-09-21T16:42:55.172919+02:00') )
]
