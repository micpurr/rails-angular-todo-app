##
##  Login controller
##
@application.controller 'LoginController', [ 
	'$scope'
	'Auth'
	'$location'
	"$rootScope"
	($scope, Auth, $location, $rootScope) ->
		##
		##  Set header for request
		##
		config = headers: 'X-HTTP-Method-Override': 'POST'

		##
		##  Func for login user
		##
		$scope.login = () ->
			##
			##  Credentials of user for login
			##
			credentials = 
				email: $scope.email
				password: $scope.password

			##
			##  User authenticate
			##
			Auth.login(credentials, config).then ((user) ->
				##
				##  Set user to $rootScope 
				##  if authenticate success
				##
				$rootScope.globals = 
					user: user
					isAuth: true

				##
				##  Redirect after authenticate
				##  to home page
				##
				$location.path '/' 
			), (error) ->
				console.log error
]