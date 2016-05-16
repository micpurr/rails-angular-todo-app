##
##  Auth controller
##
@application.controller 'AuthController', [ 
	'$scope'
	'Auth'
	'$location'
	"$rootScope"
	($scope, Auth, $location, $rootScope) ->
		##
		##  Func for login user
		##
		$scope.login = () ->
			##
			##  Set header for request
			##
			config = headers: 'X-HTTP-Method-Override': 'POST'

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

		##
		##  Func for logout user
		##
		$scope.logout = () ->
			##
			##  Set header for request
			##
			config = headers: 'X-HTTP-Method-Override': 'DELETE'

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

		##
		##  Func for Sign Up user
		##
		$scope.signUp = () ->
			##
			##  Set header for request
			##
			config = headers: 'X-HTTP-Method-Override': 'POST'

			##
			##  Credentials of user for login
			##
			credentials = 
				email: $scope.email
				password: $scope.password
				password_confirmation: $scope.password_confirmation

			##
			##  User sign up
			##
			Auth.register(credentials, config).then ((registeredUser) ->
				##
				##  Set registeredUser to $rootScope 
				##  if sign up success
				##
				$rootScope.globals = 
					user: registeredUser
					isAuth: true

				##
				##  Redirect after authenticate
				##  to home page
				##
				$location.path '/' 
			), (error) ->
				console.log error
]