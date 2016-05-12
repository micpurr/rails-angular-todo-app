module ApplicationHelper
	##
	##  helper for localize
	##
	def lc(word, transform_action='capitalize')
		I18n.t(word).send(transform_action)
	end
end
