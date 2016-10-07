accessing
path

	^String streamContents: [:s | 
		self 
			write: self apiPrefix on: s;
			write: self version on: s;
			write: self function on: s
	 ].
