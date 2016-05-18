#
#  Create Application
#
#  Modules 
#  - ngRoute
#  - Devise( Gem for auth vith devise )
#  - template( Gem for create templates for page )
#
@application = angular.module 'TodoList', [ 
	'ngRoute'
	'ngResource'
	'Devise'
	'templates'
	'angularFileUpload'
]

#
#  Load user from session if logged in
#
@application.run [
	'$rootScope'
	'$location'
	'Auth'
	($rootScope, $location, Auth) ->
		#
		#  Set preloader status
		#
		$rootScope.showPreloader = true

		#
		#  load user from current session 
		#  from server if exist
		#
		Auth.currentUser().then ((user) ->
			#
			#  Tern off preloader
			#
			$rootScope.showPreloader = false

			#
			#  Set user to $rootScope
			#
			$rootScope.globals = 
				user: user
				isAuth: true
		), (error) ->
			#
			#  Tern off preloader
			#
			$rootScope.showPreloader = false

			#
			#  Set auth status to false
			#
			$rootScope.globals = isAuth: false

			#
			#  redirect to login page
			#
			$location.path '/login'
		.then ->
			$rootScope.$on '$locationChangeStart', (event, next, current) ->
				#
				#  Current url
				#
				url = $location.path()

				#
				#  Login url
				#
				login_path = '/login'

				#
				#  Sign up url
				#
				sign_up_path = '/sign-up'

				#
				#  Redirect to login if user not authenticate
				#  cheking before every request
				#
				if !$rootScope.globals.user and url != login_path and url != sign_up_path
					#
					#  Redirect to login page
					#
					$location.path login_path

				#
				#  Redirect to home page
				#  if user is authenticate
				#  and try to go to login or sign-up page
				#
				if $rootScope.globals.user and ( url == sign_up_path or url == login_path )
					#
					#  Redirect to home page
					#
					$location.path '/'
			# $rootScope.$on '$locationChangeSuccess', (event, next, current) ->
			# 	$.snackbar 
			# 		content: "sdfsdf"
			# 	return
]