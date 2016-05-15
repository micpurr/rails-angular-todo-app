##
##  Application controller
##
@application.controller 'ApplicationController', [ 
	'$scope'
	'Auth' 
	'Project'
	($scope, Auth, Project) ->

		$scope.projects = Project.query()

		$scope.isHoverProjectName = false

]