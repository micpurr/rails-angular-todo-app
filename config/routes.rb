Rails.application.routes.draw do
	##
	##  Root path
	##
	root "home#index"

	##
	##  Devise routes
	##
	devise_for :users
end
