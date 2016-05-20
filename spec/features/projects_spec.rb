require 'rails_helper'

RSpec.feature 'projects', :js => true do
	before(:each) do
		@user = User.create!(email: 'user@gmail.com', password: "111111")
		login_as(@user, :scope => :user)
	end

	scenario 'new project' do
		visit "/"

		wait_for_angular

		find("a.new-project").click

		wait_for_angular

		within('form[name=formNewEditProject]') do
			fill_in 'name', with: 'ProjectNew'
			find("button[type=submit]").click
		end

		wait_for_angular

		expect(page).to have_content('Project Create: "ProjectNew"')
	end

	context do
		before :each do
			@user.projects.create!(name: 'ProjectNew')
		end

		scenario 'edit project' do
			visit "/"

			wait_for_angular

			find('.panel-heading').hover
			find("a.edit-project").click

			wait_for_angular

			within('form[name=formNewEditProject]') do
				fill_in 'name', with: 'ProjectEdit'
				find("button[type=submit]").click
			end

			wait_for_angular

			expect(page).to have_content('Project Edit: "ProjectEdit"')
		end

		scenario 'remove project' do
			visit "/"

			wait_for_angular

			find('.panel-heading').hover
			find("a.remove-project").click

			wait_for_angular

			expect(page).to have_content('Project Delete')
		end
	end
end