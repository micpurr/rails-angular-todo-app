class Task < ActiveRecord::Base
	##
	##  Relations
	##
	belongs_to :project

	##
	##  Methods
	##
	def get_deadline_days_left
		if deadline.present?
			(deadline - DateTime.now).to_i
		else
			0
		end
	end

	##
	##  validations
	##
	validates_uniqueness_of :name
	validates_presence_of :name
	validates_length_of :name, within: 2..255
end
