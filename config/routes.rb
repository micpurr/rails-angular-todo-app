Rails.application.routes.draw do
	#
	#  API namespace
	#
	namespace 'api' do
		#
		#  Isolate version
		#
		namespace 'v1' do
			#
			#  project resource
			#
			resources :projects, 
				defaults: {format: :json}, 
				except: [:new, :edit] 

			#
			#  task resource
			#
			resources :tasks, 
				defaults: {format: :json}, 
				except: [:new, :edit, :index] do
				post 'change_priority' => 'tasks#change_priority'
			end

			#
			#  comment resource
			#
			resources :comments,
				defaults: {format: :json}, 
				only: [:create, :destroy]
		end
	end

	#
	#  Root path
	#
	root "application#index", anchor: false

	#
	#  Devise routes
	#
	devise_for :users

	#
	#  Root angular path
	#
	match '*path' => 'application#index', via: [:get, :post], format: false
end
