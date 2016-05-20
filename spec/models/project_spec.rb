require 'rails_helper'

RSpec.describe Project, type: :model do
	describe "Associations" do
		it { should have_many(:tasks) }
	end

	describe "Validations" do
		it { should validate_presence_of(:name) }
		it { should validate_length_of(:name) }
		it do
			Project.create!(name: Faker::Lorem.sentence)
			should validate_uniqueness_of(:name)
		end
	end

	describe "Create record" do
		it "should be correct" do
			name = Faker::Lorem.sentence
			project = Project.create!(name: name)
			expect(project.name).to eq(name)
		end
	end

	describe "Remove record" do
		it 'should remove assosiated record' do
			project = Project.create!(name: Faker::Lorem.sentence)
			task1 = project.tasks.create!(name: Faker::Lorem.sentence)
			task2 = project.tasks.create!(name: Faker::Lorem.sentence)
			expect(project.reload.tasks).to eq([task1, task2])
			project.destroy
			expect(Task.count).to eq(0)
			expect(Project.all).not_to include(project)
		end
	end
end
