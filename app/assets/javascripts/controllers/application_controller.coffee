#
#  Application controller
#
@application.controller 'ApplicationController', [ 
	'$scope'
	'ProjectProvider'
	($scope, ProjectProvider) ->
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
]