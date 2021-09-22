"
Utility class for caching icons (preventing unnnecessary instances of Forms).

 
"
Class {
	#name : #TLIconCache,
	#superclass : #Object,
	#classVars : [
		'IconCache'
	],
	#classInstVars : [
		''
	],
	#category : #'Tealight-Web-Tools-Utilities'
}

{ #category : #icons }
TLIconCache class >> appIcon [
	<script: 'self appIcon inspect'>

	^self iconNamed: #appIcon
]

{ #category : #'private - icons' }
TLIconCache class >> appIconContents [

	^'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABs0lEQVR42mNkIAJ0rzj4/+Gj
Kwx8AtIMbWkBjMhyjMQYsGTWrP/RzhwMt84/Z3ipHMZgZ6jISLQBR87d+/9o6UwG7V8PGF7/
ZGV47JzMkBjuSLwBq3ec+f+2MpaBi/EfA8P/fwxfsvsYslJ8iTPg0Nk7//dt2cPAsWk6g8C/
HwxvP3xi+B9awGDq68XgbqvLSNCAHUeu/t9QU8Eg+eIqwz82DobvLx4z/FY1Y3Brn8DgaUeE
ASCwds/F/7sbShn+P7vD8FPLlsEzO5ch3NOE+DBonbrh/4VNqxl0PP0ZvFwsGEx15EiLxsbZ
u/4bqUkx6KtKMRy5cJfh4r2XDJ05PsS7ABwWx278X739JMPFI4cZFLR1GNZMKSDegP7lR/7P
X3+U4d+PrwwGusoMmSG2DNaGSsQboJO98r+aEDNDpIMaQ6izHoZ6vAbsP3vv/7l7bxiKQ83g
6rKmHfrvZyzJ4GGuSlw0wkDXmtP/1z/8y/DoHw9DhyEDQ6yLDnEG9G268H/5K1aGRxxCDAx/
/jLofX/JsDvTmLgwqFt74f9MBlkGxh8/GHR/vGbwFvnHUOBvhKIHACf7oBFVIpg+AAAAAElF
TkSuQmCC'
]

{ #category : #generate }
TLIconCache class >> generateIcon [
	<script>
	
	| base64Contents fileName contentsMethod iconMethod iconName |  
	fileName := UIManager default chooseFullFileNameMatching: #('png') label: 'Icon file'.
	fileName ifNil: [ ^ self ].
	iconName := UIManager default request: 'Icon name' initialAnswer: 'blank'.
	iconName ifNil: [ ^ self ].
	base64Contents := (Base64MimeConverter mimeEncode: fileName binary) contents.
	fileName close.
	contentsMethod := String
		streamContents: [ :s | 
			s
				nextPutAll: iconName;
				nextPutAll: 'IconContents';
				cr;
				cr;
				tab;
				nextPut: $^;
				nextPut: $';
				nextPutAll: base64Contents;
				nextPut: $' ].
	iconMethod := String
		streamContents: [ :s | 
			s
				nextPutAll: iconName;
				nextPutAll: 'Icon';
				cr;
				tab;
				nextPutAll: '<script: ''self ';
				nextPutAll: iconName;
				nextPutAll: 'Icon';
				nextPutAll: ' inspect''>';
				cr;
				cr;
				tab;
				nextPutAll: '^self iconNamed: #';
				nextPutAll: iconName;
				nextPutAll: 'Icon' ].
	self class compile: contentsMethod classified: #'private - icons'.
	self class compile: iconMethod classified: #icons
]

{ #category : #'private - accessing' }
TLIconCache class >> iconCache [

	^ IconCache ifNil: [ IconCache := Dictionary new ]
]

{ #category : #accessing }
TLIconCache class >> iconNamed: aSymbol [
	"Returns the icon with the given name"

	(self class canUnderstand: aSymbol) ifFalse: [ ^super iconNamed: aSymbol ].
	^ self iconCache
		at: aSymbol
		ifAbsentPut: [ 
			Form
				fromBinaryStream: (self perform: (aSymbol , 'Contents') asSymbol) base64Decoded readStream ]
]

{ #category : #'initialization-release' }
TLIconCache class >> reset [
	"Reset the icon cache"	
	<script>
	
	IconCache := nil
]

{ #category : #icons }
TLIconCache class >> serverIcon [
	<script: 'self serverIcon inspect'>

	^self iconNamed: #serverIcon
]

{ #category : #'private - icons' }
TLIconCache class >> serverIconContents [

	^'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAC0UlEQVR4Xo2SbU+SURzG+RS2
hDdufQBtM0e58GHa8o2W3mbWkjbLhzURTTNEHnwowNKG2oM6JUWF2+fHTJ2aJaFCPlAzJygG
OMPM8qF8wqtbXli2rK7t2v7n7Fy/c8520fbk4nKEkZkpIUViKckXSEj9qBEjehNG3kxDILxL
enoyCVdXVwbtMHl7s4hJ4ypsi1uUHbDad2Fz2kGtd2G2bWBIZ0Jz6wvLHtDL69RBIIvlS2hG
FqEbW4FhcgWmuU0YzduYNu9QswOmDw7MWhwUaAe2Tw7M29dxIyGV3Af4+voR3X1mDAwuoLd/
Hl09c9Q8D/34MgVcxYz1O+yft2Ff3sTYWxvKK/oRxU44CGhpe4/Orlm0tk+joWkS6toJ1KhH
oax5jdLyPsgLn0GUrUZMnBTnw64jPj7lIEBNjqK+8R1U5DiU1XqUP9WitGwQfEEJMgRS5D8o
hrJKjampKQhF9+HjG8j9BeBPlCk0qFDqUKbQ4knJSzwsom6Vd1N/lcJgMGBraxvf1jfw5es6
4mJvwfMEk9gHBAaeIeQFXXhcPIDCwl7k5z9HrqwDUkkL2Ox0aLXDWFvbwsLCMmZm7QgJYeNs
UNBPgLu7B1MirUdeXidk0nbkZDdBLKqjXIuIiBS0tXXBal2C0bSEVxoTgoOjQGfQD/YiLU1M
ioQqZ1AoUEOQoYZISCI8PBnVNc2YMFiocpnR1jEM9lUO/lioa9FJZDqvygnYsxNwIQmKikYq
bMGAZgbquh4kcsU4tJUyWYklg6/aBxDhXBQ9UkE3/hGDQzNIThUg5BxbcyjgKFVRHk9uEWSo
nIAwgoukm3eo0CW4uR1DQEAktRdN0v4md4/jTA4n17L3ipjYe2D5ROK0z0VcTuSBL6zElajY
PNq/5OcfQGRlKZHAKaLal4/bPAXkBa3IypZr6HQ6g/Y/8vI6SVRW9qChUYPsnCJNaGgE9/cz
PwCyhvLlWzqQAwAAAABJRU5ErkJggg=='
]

{ #category : #icons }
TLIconCache class >> serverStartIcon [
	<script: 'self serverStartIcon inspect'>
	
	^self iconNamed: #serverStartIcon
]

{ #category : #'private - icons' }
TLIconCache class >> serverStartIconContents [

	^'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAADR0lEQVR4Xn2T71fTZRyG+S80
4RV56k3Hc6jciTpHICnNOnVYfCWhCZiiCAxGlEbbhCg2TjQdIYlCwWIIU0crDhAiiOA8xL6B
4kFqG7+22QYRHCL5Nbia7ByOnNPpc859zvPmup7nOef+hDw5JzOydQWfaU0qtdYkDjro/9VJ
v2in8lKdVaMtNUkkksiQ/xtr3ygu3yqe6TU8U4+zHjgHM/FwmT5xFMtP3S71GY1JocjT7dgR
GrZF0NH1O+LdBe7en8c+tohzfBXHmB/HhB/n5BpjrkA8fh4GLnB7/0aRm2/aImhpG6LH6qOz
20N7xwQ3ezzYBv/i3vBCAF7CN7PK1NwyA0Muqr69wcmMj7cKmiw22q6P09xip8nyANPVIeob
Bqhv/IXq7zopK2+l4PNG0k5oiBfSSUxM1W0RNDRaMf8wTOOVe9TVi9QY+rhY1UthkQGlUsPZ
c5UYjSbsdgenPikmIkIibMK7JS9G5p0vIfF8Dqll+ZRUmKmouIlef52c3HOINhsrKys8+meZ
2dkFUlKziY19LSiQ7JUIh5vep2SgmNbJFgy/1XC09SgHNXI0xRbSjmvo6uxiIQB7vbPYHX8g
laYSFxcnhGx7altYglmgxl5Ns+tHFlcfMTI3TJ2zluzeLA4pPyLlSCENDddwu2dwOP+kq/tB
4P/pbNwe/UGU7thtGbXOSuaX51hfX9+IdfoW+pESdpdHkpx6hksXjQzdn6TfNo7Z0kumXBUU
PK/YZZKLR5ha9G7Cj+Nf82NxX+E5YziyFCXlFbXYRDc9t0epu9yCUlUaFLycJzEliq9TMfkF
7TPmALyGb9nDhUkN6hE5uy4/TVLyp3xZWoU46KM30FZ5zile3SsNdkCaJdW9eecF0u1vUT+t
3xC4lhx86BQ4OPgKMd/EIktWkZmlJu5dGeHhO9m3T4bscEZQEBoWGpbbeZwi1zF+nq8LvmBl
gq+8uSTciiFNpSUzs4zomCT2RL9HUk4+6oLv2f/GO4rNDhx4+4CQcTXFVTRygralKmqnNMit
hyisLrBqtUYUiguB9p3ldH4N+q+bAxU+bfrPbYzaHyVsj9guPBv5jCB5Kbi6UXtiBIOhnWvm
O3TcsBEfn6B4kvkXxV9YN+ClYBQAAAAASUVORK5CYII='
]

{ #category : #icons }
TLIconCache class >> serverStopIcon [
	<script: 'self serverStopIcon inspect'>

	^self iconNamed: #serverStopIcon
]

{ #category : #'private - icons' }
TLIconCache class >> serverStopIconContents [

	^'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAADQ0lEQVR4Xn2Ta0zTVxiHG+GD
prilxuhGCH5RYrJsxokGvI24DBJmYLBWQDrYZthGwka5VNFkCIFMN7WbFVfhr4ZIVWyV1V28
Z8oGlbXjzrLBWumFiy24xa4rkVKe/R3T2SzZmzx5v5z3OTnn/I7kydq4cbNm2zalQS7PNXT2
2LF22bF02dhVUWVev36TJjo6WiH5v2rrsOP2BBmbmGHUM8uo9xEhRjwz/NjjxNpp43X5dsPD
zaKiohLDBNe/HaSrz0/PwH2GhgPYHTPYhkPYnSKuWe64QgyPzIiyEJ7fHnDlWjthgm8u9/O9
2cvN1jGu3XBx8zu3eIx79A78gc05xfhEkMn7QQbtE1wwWdDVm8IFLSYrV687+fqSjS8u/oLh
fD9nmrtpNloRGm9Rd+wqtfuNFKuOkJVTREqK3BwmONPcTovpZ84Z+zh9tovGUxaEE+0crrvE
+x/s4ZDmGCdPNmGxWNHrz7JuXZLh8XBkZGSM8Nk56qsbaThkouF4G5/rbnFYe4Oaj5ppatIz
PR1kauoBPl+AAweOsGVL6pzgueXLS7Ryhft2TQ0/NdTTUVuLPr+Q/bsE9u37kordJ6g7qiMQ
mMbr9eFyTaIqqSQtLdMgeXbJEsXl3FzsgvCYO//0lswsKlU6du4U2Lu3hpHRSRyu3+nqvUuu
sgiZbJFCok1Lc/eVlTNUVcWvTzAoMlBRwSdrUygvb0Ct/pD+ATed3Q7xZUZ5dauSpUufUUhM
LzyP3+kg6PeL/BnWp/0+Tq/dQJkoKFbtobt3jNY2O+237aSmbiciMiJG8lVcHIGxMUKzof8S
CnF+TQKlZTreK1TTYXWLIbvHxwfrycsvmstAa04OQ0lJuNPTuKtU4s3PY1z5Bo701xhMTkZY
vZmSUh1Z2e/w1o5i4lasJCExmepqYU6weOFCxQ+yRbhiY/GIeJctY1zswyLmp56mMr9KvAOB
l195k00vZSEvLKG49Chv71D9G6IVMllJb3w8/vR0pvLy8GVk0LMmnt0ZmWat1ki5WqDgXQ1l
6uMc/PSiuLvWLZVKwz+SdMGCxOzVLxqyY2MN2atWGaTz5/+9YN68iJhT+isYL7RRUFBqTkjY
oHkYukdzfwGRNFI+0JfMpQAAAABJRU5ErkJggg=='
]
