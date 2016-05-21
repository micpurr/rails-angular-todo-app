#Ruby on Rails

###Description
*This is a simple ToDo application powered by Ruby on Rail + AngularJS. You can create project and task for project. For every task user can create comments and attach file to comment. Task can be managed by priority and mark as done. Done task will be green, task which deadline not pass will be red, task wich deadline is today yellow.*

####CORE
- Ruby on Rails 4.2.6
	- [Figaro](https://github.com/laserlemon/figaro)
	- [Angular Rails](https://github.com/hiravgandhi/angularjs-rails)
	- [Angular Rails Templates](https://github.com/pitr/angular-rails-templates)
	- [Angular Devise](https://github.com/cloudspace/angular_devise)
	- [Carrierwave](https://github.com/carrierwaveuploader/carrierwave)
	- [Acts as list](https://github.com/swanandp/acts_as_list)
	- [Acts as commantable](https://github.com/jackdempsey/acts_as_commentable)
	- [Devise](https://github.com/plataformatec/devise)
	- [Faker](https://github.com/stympy/faker)
	- [RSpec Rails](https://github.com/rspec/rspec-rails)
	- [Capybara](https://github.com/jnicklas/capybara)
	- [Poltergeist](https://github.com/teampoltergeist/poltergeist)
	- [PhantomJS](https://github.com/colszowka/phantomjs-gem)
- AngularJS 1.5
	- [ng-file-upload](https://github.com/danialfarid/ng-file-upload/)
- Twitter Bootstrap 3
- PostgreSQL
- Slim Tamplate
- SASS
- CoffeeScript

####CSS LIBS
- [AnimateCSS](https://daneden.github.io/animate.css/)

####JS LIBS
- [SnackbarJS](https://github.com/FezVrasta/snackbarjs/)
- [PickadateJS](http://amsul.ca/pickadate.js/)
- [UnderscoreJS](http://underscorejs.org/)

##Functional 
- Sign in/sign up by email/password
- Create/update/delete projects
- Create/update/delete task in project
- Prioritize tasks in project
- Choose deadline for task
- Mark task as done
- Create/delete commnets for tasks
- Attach file to cooment

##Structure

#####Angular 
- app/assets/javascripts/ - Core folder
	- application.coffee - manifest file for libs
	- application-angular.coffee - manifest file for angular
	- configs/ - Configurations
		- ToDoList.coffee - application module
		- routes.coffee - routes for angular application
	- controllers/ - Controllers folder
	- directives/ - Directives controller
		- pickadate_directive.coffee - directive for useing PickadateJS
		- tasks/ - Tasks directives folder
		- comments/ - Commnets directives folder
	- factories/ - Factories for models folder
	- providers/ - Provider for using factories folder
	- services/  - Services folder
		- helpers_service.coffee - special helpers for manipulate collections
		- snackbar_service.coffee - service for using snackbarJS

#####API
- app/controllers/api/v1/
	- comments_controller.rb
	- task_controller.rb
	- project_controller.rb
- app/models/
	- comment.rb
	- project.rb
	- task.rb
	- user.rb
- app/helpers/
	- application_helper.rb
- app/uploaders/
	- file_uploader.rb
- app/views/
	- api/v1/
		- comments/
		- projects/
		- tasks/
	- application/
	- layouts/
	- partials/layouts

##Install

	rake db:create
	rake db:migrate
	rake db:seed

*Will generate 2 with random project, tasks and comments*

- USER
	- one
		- email: "user@gmail.com"
		- password: 111111
	- two
		- email: "user2@gmail.com"
		- password: 111111