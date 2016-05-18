class Project < ActiveRecord::Base
	#
	#  Relations
	#
	has_many :tasks, -> { order(position: :asc) }, dependent: :delete_all

	#
	#  Validations
	#
	validates_uniqueness_of :name
	validates_presence_of :name
	validates_length_of :name, within: 2..255
end
