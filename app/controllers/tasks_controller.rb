class TasksController < ApplicationController
	before_action :set_task, only: [:show, :update, :destroy]

	# GET /api/tasks/1.json
	def show
	end

	# POST /api/tasks.json
	def create
		if user_signed_in?
			@task = current_user.projects.find(task_params['project_id']).tasks.new(task_params)

			respond_to do |format|
				if @task.save
					format.json { render :show, status: :created, location: @task }
				else
					format.json { render json: @task.errors, status: :unprocessable_entity }
				end
			end
		else
			render json: {message: 'You are not authorized'}, status: 401
		end
	end

	# PATCH/PUT /api/tasks/1.json
	def update
		if user_signed_in?
			respond_to do |format|
				if @task.update(task_params)
					format.json { render :show, status: :ok, location: @task }
				else
					format.json { render json: @task.errors, status: :unprocessable_entity }
				end
			end
		else
			render json: {message: 'You are not authorized'}, status: 401
		end
	end

	# DELETE /api/tasks/1.json
	def destroy
		if user_signed_in?
			@task.destroy
			respond_to do |format|
				format.json { head :no_content }
			end
		else
			render json: {message: 'You are not authorized'}, status: 401
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_task
			if user_signed_in?
				@task = current_user.projects.find(params[:project_id]).tasks.find(params[:id])
			else
				render json: {message: 'You are not authorized'}, status: 401
			end
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def task_params
			params.require(:task).permit(:name, :project_id, :done, :deadline, :priority)
		end
end
