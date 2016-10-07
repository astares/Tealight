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
                package: 'Tealight-Tests-Web-Tools' with: [ spec requires: #('Tealight-Web-Tools') ].
				spec
					group: 'Tools' with: #('Tealight-Web-Tools');
					group: 'Tests' with: #('Tealight-Tests-Web-Tools');
					group: 'all' with: #('Tests');
					group: 'default' with: #('all')
	]