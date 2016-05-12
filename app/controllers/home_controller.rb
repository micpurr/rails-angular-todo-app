class HomeController < ApplicationController
	def index
	end

	def index_angular
		render 'index', layout: false
	end
end
