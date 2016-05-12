class HomeController < ApplicationController
	##
	##  Root rails path
	##
	def index
	end

	##
	##  Angular root path
	##
	def index_angular
		render 'index', layout: false
	end
end
