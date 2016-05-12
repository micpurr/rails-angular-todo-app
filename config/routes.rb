Rails.application.routes.draw do
	##
	##  Root path
	##
	root "application#index"

	##
	##  Root angular path
	##
	get '*path' => 'application#index'

	##
	##  Devise routes
	##
	devise_for :users

end
