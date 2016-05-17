class TasksController < ApplicationController
	before_action :set_task, only: [:show, :update, :destroy]

	# GET /api/tasks/1.json
	def show
	end

	def change_priority
		task_id = params[:task_id]
		project_id = params[:project_id]
		change_priority = params[:change_priority]

		task = current_user.projects.find(project_id).tasks.find(task_id)

		if change_priority == 'up'
			task.move_higher
		elsif change_priority == 'down'
			task.move_lower
		else
			respond_to do |format|
				format.json { render :nothing, status: :unprocessable_entity }
			end
		end

		@tasks = current_user.projects.find(project_id).tasks

		respond_to do |format|
			format.json { render :change_priority }
		end
	end

	# POST /api/tasks.json
	def create
		@task = current_user.projects.find(task_params['project_id']).tasks.new(task_params)

		if @task.deadline.blank?
			@task.deadline = Date.today
		end

		respond_to do |format|
			if @task.save
				format.json { render :show, status: :created, location: @task }
			else
				format.json { render json: @task.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /api/tasks/1.json
	def update
		respond_to do |format|
			if @task.update(task_params)
				format.json { render :show, status: :ok, location: @task }
			else
				format.json { render json: @task.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /api/tasks/1.json
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
