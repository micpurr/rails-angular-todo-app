##
##  Task factory
##
@application.factory 'Task', [
	'$resource'
	($resource) ->
		$resource '/api/projects/:project_id/tasks/:id', { project_id: '@project_id' ,id: '@id' }, 'update': method: 'PUT'
]