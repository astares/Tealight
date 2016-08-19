baseline
baseline: spec
    <baseline>
    spec
        for: #'common'
        do: [ 
            spec
                configuration: 'WebBrowser'
                   with: [
                       spec
                           versionString: #'stable';
                           repository: 'http://smalltalkhub.com/mc/TorstenBergmann/WebBrowser/main' ];
                yourself.
				spec
                configuration: 'Teapot'
                   with: [
                       spec
                           versionString: #'stable';
                           repository: 'http://smalltalkhub.com/mc/zeroflag/Teapot/main' ];
                yourself.
				spec  
                package: 'Tealight-Web-Tools' with: [ spec requires: #('WebBrowser' 'Teapot') ].

				spec
                group: 'default' with: #('Tealight-Web-Tools')
	]