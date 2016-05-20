require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :controller do

	before(:each) do
		request.env["HTTP_ACCEPT"] = 'application/json'
		@user = User.create!(email: 'user@gmail.com', password: "111111")
		sign_in @user
	end

	render_views

	let(:valid_attributes) {
		{ name: Faker::Lorem.sentence, user_id: @user.id }
	}

	let(:invalid_attributes) {
		{ name: nil }
	}

	describe "GET #index" do
		it "assigns all projects as @projects" do
			project1 = Project.create! name: Faker::Lorem.sentence, user_id: @user.id
			project2 = Project.create! name: Faker::Lorem.sentence, user_id: @user.id
			get :index
			expect(assigns(:projects)).to eq([project1, project2])
		end

		it 'should render index template'do
			project = Project.create! valid_attributes
			get :index
			expect(response).to render_template("index")
		end

		it 'should have corect response status' do
			get 'index'
			expect(response).to have_http_status(:success)
		end

		it 'should return unauthorized response status' do
			sign_out @user
			get 'index'
			expect(response).to have_http_status(:unauthorized)
		end
	end

	describe "GET #show" do
		it "assigns the requested project as @project" do
			project = Project.create! valid_attributes
			get :show, {:id => project.id}
			expect(assigns(:project)).to eq(project)
		end

		it 'should render show template'do
			project = Project.create! valid_attributes
			get :show, {:id => project.id}
			expect(response).to render_template("show")
		end

		it 'should have corect response status' do
			project = Project.create! valid_attributes
			get :show, {id: project.id}
			expect(response).to have_http_status(:success)
		end

		it 'should return unauthorized response status' do
			project = Project.create! valid_attributes
			sign_out @user
			get 'show', {id: project.id}
			expect(response).to have_http_status(:unauthorized)
		end
	end

	describe "POST #create" do
		context "with valid params" do
			it "creates a new Project" do
				expect {
					post :create, {:project => valid_attributes}
				}.to change(Project, :count).by(1)
			end

			it "assigns a newly created project as @project" do
				post :create, {:project => valid_attributes}
				expect(assigns(:project)).to be_a(Project)
				expect(assigns(:project)).to be_persisted
			end
		end

		context "with invalid params" do
			it "assigns a newly created but unsaved project as @project" do
				post :create, {:project => invalid_attributes}
				expect(assigns(:project)).to be_a_new(Project)
			end
		end
	end

	describe "PUT #update" do
		context "with valid params" do
			let(:new_attributes) {
				{ name: Faker::Lorem.sentence, user_id: @user.id }
			}

			it "assigns the requested project as @project" do
				project = Project.create! valid_attributes
				put :update, {:id => project.to_param, :project => valid_attributes}
				expect(assigns(:project)).to eq(project)
			end
		end

		context "with invalid params" do
			it "assigns the project as @project" do
				project = Project.create! valid_attributes
				put :update, {:id => project.to_param, :project => invalid_attributes}
				expect(assigns(:project)).to eq(project)
			end
		end
	end

	describe "DELETE #destroy" do
		it "destroys the requested project" do
			project = Project.create! valid_attributes
			expect {
				delete :destroy, {:id => project.to_param}
			}.to change(Project, :count).by(-1)
		end
	end
end
