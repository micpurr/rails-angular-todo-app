class CommentsController < ApplicationController
	def index
		@comments = current_user.projects.find(params[:project_id]).tasks.find(params[:task_id]).comments

		respond_to do |format|
			format.json { render :index }
		end
	end

	def create
		@comment = current_user.projects.
			find(params['project_id']).
			tasks.find(params['task_id']).
			comments.new({ 
				title: params[:title], 
				comment: params[:comment], 
				file: params[:file]
			})

		respond_to do |format|
			if @comment.save
				format.json { render :show, status: :created, location: @comment }
			else
				format.json { render json: @comment.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@comment = current_user.projects.
			find(params[:project_id]).
			tasks.find(params[:task_id]).
			comments.find(params[:id]).destroy

		respond_to do |format|
			format.json { head :no_content }
		end
	end
end