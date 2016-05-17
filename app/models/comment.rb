class Comment < ActiveRecord::Base

	include ActsAsCommentable::Comment

	belongs_to :commentable, :polymorphic => true

	default_scope -> { order('created_at ASC') }

	belongs_to :user

	mount_uploader :file, FileUploader

	def get_file
		{
			file_name: File.basename(file.path.to_s),
			url: file.url
		}
	end
end
