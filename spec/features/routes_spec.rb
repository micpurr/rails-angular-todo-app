require 'rails_helper'

RSpec.feature 'routes', :js => true do
	before(:each) do
		@user = User.create!(email: 'user@gmail.com', password: "111111")
		@project = Project.create!(name: Faker::Lorem.sentence, user_id: @user.id)
		@task = Task.create!(name: Faker::Lorem.sentence, project_id: @project.id)
	end

	context "with not authorized user" do
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

	context "with authorized user" do
		before(:each) do
			login_as(@user, :scope => :user)
		end

		scenario "home page" do
			visit '/'
			expect(page).to have_content(@user.email)
		end

		scenario 'profile page' do
			visit '/'

			wait_for_angular

			find("a[href='profile']").click

			expect(page).to have_content('Profile')
			expect(page).to have_content('created at')
			expect(page).to have_content('Back')
		end

		scenario 'some task page' do
			visit "/"

			wait_for_angular

			find('a.show-task').click

			expect(page).to have_content('Task')
			expect(page).to have_content('deadline')
			expect(page).to have_content('Cancel')
			expect(page).to have_content('Comments')
		end

		scenario 'edit task page' do
			visit "/"

			wait_for_angular

			find('tbody > tr').hover
			find("a.edit-task").click

			wait_for_angular

			expect(page).to have_content('Task')
			expect(page).to have_selector('#name')
			expect(find_field('name').value).to eq @task.name
			expect(page).to have_content('Deadline')
			expect(page).to have_content('Cancel')
		end

		scenario 'new project page' do
			visit "/"

			wait_for_angular

			find("a.new-project").click

			wait_for_angular

			expect(page).to have_content('New')
			expect(page).to have_selector('#name')
			expect(page).to have_content('Cancel')
		end

		scenario 'edit project page' do
			visit "/"

			wait_for_angular

			find('.panel-heading').hover
			find("a.edit-project").click

			wait_for_angular

			expect(page).to have_content('Edit')
			expect(page).to have_selector('#name')
			expect(find_field('name').value).to eq @project.name
			expect(page).to have_content('Cancel')
		end
	end
end