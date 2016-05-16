Task.delete_all
Project.delete_all
User.delete_all

User.create!(email: "user@gmail.com", password: '111111')
User.create!(email: "user2@gmail.com", password: '111111')

User.all.each do |u|
	5.times do
		project = u.projects.create! name: Faker::Lorem.sentence
		Random.rand(1..10).times do
			project.tasks.create!(name: Faker::Lorem.sentence)
		end
	end
end