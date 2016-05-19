#
#  Clear prev records
#
Comment.delete_all
Task.delete_all
Project.delete_all
User.delete_all

#
#  create 2 fake users
#
User.create!(email: "user@gmail.com", password: '111111')
User.create!(email: "user2@gmail.com", password: '111111')

User.all.each do |u|
	#
	#  create 5 projects
	#
	5.times do
		project = u.projects.create! name: Faker::Lorem.sentence

		#
		#  create tasks for created project
		#
		Random.rand(1..10).times do
			project.tasks.create!(name: Faker::Lorem.sentence)
		end

		project.tasks.all.each do |p|
			#
			#  create commnets for tasks
			#
			Random.rand(1..20).times do
				p.comments.create!(title: Faker::Lorem.sentence[0..49], comment: Faker::Lorem.paragraph)
			end
		end
	end
end