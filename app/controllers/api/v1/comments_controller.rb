class Api::V1::CommentsController < Api::V1::V1Controller
	#
	#  Create comment
	#  POST /api/comments.json
	#
	def create
		@comment = current_user.
			projects.find(params['project_id']).
			tasks.find(params['task_id']).
			comments.new(comment_params)

		respond_to do |format|
			if @comment.save
				format.json { render :show, status: :created }
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

	private
		# Never trust parameters from the scary internet, only allow the white list through.
		def comment_params
			params.require(:comment).permit(:title, :comment, :file)
		end
end