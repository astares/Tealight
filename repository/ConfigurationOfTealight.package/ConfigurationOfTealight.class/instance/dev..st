versions
dev: spec
	<version: 'dev'>

	spec for: #'common' do: [ 
		spec blessing: #'development'.
		spec
			baseline: 'Tealight' with: [ 
				spec 
					className: 'BaselineOfTealight';
					repository: 'github://astares/Tealight:master/repository' ]].