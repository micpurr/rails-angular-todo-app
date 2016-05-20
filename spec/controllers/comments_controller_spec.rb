require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do

	before(:each) do
		request.env["HTTP_ACCEPT"] = 'application/json'
		@user = User.create!(email: 'user@gmail.com', password: "111111")
		sign_in @user
		@project = Project.create!(name: Faker::Lorem.sentence, user_id: @user.id)
		@task = Task.create!(name: Faker::Lorem.sentence, project_id: @project.id)
	end

	let(:valid_attributes) {
		{ comment: Faker::Lorem.paragraph, title: Faker::Lorem.sentence[0..45], commentable_id: @task.id, commentable_type: "Task" }
	}

	let(:invalid_attributes) {
		{ comment: nil, title: nil, commentable_id: @task.id, commentable_type: "Task" }
	}

	describe "POST #create" do
		context "with valid params" do
			it "creates a new Comment" do
				expect {
					post :create, {:comment => valid_attributes, project_id: @project.id, task_id: @task.id}
				}.to change(Comment, :count).by(1)
			end

			it "assigns a newly created comment as @comment" do
				post :create, {:comment => valid_attributes, project_id: @project.id, task_id: @task.id}
				expect(assigns(:comment)).to be_a(Comment)
				expect(assigns(:comment)).to be_persisted
			end
		end

		context "with invalid params" do
			it "assigns a newly created but unsaved comment as @comment" do
				post :create, {:comment => invalid_attributes, project_id: @project.id, task_id: @task.id}
				expect(assigns(:comment)).to be_a_new(Comment)
			end
		end
	end

	describe "DELETE #destroy" do
		it "destroys the requested comment" do
			comment = Comment.create! valid_attributes
			expect {
				delete :destroy, {:id => comment.to_param, project_id: @project.id, task_id: @task.id}
			}.to change(Comment, :count).by(-1)
		end
	end
end
