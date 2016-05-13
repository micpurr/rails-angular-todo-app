##
##  Login controller
##
@application.controller 'LoginController', [ 
	'$scope'
	'Auth'
	'$location'
	"$rootScope"
	'$cookieStore'
	($scope, Auth, $location, $rootScope, $cookieStore) ->

		config = headers: 'X-HTTP-Method-Override': 'POST'

		$scope.login = () ->
			credentials = 
				email: $scope.email
				password: $scope.password

			Auth.login(credentials, config).then ((user) ->
				$rootScope.globals = user: user
				$cookieStore.put 'globals', $rootScope.globals
				$location.path '/' 
			), (error) ->
				console.log error
]