class TasksController < ApplicationController
	before_action :set_task, only: [:show, :update, :destroy]

	# GET /tasks/1.json
	def show
	end

	# POST /tasks.json
	def create
		@task = Task.new(task_params)

		respond_to do |format|
			if @task.save
				format.json { render :show, status: :created, location: @task }
			else
				format.json { render json: @task.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /tasks/1.json
	def update
		respond_to do |format|
			if @task.update(task_params)
				format.json { render :show, status: :ok, location: @task }
			else
				format.json { render json: @task.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /tasks/1.json
	def destroy
		@task.destroy
		respond_to do |format|
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_task
			@task = Task.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def task_params
			params.require(:task).permit(:name, :done, :deadline, :priority)
		end
end
