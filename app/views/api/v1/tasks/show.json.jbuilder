json.extract! @task, :id, :project_id, :name, :done, :position, :created_at, :updated_at, :deadline, :get_deadline_days_left

json.comments do
	json.array!(@task.comments) do |comment|
		json.extract! comment, :id, :title, :comment, :get_file, :created_at, :updated_at
	end
end