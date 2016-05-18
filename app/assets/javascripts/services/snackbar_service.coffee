#
#  Service for showing messages
#  powered by snackbar
#
@application.factory 'notify', [ ->
		#
		#  snackbar holder
		#
		snackbar = {}

		#
		#  Show snackbar with message
		#  
		#  params:
		#    message: <string>
		#      - message which need to show
		#    timeout(optional): <integer:milliseconds>
		#      - how long snack bar will be shown
		#      
		#  return: null
		#
		snackbar.show = (message, timeout=5000) ->
			$.snackbar
				content: message
				timeout: timeout
				htmlAllowed: true
			return

		#
		#  Show snackbar with array of messages
		#  
		#  params:
		#    array: <array[string]>
		#      - array of strings which need to show
		#    timeout(optional): <integer:milliseconds>
		#      - how long snack bar will be shown
		#      
		#  return: null
		#
		snackbar.showArray = (array, timeout=10000) ->
			$.snackbar
				content: snackbar.arrayErrors array
				timeout: timeout
				htmlAllowed: true
			return

		#
		#  Show snackbar with array of objects
		#  
		#  params:
		#    objectArray: <object{string: array}>
		#      - array of objects which need to show
		#    timeout(optional): <integer:milliseconds>
		#      - how long snack bar will be shown
		#      
		#  return: null
		#
		snackbar.showObjectArray = (objectArray, timeout=15000) ->
			$.snackbar
				content: snackbar.objectArrayErrors objectArray
				timeout: timeout
				htmlAllowed: true
			return

		#
		#  Creacte HTML for render for array of objects
		#  
		#  params:
		#    objectArrayErrors: <object{string: array}>
		#      - array of objects which need to genereta HTML
		#      
		#  return: null
		#
		snackbar.objectArrayErrors = (objectArrayErrors) ->
			#
			#  HTML holder
			#
			html = ""

			#
			#  loop for every object
			#
			for name, arrayErrors of objectArrayErrors
				html += "<div><h4 class=>#{name.toUpperCase()}</h4>"
				html += "<ul>"

				#
				#  loop for errors
				#
				for error in arrayErrors
					html += "<li>#{error}</li>"
				html +="</ul></div>"

			#
			#  return HTML
			#
			return html

		#
		#  Creacte HTML for render for array of strings
		#  
		#  params:
		#    objectArrayErrors: <array[string]>
		#      - array of strings which need to genereta HTML
		#      
		#  return: null
		#
		snackbar.arrayErrors = (arrayErrors) ->
			#
			#  HTML holder
			#
			html = "<div><ul>"

			#
			#  loop for errors
			#
			for error in arrayErrors
				html += "<li>#{error}</li>"
			html +="</ul></div>"

			#
			#  return HTML
			#
			return html

		#
		#  return snackbar
		#
		return snackbar
]