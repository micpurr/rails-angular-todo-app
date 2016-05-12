require 'rails_helper'

RSpec.describe User, type: :model do
	context "check create user" do
		it 'success create user' do
			email = "email@gmail.com"
			user = User.new(email: email, password:'111111')
			user.save
			expect(User.find_by_email(email)).to eq(user)
		end
	end
end
