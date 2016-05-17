class Task < ActiveRecord::Base
	##
	##  Relations
	##
	belongs_to :project
	acts_as_list scope: :project
	acts_as_commentable

	##
	##  Methods
	##
	def get_deadline_days_left
		if deadline.present?
			(deadline - Date.today).to_i
		else
			0
		end
	end

	def next
		Task.order(:position).where("position > ?", position).first
	end

	def prev
		Task.order(:position).where("position < ?", position).last
	end

	##
	##  validations
	##
	validates_uniqueness_of :name
	validates_presence_of :name
	validates_length_of :name, within: 2..255
end
