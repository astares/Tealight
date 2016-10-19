running
setUp
	"Setup the test"
	super setUp.
	backupAPIPrefix := self defaultTestClass apiPrefix.
	self defaultTestClass useStandardPrefix