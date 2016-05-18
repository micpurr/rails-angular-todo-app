#
#  Comment factory
#
@application.factory 'Comment', [
	'$resource'
	($resource) ->
		$resource '/api/comments/:id', 
			{ id: '@id' }
]