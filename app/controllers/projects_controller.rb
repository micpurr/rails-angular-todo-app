class ProjectsController < ApplicationController
	before_action :set_project, only: [:show, :update, :destroy]

	# GET /api/projects.json
	def index
		@projects = Project.all

		respond_to do |format|
			format.json { render :index }
		end
	end

	# GET /api/projects/1.json
	def show
	end

	# POST /api/projects.json
	def create
		@project = Project.new(project_params)

		respond_to do |format|
			if @project.save
				format.json { render :show, status: :created, location: @project }
			else
				format.json { render json: @project.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /api/projects/1.json
	def update
		respond_to do |format|
			if @project.update(project_params)
				format.json { render :show, status: :ok, location: @project }
			else
				format.json { render json: @project.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /api/projects/1.json
	def destroy
		@project.destroy
		respond_to do |format|
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_project
			@project = Project.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def project_params
			params.require(:project).permit(:name)
		end
end
