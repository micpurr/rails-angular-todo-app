class CreateTasks < ActiveRecord::Migration
	def change
		create_table :tasks do |t|
			t.references :user,    index: true, foreign_key: true
			t.references :project, index: true, foreign_key: true
			t.string     :name,    null: false, limit: 255
			t.boolean    :done,    default: false
			t.date       :deadline
			t.integer    :priority

			t.timestamps null: false
		end
	end
end
