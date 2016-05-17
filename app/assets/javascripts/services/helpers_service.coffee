#
#  Service for manipulating scope data
#
@application.factory 'Helpers', [
	'$rootScope'
	($rootScope) ->
		#
		#  Helpers holder
		#
		helpers = {}

		#
		#  Get record from collection by selected field and value
		#  
		#  params: 
		#    collection: <array>
		#      - collection from will be search value
		#    value: <integer | string | float | bool>
		#      - condition value for search record
		#    field (optional): <string> 
		#      - field name select for condition
		#  
		#  return: record from collection
		#
		helpers.getRecordByField = (collection, value, field='id') ->
			_.find collection, (record) -> record[field] == value 

		#
		#  Removing record from collection by selected value and field
		#  
		#  params: 
		#    collection: <array>
		#      - collection from will be search value
		#    value: <integer | string | float | bool>
		#      - condition value for search record
		#    field (optional): <string> 
		#      - field name select for condition
		#
		#  return null
		#  
		helpers.removeRecordByField = (collection, value, field='id') ->
			#
			#  get record from collection
			#
			record = helpers.getRecordByField collection, value

			#
			#  get index of this record in collection
			#
			indexInCollection = _.indexOf collection, record

			#
			#  if index exist remove from collection
			#
			if indexInCollection != -1
				collection.splice indexInCollection, 1
			return null

		#
		#  Add record to selected sub collection 
		#  
		#  params:
		#    collection: <array>
		#      - collection from will be search value
		#    collection_record_value: <integer | string | float | bool>
		#      - condition value for search record
		#    collection_record_filed (optional): <string> 
		#      - field name select for condition
		#     model: <string>
		#       - sub collection name
		#     record: <Object>
		#       - object for add to collection
		#       
		#  return: null
		#
		helpers.addRecordToSubCollection = (collection, collection_record_value, model, record, collection_record_filed='id') ->
			#
			#  get record from main collection
			#
			_record = helpers.getRecordByField collection, collection_record_value, collection_record_filed

			#
			#  add to record in sub collection selected data
			#
			_record[model].push record
			return null

		#
		#  Add record to selected sub collection 
		#  
		#  params:
		#    collection: <array>
		#      - collection from will be search value
		#    collection_record_value: <integer | string | float | bool>
		#      - condition value for search record
		#    collection_record_filed (optional): <string> 
		#      - field name select for condition
		#     model: <string>
		#       - sub collection name
		#     record: <Object>
		#       - object for remove from collection
		#       
		#  return: null
		#
		helpers.removeRecordFromSubCollection = (collection, collection_record_value, model, record, collection_record_filed='id') ->
			#
			#  get record from main collection
			#
			_record = helpers.getRecordByField collection, collection_record_value, collection_record_filed

			#
			#  Remove selected record from sub collection
			#
			helpers.removeRecordByField _record[model], record.id
			return

		#
		#  return helpers
		#
		return helpers
]