#
#  Project factory
#
@application.factory 'Project', [
	'$resource'
	($resource) ->
		$resource '/api/v1/projects/:id', 
			{ id: '@id' }, 
			'update': 
				method: 'PUT'
]