private - accessing
allPragmas
	"Return a collection of all the REST API pragmas"
	
	|col|
	col := (PragmaCollector new
				filter: [ :prg | prg keyword = self pragmaKeyword ])
				reset.
	^col collected
