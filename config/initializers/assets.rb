Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( application.js application-angular.js application.css )
Rails.application.config.assets.configure do |env|
	env.context_class.class_eval do
		include ApplicationHelper
	end
end