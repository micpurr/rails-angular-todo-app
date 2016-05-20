# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
require 'capybara/rails'
require 'capybara/rspec'
require "capybara/poltergeist"

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
	config.include Devise::TestHelpers, type: :controller
	config.include Devise::TestHelpers, type: :view
	# config.include Capybara::Angular::DSL
	config.include WaitForAjax, type: :feature
	config.include WaitForAngular, type: :feature
	include Warden::Test::Helpers
	include ApplicationHelper

	config.render_views = true

	Capybara.javascript_driver = :poltergeist

	Shoulda::Matchers.configure do |config|
		config.integrate do |with|
			with.test_framework :rspec
			with.library :rails
		end
	end

	config.before do
		DatabaseCleaner.strategy = :transaction
		DatabaseCleaner.clean_with(:truncation)
	end

	config.infer_spec_type_from_file_location!

	config.use_transactional_fixtures = false

	config.filter_rails_from_backtrace!
end
