##
##  Project factory
##
@application.factory 'Project', [
	'$resource'
	($resource) ->
		$resource '/api/projects/:id', { id: '@id' }, 'update': method: 'PUT'
]