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
	'FileUploader'
	'CommentProvider'
	'notify'
	(FileUploader, CommentProvider, notify) ->
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
					#  Init uploader for file
					#
					scope.uploader = new FileUploader {
						#
						#  URL for request
						#
						url: '/api/comments' 

						#
						#  Set token
						#
						headers: 
							'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute 'content'

						#
						#  Set date of comment to send data
						#
						onBeforeUploadItem: (item) ->
							#
							#  Combine comment params and parent object params
							#
							params = angular.extend( scope.modelParams, scope.newComment )
							
							#
							#  Add params for send
							#
							item.formData.push params

						#
						#  After success add comment push they to task
						#  !!!Parent model mast have array "comments"
						#
						onSuccessItem: (item, response, status, headers) ->
							#
							#  add comment to scope
							#
							scope.model.comments.push response

							#
							#  Clear scope for new comment
							#
							scope.newComment = {}

							#
							#  Clear uploader
							#
							scope.uploader.clearQueue()

							#
							#  Clear file name in input
							#
							$("#file").val(null)

						#
						#  If comment dont create
						#
						onErrorItem: (item, response, status, headers) ->
							#
							#  Clear uploader
							#
							scope.uploader.clearQueue()

							#
							#  Clear file name in input
							#
							$("#file").val(null)

							#
							#  Show errors
							#
							notify.showObjectArray response
							return
					}

					#
					#  Create Comment
					#
					scope.createComment = ->
						#
						#  Check if file setted
						#
						if scope.uploader.queue.length > 0
							#
							#  Create comment with file
							#
							scope.uploader.uploadAll()
						else
							#
							#  Create comment if file dont set
							#
							CommentProvider.create(scope.model, scope.newComment)

							#
							#  Clear newComment object
							#
							scope.newComment = {}
		}
]