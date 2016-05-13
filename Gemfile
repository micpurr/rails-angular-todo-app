source 'https://rubygems.org'

############ => CORE
	# => Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
	gem 'rails', '4.2.6'
	# => Helper for create application settings
	gem 'figaro'
############

############ => DATABASE
	# => Use postgresql as the database for Active Record
	gem 'pg', '~> 0.15'
############

############ => ASSETS PIPELINE
	# => Load bootstrap
	gem 'bootstrap-sass', '~> 3.3.6'
	# => Use SCSS for stylesheets
	gem 'sass-rails', '~> 5.0'
	# => Use Uglifier as compressor for JavaScript assets
	gem 'uglifier', '>= 1.3.0'
	# => Use CoffeeScript for .coffee assets and views
	gem 'coffee-rails', '~> 4.1.0'
	# => AngularJS Wrapper for rails
	gem 'angularjs-rails'
	# => Angular templates
	gem 'angular-rails-templates', '1.0.0'
	# => Use jquery as the JavaScript library
	gem 'jquery-rails'
	# => Autiprefix for CSS
	gem 'autoprefixer-rails'
############

############ => VIEW
	# => Template slim
	gem 'slim-rails'
############

############ => MODEL
	# => Use cocoon gem for work with nested data
	# gem 'cocoon'
	# => Use russian gem for translate DateTime and some base translations
	# gem 'russian'
	# => Gem For preprocess Images
	gem 'rmagick'
	# => Gem for uploading Images
	gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
############

############ => CONTROLER
	# => Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
	gem 'jbuilder', '~> 2.0'
############

############ => AUTHENTICATION
	# => Use ActiveModel has_secure_password
	gem 'bcrypt', '~> 3.1.7'
	# => use Devise engine for User Authentication
	gem 'devise'
	# => AngularJS and Devise coop
	source "https://rails-assets.org" do
		gem "rails-assets-angular-devise"
	end
############

############ => SERVER
	# => Use Unicorn as the app server
	gem 'unicorn'
############

group :development, :test do
	# => Use faker for adding Fake data for testing application
	gem 'faker'
	# => RSPEC gem for testing with rspec
	gem 'rspec-rails', '~> 3.1'
	# => using livereload, gem will wach for changes and auto reload page in browser
	gem 'guard-livereload', require: false
	# => auto run RSPEC tests on changes
	gem 'guard-rspec', require: false
	# => Debugging tool for ruby
	gem 'byebug'
	# => Server for DEV
	gem 'thin'
end

group :test do
	# => Capybara
	gem 'capybara'
	# => Gem for adding random template data with testing
	gem 'factory_girl_rails'
	# => DB cleaner on testing
	gem 'database_cleaner'
	# gem 'selenium-webdriver', '2.47.1'
	gem 'capybara-ng'
end

group :development do
	# => Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
	gem 'spring'
end

