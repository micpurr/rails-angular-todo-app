class TasksController < ApplicationController
	before_action :set_task, only: [:show, :update, :destroy]

	#  
	#  Get selected task
	#  GET /api/tasks/1.json
	#  
	def show
	end

	#
	#  Chenge priority of selected task
	#  POST /api/comments/1/change_priority.json
	#
	def change_priority
		task_id = params[:task_id]
		project_id = params[:project_id]
		change_priority = params[:change_priority]

		#
		#  Find task
		#
		task = current_user.projects.find(project_id).tasks.find(task_id)

		#
		#  get selected priority
		#
		if change_priority == 'up'
			#
			#  increase priority
			#
			task.move_higher
		elsif change_priority == 'down'
			#
			#  decrease priority
			#
			task.move_lower
		else
			#
			#  return unprocessable_entity status
			#
			respond_to do |format|
				format.json { render :nothing, status: :unprocessable_entity }
			end
		end

		#
		#  get all tasks of current project
		#
		@tasks = current_user.projects.find(project_id).tasks

		#
		#  return tasks.json
		#
		respond_to do |format|
			format.json { render :change_priority }
		end
	end

	#  
	#  Create task
	#  POST /api/tasks.json
	#  
	def create
		@task = current_user.projects.find(task_params['project_id']).tasks.new(task_params)

		#
		#  Set dedline for current date if deadline dont set
		#
		if task_params["deadline"].blank?
			@task.deadline = Date.today
		else
			@task.deadline = Date.parse task_params["deadline"]
		end

		respond_to do |format|
			if @task.save
				format.json { render :show, status: :created, location: @task }
			else
				format.json { render json: @task.errors, status: :unprocessable_entity }
			end
		end
	end

	# 
	#  Update task
	#  PATCH/PUT /api/tasks/1.json
	#  
	def update
		respond_to do |format|
			if @task.update(task_params)
				format.json { render :show, status: :ok, location: @task }
			else
				format.json { render json: @task.errors, status: :unprocessable_entity }
			end
		end
	end

	#  
	#  Remove task
	#  DELETE /api/tasks/1.json
	#  
	def destroy
		@task.destroy
		respond_to do |format|
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_task
			@task = current_user.projects.find(params[:project_id]).tasks.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def task_params
			params.require(:task).permit(:name, :project_id, :done, :deadline)
		end
end
