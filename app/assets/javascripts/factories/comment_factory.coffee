#
#  Comment factory
#
@application.factory 'Comment', [
	'$resource'
	($resource) ->
		$resource '/api/v1/comments/:id', 
			{ id: '@id' }
]