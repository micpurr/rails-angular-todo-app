#
#  Service for manipulating scope data
#
@application.factory 'CommentProvider', [
	'$rootScope'
	'Comment'
	'Helpers'
	($rootScope, Comment, Helpers) ->
		#
		#  Comments holder
		#
		comment = {}

		#
		#  Remove comment from DB
		#  
		#  params:
		#    scopeTask: <object>
		#      - object what have a comment
		#    comment: <object>
		#      - comment object what will be remove
		#  
		#  return: null
		#  
		comment.remove = (scopeTask, comment) ->
			#
			#  DELETE request for remove users comment for task
			#
			Comment.remove {
				project_id: scopeTask.project_id
				task_id: scopeTask.id
				id: comment.id
			}, 
				#
				#  Removing comment from scope
				#
				Helpers.removeRecordByField scopeTask.comments, comment.id
			return

		#
		#  return comment provider
		#
		return comment
]