Task.delete_all
Project.delete_all

5.times do
	project = Project.create! name: Faker::Lorem.sentence
	Random.rand(1..10).times do
		project.tasks.create!(name: Faker::Lorem.sentence)
	end
end