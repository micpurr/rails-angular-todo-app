class Comment < ActiveRecord::Base
	#
	#  Includes
	#
	include ActsAsCommentable::Comment
	mount_uploader :file, FileUploader

	#
	#  Relations
	#
	belongs_to :commentable, :polymorphic => true
	belongs_to :user

	#
	#  Default scope
	#
	default_scope -> { order('created_at ASC') }

	#
	#  Return hash with file data
	#
	def get_file
		{
			file_name: File.basename(file.path.to_s),
			url: file.url
		}
	end
end
