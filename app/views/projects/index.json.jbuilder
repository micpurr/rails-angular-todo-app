json.array!(@projects.includes(:tasks)) do |project|
	json.extract! project, :id, :name

	json.tasks do
		json.array!(project.tasks.order(:priority)) do |task|
			json.extract! task, :id, :project_id, :name, :done, :priority, :deadline, :get_deadline_days_left
		end
	end

	json.url project_url(project, format: :json)
end
