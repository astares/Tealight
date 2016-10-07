building
buildAPI
	"Build the API from the receiver and subclasses"
	<script>
	
	self withAllSubclassesDo: [:each | each build ]
