private - utilities
pathFromPragma: aPragma
	^(self newPathBuilder)			
			version: aPragma arguments second;
			function: aPragma arguments third;
			path