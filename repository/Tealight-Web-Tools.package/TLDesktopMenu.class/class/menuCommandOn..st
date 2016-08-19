world menu
menuCommandOn: aBuilder 
	<worldMenu>
	
	| parent |
	parent := self mainMenuSymbol.
	(aBuilder item: parent)
		order: 3.0; 	 
		icon: (TLIconCache appIcon).
	aBuilder withSeparatorAfter .	
		
	 