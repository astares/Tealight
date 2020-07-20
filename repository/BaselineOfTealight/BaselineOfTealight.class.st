"
A baseline for Tealight project
"
Class {
	#name : #BaselineOfTealight,
	#superclass : #BaselineOf,
	#category : #BaselineOfTealight
}

{ #category : #baseline }
BaselineOfTealight >> baseline: spec [
    <baseline>
    spec
        for: #'common'
        do: [ 
				spec
                configuration: 'Teapot'
                   with: [
                       spec
                           versionString: #'stable';
                           repository: 'http://smalltalkhub.com/mc/zeroflag/Teapot/main' ].
				spec  
                package: 'Tealight-Web-Tools' with: [ spec requires: #('Teapot') ].
				spec  
                package: 'Tealight-Web-Tools-Tests' with: [ spec requires: #('Tealight-Web-Tools') ].
				spec
					group: 'Tools' with: #('Tealight-Web-Tools');
					group: 'Tests' with: #('Tealight-Web-Tools-Tests');
					group: 'all' with: #('Tests');
					group: 'default' with: #('all')
	]
]
