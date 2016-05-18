#
#  Directive for render comments of model
#  
#  params:
#    parent-model: <model:ngResource>
#      - model which have comments array
#
@application.directive 'renderComments', [ 
	'CommentProvider'
	(CommentProvider) ->
		{
			restrict: 'EA'
			scope:
				model: '=parentModel'
			templateUrl: 'comments/render_comments.html'
			compile: ->
				pre: (scope) ->
					#
					#  Init CommentProvider
					#
					scope.Comment = CommentProvider
		}
]