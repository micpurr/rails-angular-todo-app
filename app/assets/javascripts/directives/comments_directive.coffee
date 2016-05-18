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
	(FileUploader) ->
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
							params = $.extend( scope.modelParams, scope.newComment )

							#
							#  Add params for send
							#
							item.formData.push params

						#
						#  After success add comment push they to task
						#  !!!Parent model mast have array "comments"
						#
						onSuccessItem: (item, response, status, headers) ->
							scope.model.comments.push response
					}

					#
					#  Create Comment
					#
					scope.createComment = ->
						scope.uploader.uploadAll()
		}
]