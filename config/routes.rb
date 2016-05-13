Rails.application.routes.draw do
	##
	##  Root path
	##
	root "application#index"

	##
	##  Devise routes
	##
	devise_for :users

	##
	##  Root angular path
	##
	match '*path' => 'application#index', via: [:get, :post]
end
