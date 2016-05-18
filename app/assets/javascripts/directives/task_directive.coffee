#
#  Directive for show all tasks
#  
#  params:
#    parent-model: <model:ngResource>
#      - model which have tasks array
#    parent-model-scope: <scope>
#      - parent scopes of model
#
@application.directive 'tasks', [
	'TaskProvider'
	(TaskProvider) ->
		{
			restrict: 'EA'
			replace: true
			scope:
				model: '=parentModel'
				modelScope: '=parentModelScope'
			templateUrl: 'tasks/index.html'
			compile: ->
				pre: (scope) ->
					#
					#  Init TaskProvider
					#
					scope.Task = TaskProvider

					#
					#  Variable store state of showing
					#  actions on task hover
					#
					scope.isHoverTask = false
		}

]