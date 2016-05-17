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

		$scope.removeProjectById = (id) ->
			project = ($.grep $scope.projects, (e) -> e.id == id)[0]
			index = $scope.projects.indexOf project
			$scope.projects.splice index, 1

		$scope.addTaskToProject = (task) ->
			$scope.searchProjectById(task.project_id).tasks.push task 

		$scope.removeTaskById = (project_id, task_id) ->
			project = $scope.searchProjectById project_id
			tasks = project.tasks
			index = tasks.indexOf ($.grep project.tasks, (e) -> e.id == task_id)[0]
			tasks.splice index, 1

		$scope.removeTask = (task) ->
			Task.remove { project_id: task.project_id, id: task.id },
				-> $scope.removeTaskById task.project_id, task.id

		$scope.newTask = (project) ->
			task = new Task
				name: project.task.name, 
				project_id: project.id,
				deadline: project.task.deadline
			task.$save project_id: project.id ,
				->
					$scope.addTaskToProject(task)
					project.task = {}

		$scope.changeTaskPriority = (project, task, direction) ->
			Task.changePriority {
				id: task.id
				project_id: task.project_id
				change_priority: direction
			}, task,
				(editedTasks) ->
					project.tasks = editedTasks

		$scope.toggleTaskDone = (task) ->
			Task.update {
				id: task.id
				project_id: task.project_id
			}, task

		$scope.removeProject = (project) ->
			Project.remove { id: project.id },
				-> $scope.removeProjectById project.id
]