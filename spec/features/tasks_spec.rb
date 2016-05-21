require 'rails_helper'

RSpec.feature 'tasks', :js => true do
	before(:each) do
		@user = User.create!(email: 'user@gmail.com', password: "111111")
		@project = Project.create!(name: Faker::Lorem.sentence, user_id: @user.id)
		login_as(@user, :scope => :user)
	end

	# scenario 'new task' do
	# 	visit '/'

	# 	wait_for_angular

	# 	within('form[name=formNewTask]') do
	# 		fill_in 'name', with: 'task one'
	# 		find("button[type=submit]").click
	# 	end

	# 	wait_for_ajax

	# 	expect(page).not_to have_content('task one')
	# end

	# context do
	# 	before :each do
	# 		@task = @project.tasks.create!(name: 'task one')
	# 	end

	# 	scenario 'remove task' do
	# 		visit '/'

	# 		wait_for_angular

	# 		find('tbody > tr').hover
	# 		find("a.remove-task").click

	# 		wait_for_ajax

	# 		expect(page).to have_content('Task Delete')
	# 		expect(page).not_to have_content('task one')
	# 	end

	# 	scenario 'edit task' do
	# 		visit "/"

	# 		wait_for_angular

	# 		find('tbody > tr').hover
	# 		find("a.edit-task").click

	# 		wait_for_angular

	# 		within('form[name=formEditTask]') do
	# 			fill_in 'name', with: 'task edited'
	# 			find("button[type=submit]").click
	# 		end

	# 		wait_for_angular

	# 		expect(page).to have_content('Task Edit: "task edited"')
	# 	end

	# 	scenario 'change priority up' do
	# 		visit '/'

	# 		wait_for_angular

	# 		find('tbody > tr').hover
	# 		find("a.change-priority-up").click

	# 		wait_for_ajax

	# 		expect(page).to have_content('Priority was changed')
	# 	end

	# 	scenario 'change priority down' do
	# 		visit '/'

	# 		wait_for_angular

	# 		find('tbody > tr').hover
	# 		find("a.change-priority-down").click

	# 		wait_for_ajax

	# 		expect(page).to have_content('Priority was changed')
	# 	end
	# end

	context do
		before :each do
			task1 = @project.tasks.create!(name: Faker::Lorem.sentence)
			task2 = @project.tasks.create!(name: Faker::Lorem.sentence, deadline: Date.today - 2.days)
			task1 = @project.tasks.create!(name: Faker::Lorem.sentence, deadline: Date.today + 2.days)
		end

		scenario 'task have correct color' do
			visit '/'

			wait_for_angular

			selector = 'tbody > tr:first-child'
			find(selector).hover
			expect(page).to have_selector(selector+'.warning')

			selector = 'tbody > tr:nth-child(2)'
			expect(page).to have_selector(selector+'.danger')

			selector = 'tbody > tr:last-child'
			expect(page).to have_selector(selector)
		end

		scenario 'task have success color if selected' do
			visit '/'

			wait_for_angular

			selector = 'tbody > tr:first-child'
			find(selector+' input[type=checkbox]').click
			expect(page).to have_selector(selector+'.success')

			selector = 'tbody > tr:nth-child(2)'
			find(selector+' input[type=checkbox]').click
			expect(page).to have_selector(selector+'.success')

			selector = 'tbody > tr:last-child'
			find(selector+' input[type=checkbox]').click
			expect(page).to have_selector(selector+'.success')
		end
	end
end