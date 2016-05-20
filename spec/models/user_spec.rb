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

	describe "Associations" do
		it { should have_many(:projects) }
	end

	describe "Remove record" do
		it 'should remove assosiated record' do
			user = User.create!(email: "user@gmail.com", password: "111111")
			project1 = user.projects.create!(name: Faker::Lorem.sentence)
			project2 = user.projects.create!(name: Faker::Lorem.sentence)
			expect(user.reload.projects).to include(project1, project2)
			user.destroy
			expect(Project.count).to eq(0)
			expect(User.all).not_to include(user)
		end
	end
end
