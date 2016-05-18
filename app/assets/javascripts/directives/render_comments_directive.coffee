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
					scope.Comment = CommentProvider
		}
]