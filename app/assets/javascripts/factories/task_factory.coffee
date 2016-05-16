##
##  Task factory
##
@application.factory 'Task', [
	'$resource'
	($resource) ->
		$resource '/api/tasks/:id', 
		{ id: '@id' }, 
		'update': 
			method: 'PUT'
]