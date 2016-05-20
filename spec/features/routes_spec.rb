require 'rails_helper'

RSpec.feature 'routes', :js => true do
	before(:each) do
		@user = User.create!(email: 'user@gmail.com', password: "111111")
		@project = Project.create!(name: Faker::Lorem.sentence, user_id: @user.id)
		@task = Task.create!(name: Faker::Lorem.sentence, project_id: @project.id)
	end

	scenario "home page" do
		visit '/'
		expect(page).to have_selector('form[name=formLogin]')
	end

	scenario 'profile page' do
		visit '/profile'
		expect(page).to have_selector('form[name=formLogin]')
	end

	scenario 'some task page' do
		visit "/projects/#{@project.id}/tasks/#{@task.id}"
		expect(page).to have_selector('form[name=formLogin]')
	end

	scenario 'edit task page' do
		visit "/projects/#{@project.id}/tasks/#{@task.id}/up"
		expect(page).to have_selector('form[name=formLogin]')
	end

	scenario 'new project page' do
		visit '/projects/new'
		expect(page).to have_selector('form[name=formLogin]')
	end

	scenario 'edit project page' do
		visit "/projects/#{@project.id}/edit"
		expect(page).to have_selector('form[name=formLogin]')
	end

	scenario 'fake url' do
		visit '/fake/url'
		expect(page).to have_selector('form[name=formLogin]')
	end

	scenario 'login page' do
		visit '/login'
		expect(page).to have_selector('form[name=formLogin]')
	end

	scenario 'login page' do
		visit '/'

		find("a[href='/sign-up']").click

		wait_for_angular

		expect(page).to have_selector('form[name=formSighUp]')
	end
end