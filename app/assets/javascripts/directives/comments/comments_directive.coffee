#
#  Directive form managing comments
#  
#  params:
#    parent-model: <model:ngResource>
#      - model which have comments array
#    parent-model-params: <object>
#      - params for find parent model in DB
#
@application.directive 'comments', [ 
	'Upload'
	'CommentProvider'
	'notify'
	(Upload, CommentProvider, notify) ->
		{
			restrict: 'EA'
			scope:
				model: '=parentModel'
				modelParams: '=parentModelParams'
				uploader: '@'
				newComment: '@'
			templateUrl: 'comments/index.html'
			compile: ->
				pre: (scope) ->
					#
					#  Create Comment
					#
					scope.createComment = ->
						#
						#  Create comment if file dont set
						#
						CommentProvider.create(scope.model, scope.newComment)
						
						#
						#  Clear newComment object
						#
						scope.newComment = {}
				post: (scope) ->
					#
					#  Reset form state after submit
					#
					scope.resetForm = ->
						scope.formNewComment.$setPristine()
		}
]