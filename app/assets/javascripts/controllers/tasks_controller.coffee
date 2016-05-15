##
##  Tasks controller
##
@application.controller 'TasksController', [ 
	'$scope'
	'$routeParams' 
	'Task'
	($scope, $routeParams, Task) ->

		Task.get {project_id: $routeParams.project_id, id: $routeParams.id}, (data) ->
			$scope.task = data

		$scope.update = ->
			# TODO: Update task

]