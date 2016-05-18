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
			#  success callback
			#
			success = (data) ->
				#
				#  Set project to scope 
				#
				return data

			#
			#  error callback
			#
			error = ->
				$location.path('/404')

			#
			#  GET request for get project
			#
			Project.get {
				id: id
			}, success, error
			return

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
			#
			#  success callback
			#
			success = (responce) ->
				#
				#  redirect to home page
				#
				$location.path('/')

			#
			#  error collback
			#
			error = (response) ->
				notify.showObjectArray response.data
				return

			if action
				#
				#  POST request for create project
				#
				project.$save { 
					id: project.id
				}, success, error
				return
			else
				#
				#  PUT request for put project
				#
				project.$update {
					id: project.id
				}, success, error
				return

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
			#  Success collback
			#
			success = ->
				#
				#  Removing project from scope
				#
				Helpers.removeRecordByField scope, project.id

			#
			#  error collback
			#
			error = (error) ->
				notify.show("<%= lc("messages.record.errors.dont_delete")%>")
				return

			#
			#  DELETE request for remove users project
			#
			Project.remove { 
				id: project.id 
			}, success, error
			return

		#
		#  return project provider
		#
		return project
]