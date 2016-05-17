#
#  Application controller
#
@application.controller 'ApplicationController', [ 
	'$scope'
	'ProjectProvider'
	'TaskProvider'
	($scope, ProjectProvider, TaskProvider) ->
		#
		#  TaskProvider for managing tasks
		#
		$scope.Task = TaskProvider

		#
		#  ProjectProvider for managing projects
		#
		$scope.Project = ProjectProvider

		#
		#  Get all project
		#
		$scope.projects = $scope.Project.all()

		#
		#  Variable store state of showing 
		#  actions in project title
		#
		$scope.isHoverProjectName = false

		#
		#  Variable store state of showing
		#  actions on task hover
		#
		$scope.isHoverTask = false
]