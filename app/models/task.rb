class Task < ActiveRecord::Base
	#
	#  Relations
	#
	belongs_to :project
	acts_as_list scope: :project
	acts_as_commentable dependent: :delete_all

	#
	#  Methods
	#
	
	#
	#  Get count days to deadline
	#
	def get_deadline_days_left
		if deadline.present?
			(deadline - Date.today).to_i
		else
			0
		end
	end

	#
	#  Get next record by priority
	#
	def next
		Task.order(:position).where("position > ?", position).first
	end

	#
	#  Get prev record by priority
	#
	def prev
		Task.order(:position).where("position < ?", position).last
	end

	#
	#  Validations
	#
	validates_uniqueness_of :name
	validates_presence_of :name
	validates_length_of :name, within: 2..255
end
