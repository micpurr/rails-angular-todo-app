require 'rails_helper'

RSpec.feature 'comments', :js => true do
	before(:each) do
		@user = User.create!(email: 'user@gmail.com', password: "111111")
		@project = Project.create!(name: Faker::Lorem.sentence, user_id: @user.id)
		@task = @project.tasks.create!(name: Faker::Lorem.sentence)
		login_as(@user, :scope => :user)
	end

	scenario 'add comment' do
		visit "/"

		wait_for_angular

		find('tbody > tr').hover
		find("a.show-task").click

		wait_for_angular

		within('form[name=formNewComment]') do
			fill_in 'title', with: 'SomeTitle'
			fill_in 'comment', with: 'SomeCommnetText'
			find("button[type=submit]").click
		end

		wait_for_angular

		expect(page).to have_content('SomeTitle')
		expect(page).to have_content('SomeCommnetText')
		expect(page).to have_content('Comment Create')
		expect(find_field('title').value).to eq ''
		expect(find_field('comment').value).to eq ''
	end

	scenario 'remove comment' do
		@task.comments.create!(title: 'SomeTitle', comment: 'SomeCommnetText')

		visit "/"

		wait_for_angular

		find('tbody > tr').hover
		find("a.show-task").click

		wait_for_angular

		find('a.remove-comment').click

		wait_for_angular

		expect(page).not_to have_content('SomeTitle')
		expect(page).not_to have_content('SomeCommnetText')
		expect(page).to have_content('Comment Delete')
	end
end