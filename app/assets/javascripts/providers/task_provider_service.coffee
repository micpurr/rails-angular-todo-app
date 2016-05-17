#
#  Service for manipulating scope data
#
@application.factory 'TaskProvider', [
	'$rootScope'
	'Task'
	'Helpers'
	($rootScope, Task, Helpers) ->
		#
		#  Tasks holder
		#
		task = {}

		#
		#  Remove task from DB
		#  
		#  params:
		#    scope: <array>
		#      - collections where task are store
		#    task: <object>
		#      - task object what will be remove
		#  
		#  return: null
		#  
		task.remove = (scope, task) ->
			#
			#  DELETE request for remove users task
			#
			Task.remove { 
				project_id: task.project_id 
				id: task.id 
			}, ->
				#
				#  Removing task from scope
				#
				Helpers.removeRecordFromSubCollection scope, task.project_id, 'tasks', task
			return

		#
		#  Create task in DB
		#  
		#  params:
		#    scope: <array>
		#      - collections where task are store
		#    project: <object>
		#      - task will be store in this project
		#
		#  return: null
		#
		task.create = (scope, project) ->
			#
			#  Create empty Task resource and
			#
			task = new Task
				name: project.task.name, 
				project_id: project.id,
				deadline: project.task.deadline
			#
			#  POST request for create task
			#
			task.$save {
				project_id: project.id
			}, ->
				#
				#  add task to scope
				#
				Helpers.addRecordToSubCollection scope, project.id, 'tasks', task

				#
				#  clear scope for new task
				#
				project.task = {}
			return

		#
		#  Change priority of task in DB
		#  
		#  params:
		#    task: <object>
		#      - change priority of this task
		#    project: <object>
		#      - reload tasks for current project
		#    direction: <string: ('up' or 'down')>
		#      - change priority up or down
		#      
		#  return: null
		#
		task.changePriority = (project, task, direction) ->
			#
			#  POST request for change priority
			#
			Task.changePriority {
				id: task.id
				project_id: task.project_id
				change_priority: direction
			}, task,
				(editedTasks) ->
					#
					#  Reload tasks to scope
					#
					project.tasks = editedTasks
			return

		#
		#  Toggle done of task in DB
		#  
		#  params:
		#    task: <object>
		#      - toggle done of this task
		#      
		#  return: null
		#
		task.toggleDone = (task) ->
			#
			#  PUT request for update task
			#
			Task.update {
				id: task.id
				project_id: task.project_id
			}, task
			return

		#
		#  return task provider
		#
		return task
]