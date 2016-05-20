require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do

	before(:each) do
		request.env["HTTP_ACCEPT"] = 'application/json'
		@user = User.create!(email: 'user@gmail.com', password: "111111")
		sign_in @user
		@project = Project.create!(name: Faker::Lorem.sentence, user_id: @user.id)
	end

	let(:valid_attributes) {
		{ name: Faker::Lorem.sentence, project_id: @project.id }
	}

	let(:invalid_attributes) {
		{ name: nil, project_id: @project.id }
	}

	describe "POST #change_priority" do
		it "response with unprocessable_entity status" do
			task = Task.create! valid_attributes
			post :change_priority, { :task_id => task.id, project_id: @project.id, change_priority: 'none' }
			expect(response).to have_http_status(:unprocessable_entity)
		end

		it "response with success status" do
			task = Task.create! valid_attributes
			post :change_priority, { :task_id => task.id, project_id: @project.id, change_priority: 'up' }
			expect(response).to have_http_status(:success)
		end

		it "assigns the requested task as @task" do
			task1 = Task.create! name: Faker::Lorem.sentence, project_id: @project.id
			task2 = Task.create! name: Faker::Lorem.sentence, project_id: @project.id
			post :change_priority, { :task_id => task1.id, project_id: @project.id, change_priority: 'up' }
			expect(assigns(:tasks)).to eq([task1, task2])
		end
	end

	describe "GET #show" do
		it "assigns the requested task as @task" do
			task = Task.create! valid_attributes
			get :show, {:id => task.id, project_id: @project.id }
			expect(assigns(:task)).to eq(task)
		end

		it 'should render show template'do
			task = Task.create! valid_attributes
			get :show, {:id => task.id, project_id: @project.id }
			expect(response).to render_template("show")
		end

		it 'should have corect response status' do
			task = Task.create! valid_attributes
			get :show, {:id => task.id, project_id: @project.id }
			expect(response).to have_http_status(:success)
		end

		it 'should return unauthorized response status' do
			task = Task.create! valid_attributes
			sign_out @user
			get 'show', {:id => task.id, project_id: @project.id }
			expect(response).to have_http_status(:unauthorized)
		end
	end

	describe "POST #create" do
		context "with valid params" do
			it "creates a new Task" do
				expect {
					post :create, {:task => valid_attributes}
				}.to change(Task, :count).by(1)
			end

			it "assigns a newly created task as @task" do
				post :create, {:task => valid_attributes}
				expect(assigns(:task)).to be_a(Task)
				expect(assigns(:task)).to be_persisted
			end
		end

		context "with invalid params" do
			it "assigns a newly created but unsaved task as @task" do
				post :create, {:task => invalid_attributes}
				expect(assigns(:task)).to be_a_new(Task)
			end
		end
	end

	describe "PUT #update" do
		context "with valid params" do
			it "assigns the requested task as @task" do
				task = Task.create! valid_attributes
				put :update, {:id => task.to_param, :task => valid_attributes, project_id: @project.id}
				expect(assigns(:task)).to eq(task)
			end
		end

		context "with invalid params" do
			it "assigns the task as @task" do
				task = Task.create! valid_attributes
				put :update, {:id => task.to_param, :task => invalid_attributes, project_id: @project.id}
				expect(assigns(:task)).to eq(task)
			end
		end
	end

	describe "DELETE #destroy" do
		it "destroys the requested task" do
			task = Task.create! valid_attributes
			expect {
				delete :destroy, {:id => task.to_param, project_id: @project.id}
			}.to change(Task, :count).by(-1)
		end
	end
end
