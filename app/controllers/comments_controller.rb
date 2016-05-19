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
		@comment = current_user.
			projects.find(params['project_id']).
			tasks.find(params['task_id']).
			comments.new(comment_params)
		logger.debug("/////////////////////////////")
		logger.debug(@comment.to_json)
		logger.debug("/////////////////////////////")

		respond_to do |format|
			if @comment.save
				logger.debug("/////////////////////////////")
				logger.debug('this')
				logger.debug("/////////////////////////////")
				format.json { render :show, status: :created, location: @comment }
			else
				logger.debug("/////////////////////////////")
				logger.debug(@comment.errors.to_json)
				logger.debug("/////////////////////////////")
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

	private
		# Never trust parameters from the scary internet, only allow the white list through.
		def comment_params
			params.require(:comment).permit(:title, :comment, :file)
		end
end