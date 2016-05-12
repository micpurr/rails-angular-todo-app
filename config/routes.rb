Rails.application.routes.draw do
	##
	##  Root path
	##
	root "home#index"

	##
	##  Root angular path
	##
	get 'index' => 'home#index_angular'

	##
	##  Devise routes
	##
	devise_for :users
end
