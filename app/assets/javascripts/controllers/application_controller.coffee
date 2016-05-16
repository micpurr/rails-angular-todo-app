##
##  Application controller
##
@application.controller 'ApplicationController', [ 
	'$scope'
	'Auth' 
	'Project'
	'Task'
	($scope, Auth, Project, Task) ->

		$scope.projects = Project.query()

		$scope.isHoverProjectName = false

		$scope.isHoverTask = false

		##
		##  TODO: MoveToService
		##
		$scope.searchProjectById = (id) ->
			($.grep $scope.projects, (e) -> e.id == id)[0]

		$scope.removeTaskById = (project_id, task_id) ->
			project = $scope.searchProjectById project_id
			tasks = project.tasks
			index = tasks.indexOf(($.grep project.tasks, (e) -> e.id == task_id)[0])
			tasks.splice(index, 1)

		$scope.removeTask = (task) ->
			Task.remove { project_id: task.project_id, id: task.id },
				->
					$scope.removeTaskById(task.project_id, task.id)
]