##
##  Logout controller
##
@application.controller 'LogoutController', [ 
	'$scope'
	'Auth'
	'$location'
	'$rootScope'
	($scope, Auth, $location, $rootScope) ->
		##
		##  Set header for request
		##
		config = headers: 'X-HTTP-Method-Override': 'DELETE'

		##
		##  Func for logout user
		##
		$scope.logout = () ->
			##
			##  User logout
			##
			Auth.logout(config).then ((oldUser) ->
				##
				##  Set auth status to false
				##
				$rootScope.globals = isAuth: false

				##
				##  Redirect to login page
				##
				$location.path '/login' 
			), (error) ->
				console.log error 
]