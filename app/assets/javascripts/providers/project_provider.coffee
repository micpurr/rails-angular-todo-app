#
#  Service for manipulating scope data
#
@application.factory 'ProjectProvider', [
	'$rootScope'
	'Project'
	'Helpers'
	'$location'
	($rootScope, Project, Helpers, $location) ->
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
		#  Get project of user by id
		#  
		#  params: 
		#    id: <integer>
		#      - id of project what need to get
		#  
		#  return: <Project:ngResource>
		#
		project.get = (id) ->
			#
			#  GET request for get project
			#
			Project.get {
				id: id
			}, 
				(data) ->
					#
					#  Set project to scope
					#
					return data

		#
		#  Save or Update Project in depend of action
		#  
		#  params: 
		#    action: <boolean>
		#      - if true create project
		#      - if false update project
		#    project: <Project:ngResource>
		#  
		#  return: redirect to root page
		#
		project.saveOrUpdate = (action, project) ->
			if action
				#
				#  POST request for create project
				#
				project.$save { 
					id: project.id
				}, -> 
					#
					#  redirect to root page
					#
					$location.path('/')
			else
				#
				#  PUT request for put project
				#
				project.$update {
					id: project.id
				}, -> 
					#
					#  redirect to root page
					#
					$location.path('/')

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