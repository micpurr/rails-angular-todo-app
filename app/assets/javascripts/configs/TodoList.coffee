##
##  Create Application
##
##  Modules 
##  - ngRoute
##  - Devise( Gem for auth vith devise )
##  - template( Gem for create templates for page )
##
@application = angular.module('TodoList', 
	[ 
		'ngRoute', 
		'Devise', 
		'templates'
	])