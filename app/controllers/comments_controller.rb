class CommentsController < ApplicationController

	#
	#  Get all comments
	#  GET /api/comments.json
	#
	def index
		@comments = current_user.
			projects.find(params[:project_id]).
			tasks.find(params[:task_id]).comments

		respond_to do |format|
			format.json { render :index }
		end
	end

	#
	#  Create comment
	#  POST /api/comments.json
	#
	def create
		if params[:file].present?
			@comment = current_user.
				projects.find(params['project_id']).
				tasks.find(params['task_id']).
				comments.new({ 
					title: params[:title], 
					comment: params[:comment], 
					file: params[:file]
				})
		else
			@comment = current_user.
				projects.find(params['project_id']).
				tasks.find(params['task_id']).
				comments.new({ 
					title: params[:comment][:title], 
					comment: params[:comment][:comment], 
				})
		end

		respond_to do |format|
			if @comment.save
				format.json { render :show, status: :created, location: @comment }
			else
				format.json { render json: @comment.errors, status: :unprocessable_entity }
			end
		end
	end

	#
	#  Destroy comment
	#  DELETE /api/comments/1.json
	#
	def destroy
		@comment = current_user.
			projects.find(params[:project_id]).
			tasks.find(params[:task_id]).
			comments.find(params[:id]).destroy

		respond_to do |format|
			format.json { head :no_content }
		end
	end
end