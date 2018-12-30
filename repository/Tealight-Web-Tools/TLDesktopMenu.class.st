"
Desktop menu
"
Class {
	#name : #TLDesktopMenu,
	#superclass : #Object,
	#category : 'Tealight-Web-Tools-Desktop'
}

{ #category : #'private - accessing' }
TLDesktopMenu class >> mainMenuSymbol [

	^#'Tealight'
]

{ #category : #'world menu' }
TLDesktopMenu class >> menuCommandOn: aBuilder [ 
	<worldMenu>
	
	| parent |
	parent := self mainMenuSymbol.
	(aBuilder item: parent)
		order: 3.0; 	 
		icon: (TLIconCache appIcon).
	aBuilder withSeparatorAfter .	
		
	 
]

{ #category : #'world menu' }
TLDesktopMenu class >> serverMenuCommandOn: aBuilder [ 
	<worldMenu>
	
	|parent|
	parent := self mainMenuSymbol.
	(aBuilder item: #'Webserver')
		parent: parent;
		order: 2;	
		icon: TLIconCache serverIcon.
	
	(aBuilder item: #'Start webserver')
		parent: #'Webserver';
		icon: TLIconCache serverStartIcon;
		action: [ TLWebserver start ].
	
	(aBuilder item: #'Stop webserver')
		parent: #'Webserver';
		icon: TLIconCache serverStopIcon;
		action: [ TLWebserver stop ].
				
	aBuilder withSeparatorAfter.

	(aBuilder item: #'Browse')
		parent: #'Webserver';
		icon: TLIconCache serverIcon;
		action: [ TLWebserver browse ]			
]
