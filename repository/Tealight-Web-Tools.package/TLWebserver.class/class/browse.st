operating
browse
	<script>
	|baseURL|
	baseURL := 'http://localhost'.
	self defaultPort = 80 ifFalse: [ baseURL := baseURL ,':' , self defaultPort asString].
	WebBrowser openOn: baseURL.