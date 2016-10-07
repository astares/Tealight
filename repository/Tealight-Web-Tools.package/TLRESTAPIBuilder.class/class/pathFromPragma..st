private - utilities
pathFromPragma: aPragma
	^(self newPathBuilder)			
			function: aPragma arguments second;
			path