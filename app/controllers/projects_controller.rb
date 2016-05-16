class ProjectsController < ApplicationController
	before_action :set_project, only: [:show, :update, :destroy]

	# GET /api/projects.json
	def index
		if user_signed_in?
			@projects = current_user.projects

			respond_to do |format|
				format.json { render :index }
			end
		else
			render json: {message: 'You are not authorized'}, status: 401
		end
	end

	# GET /api/projects/1.json
	def show
	end

	# POST /api/projects.json
	def create
		if user_signed_in?
			@project = current_user.projects.new(project_params)

			respond_to do |format|
				if @project.save
					format.json { render :show, status: :created, location: @project }
				else
					format.json { render json: @project.errors, status: :unprocessable_entity }
				end
			end
		else
			render json: {message: 'You are not authorized'}, status: 401
		end
	end

	# PATCH/PUT /api/projects/1.json
	def update
		if user_signed_in?
			respond_to do |format|
				if @project.update(project_params)
					format.json { render :show, status: :ok, location: @project }
				else
					format.json { render json: @project.errors, status: :unprocessable_entity }
				end
			end
		else
			render json: {message: 'You are not authorized'}, status: 401
		end
	end

	# DELETE /api/projects/1.json
	def destroy
		if user_signed_in?
			@project.destroy
			respond_to do |format|
				format.json { head :no_content }
			end
		else
			render json: {message: 'You are not authorized'}, status: 401
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_project
			if user_signed_in?
				@project = current_user.projects.find(params[:id])
			else
				render json: {message: 'You are not authorized'}, status: 401
			end
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def project_params
			params.require(:project).permit(:name)
		end
end
