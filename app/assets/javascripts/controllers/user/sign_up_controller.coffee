##
##  SignUp controller
##
@application.controller 'SignUpController', [ 
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
		$scope.signUp = () ->
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