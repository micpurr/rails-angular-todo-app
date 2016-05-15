class Project < ActiveRecord::Base
	##
	##  Validations
	##
	validates_uniqueness_of :name
	validates_presence_of :name
	validates_length_of :name, within: 2..255
end
