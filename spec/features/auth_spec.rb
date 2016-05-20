require 'rails_helper'

RSpec.feature 'authenticate', :js => true do
	before(:each) do
		@user = User.create!(email: 'user@gmail.com', password: "111111")
	end

	scenario 'success login' do
		visit '/'

		expect(page).to have_selector('form[name=formLogin]')

		within('form[name=formLogin]') do
			fill_in 'email', with: @user.email
			fill_in 'password', with: @user.password
			find("button[type=submit]").click
		end

		wait_for_angular

		expect(page).to have_content(@user.email)
	end

	scenario 'success login and logout' do
		visit '/'

		login_as(@user, :scope => :user)

		find("a.logout-btn").click

		wait_for_angular

		expect(page).to have_selector('span.snackbar-content')
		expect(page).to have_content('Signed out successfully.')
	end

	scenario 'fail login' do
		visit '/'

		expect(page).to have_selector('form[name=formLogin]')

		within('form[name=formLogin]') do
			fill_in 'email', with: 'fake@gmail.com'
			fill_in 'password', with: '111222'
			find("button[type=submit]").click
		end

		wait_for_angular

		expect(page).not_to have_content('fake@gmail.com')
	end

	scenario 'success sign up' do
		visit '/'

		wait_for_angular

		find("a[href='/sign-up']").click

		wait_for_angular

		within('form[name=formSighUp]') do
			fill_in 'email', with: 'new_user@gmail.com'
			fill_in 'password', with: '111111'
			fill_in 'password_confirmation', with: '111111'
			find("button[type=submit]").click
		end

		wait_for_angular

		expect(page).to have_content('new_user@gmail.com')
	end

	scenario 'failed sign up' do
		visit '/'

		wait_for_angular

		find("a[href='/sign-up']").click

		wait_for_angular

		within('form[name=formSighUp]') do
			fill_in 'email', with: 'user@gmail.com'
			fill_in 'password', with: '111111'
			fill_in 'password_confirmation', with: '111111'
			find("button[type=submit]").click
		end

		wait_for_angular
	
		expect(page).to have_selector('span.snackbar-content')
		expect(page).to have_content('has already been taken')
	end
end
# save_and_open_screenshot
