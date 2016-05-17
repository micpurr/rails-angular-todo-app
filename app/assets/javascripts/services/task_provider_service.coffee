#
#  Service for manipulating scope data
#
@application.factory 'TaskProvider', [
	'$rootScope'
	'Task'
	'Helpers'
	($rootScope, Task, Helpers) ->
		#
		#  Helpers holder
		#
		task = {}

		task.remove = (scope, task) ->
			Task.remove { 
				project_id: task.project_id 
				id: task.id 
			}, ->
				Helpers.removeRecordFromSubCollection scope, task.project_id, 'tasks', task

		task.create = (scope, project) ->
			task = new Task
				name: project.task.name, 
				project_id: project.id,
				deadline: project.task.deadline
			task.$save {
				project_id: project.id
			}, ->
				Helpers.addRecordToSubCollection scope, project.id, 'tasks', task
				project.task = {}

		task.changePriority = (project, task, direction) ->
			Task.changePriority {
				id: task.id
				project_id: task.project_id
				change_priority: direction
			}, task,
				(editedTasks) ->
					project.tasks = editedTasks

		task.toggleDone = (task) ->
			Task.update {
				id: task.id
				project_id: task.project_id
			}, task

		return task
]