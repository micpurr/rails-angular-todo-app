#
#  Service for manipulating scope data
#
@application.factory 'ProjectProvider', [
	'$rootScope'
	'Project'
	'Helpers'
	($rootScope, Project, Helpers) ->
		#
		#  Project holder
		#
		project = {}

		#
		#  Get all project of user
		#  
		#  params: null
		#  
		#  return: <array:Project:ngResource>
		#
		project.all = ->
			Project.query()

		#
		#  Remove selected project from DB
		#  
		#  params:
		#    scope: <array>
		#      - collections where project are store
		#    project: <object>
		#      - project object what will be remove
		#  
		#  return: null
		#  
		project.remove = (scope, project) ->
			#
			#  DELETE request for remove users project
			#
			Project.remove { 
				id: project.id 
			}, -> 
				#
				#  Removing project from scope
				#
				Helpers.removeRecordByField scope, project.id
			return

		#
		#  return project provider
		#
		return project
]