#
#  Special directive for using pickadate.js
#  
#  params:
#    pickadate-model: <$scope> 
#      - scope for insert selected data
#    pickadate-new-position: <css-selector> 
#      - after selected container 
#        will show dialog window with date
#    
@application.directive 'pickadate', [ ->
	{
		restrict: 'AE'
		scope: 
			dpmodel: '=pickadateModel'

		link: (scope, elem, attrs) ->
			#
			#  variable for store new position
			#
			position = null

			#
			#  Check if new position is set
			#
			if attrs.pickadateNewPosition
				position = $(elem).parents attrs.pickadateNewPosition

			#
			#  Init pickadate with params
			#
			$(elem).pickadate
				#
				#  set new position
				#
				container: position

				#
				#  trigger when value is set in pickadate
				#
				onSet: (contex) ->
					#
					#  if date nested scope not init set empty object
					#
					if scope.dpmodel == undefined
						scope.dpmodel = {}

					#
					#  Create Date object
					#
					date = new Date contex.select

					#
					#  set date to scope
					#
					scope.dpmodel.deadline = "#{date.getFullYear()}-#{date.getMonth()+1}-#{date.getDate()}"
	}
]