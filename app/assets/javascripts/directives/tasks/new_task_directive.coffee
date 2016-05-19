#
#  Directive for create new task
#  
#  params:
#    parent-model: <model:ngResource>
#      - model which have tasks array
#    parent-model-scope: <scope>
#      - parent scopes of model
#
@application.directive 'newTask', [
	'TaskProvider'
	(TaskProvider) ->
		{
			restrict: 'EA'
			replace: true
			scope: 
				model: '=parentModel'
				modelScope: '=parentModelScope'
			templateUrl: 'tasks/new.html'
			compile: ->
				pre: (scope) ->
					#
					#  Init TaskProvider
					#
					scope.Task = TaskProvider

					#
					#  Create default object of new task
					#
					scope.model.newTask = {}
				post: (scope) ->
					#
					#  Reset form state after submit
					#
					scope.resetForm = ->
						scope.formNewTask.$setPristine()
		}
]