private - utilities
pathFromPragma: aPragma version: aVersion
	^(self newPathBuilder)			
			version: aVersion;
			function: aPragma arguments third;
			path