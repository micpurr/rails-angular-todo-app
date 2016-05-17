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
		'changePriority':
			method: "POST"
			url: '/api/tasks/:id/change_priority'
			isArray: true
		'comments':
			method: "GET"
			url: '/api/comments'
]