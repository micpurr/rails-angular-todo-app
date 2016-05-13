##
##  Logout controller
##
@application.controller 'LogoutController', [ 
	'$scope'
	'Auth'
	'$location'
	'$rootScope'
	'$cookieStore'
	( $scope, Auth, $location, $rootScope, $cookieStore ) ->

		config = headers: 'X-HTTP-Method-Override': 'DELETE'

		$scope.logout = () ->
			Auth.logout(config).then ((oldUser) ->
				$rootScope.globals = {}
				$cookieStore.remove('globals')
				$location.path('/login')
			), (error) ->
				console.log(error)
]