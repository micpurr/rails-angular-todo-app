Rails.application.routes.draw do
	##
	##  API scope fore isolate url
	##
	scope 'api' do
		##
		##  project resource
		##
		resources :projects, 
			defaults: {format: :json}, 
			except: [:new, :edit] 

		##
		##  task resource
		##
		resources :tasks, 
			defaults: {format: :json}, 
			except: [:new, :edit, :index] do
			post 'change_priority' => 'tasks#change_priority'
		end

		resources :comments,
			defaults: {format: :json}, 
			only: [:create, :destroy, :index]
	end

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
