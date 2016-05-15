class CreateProjects < ActiveRecord::Migration
	def change
		create_table :projects do |t|
			t.string :name, null: false, limit: 255

			t.timestamps null: false
		end

		##
		##  Project name must be uniq
		##
		add_index :projects, :name, unique: true
	end
end
