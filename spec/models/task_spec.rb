require 'rails_helper'

RSpec.describe Task, type: :model do
	describe "Associations" do
		it { should belong_to(:project) }
	end

	describe "Validations" do
		it { should validate_presence_of(:name) }
		it { should validate_length_of(:name) }
		it do
			Task.create!(name: Faker::Lorem.sentence)
			should validate_uniqueness_of(:name)
		end
	end

	describe "Get deadline days left" do
		it 'should return integer' do
			task = Task.create!(name: Faker::Lorem.sentence, deadline: Date.today + 10.days)
			expect(task.get_deadline_days_left.to_i).to be_a_kind_of(Integer)
		end

		it 'should return correct days count' do
			task = Task.create!(name: Faker::Lorem.sentence, deadline: Date.today + 10.days)
			expect(task.get_deadline_days_left).to eq 10
		end

		it 'should create default value' do
			task = Task.create!(name: Faker::Lorem.sentence)
			expect(task.get_deadline_days_left).to eq 0
		end
	end

	describe "Create record" do
		it "should be correct" do
			name = Faker::Lorem.sentence
			task = Task.create!(name: name)
			expect(task.name).to eq(name)
		end

		it 'have correct association' do
			project = Project.create!(name: Faker::Lorem.sentence)
			task = project.tasks.create!(name: Faker::Lorem.sentence)
			expect(task.project_id).to eq project.id
		end
	end

	describe "Remove record" do
		it 'should remove assosiated record' do
			task = Task.create!(name: Faker::Lorem.sentence)
			comment1 = task.comments.create!(title: Faker::Lorem.sentence[0..49], comment: Faker::Lorem.paragraph)
			comment2 = task.comments.create!(title: Faker::Lorem.sentence[0..49], comment: Faker::Lorem.paragraph)
			expect(task.reload.comments).to eq([comment1, comment2])
			task.destroy
			expect(Comment.count).to eq(0)
			expect(Task.all).not_to include(task)
		end
	end
end
