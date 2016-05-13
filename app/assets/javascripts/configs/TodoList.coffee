##
##  Create Application
##
##  Modules 
##  - ngRoute
##  - ngCookies
##  - Devise( Gem for auth vith devise )
##  - template( Gem for create templates for page )
##
@application = angular.module 'TodoList', [ 
	'ngRoute'
	'ngCookies'
	'Devise'
	'templates'
]

##
##  Load user from session if logged in
##
@application.run [
	'$rootScope'
	'$location'
	'Auth'
	'$cookieStore'
	($rootScope, $location, Auth, $cookieStore) ->

		$rootScope.globals = $cookieStore.get 'globals' or {}

		if $cookieStore.get('globals')
			Auth.currentUser().then ((user) ->
				$rootScope.globals = user: user
			), (error) ->
				console.log error 

		$rootScope.$on '$locationChangeStart', (event, next, current) ->
			if $location.path() != '/login' and !$rootScope.globals.user
				$location.path '/login'
]