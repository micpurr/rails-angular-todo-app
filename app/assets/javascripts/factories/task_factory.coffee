#
#  Task factory
#
@application.factory 'Task', [
	'$resource'
	($resource) ->
		$resource '/api/v1/tasks/:id', 
			{ id: '@id' }, 
			'update': 
				method: 'PUT'
			#
			#  Path for change priority
			#
			'changePriority':
				method: "POST"
				url: '/api/v1/tasks/:id/change_priority'
				isArray: true
			#
			#  Path for get comments
			#
			'comments':
				method: "GET"
				url: '/api/v1/comments'
]