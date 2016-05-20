require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

	before(:each) do
		@user = User.create!(email: 'user@gmail.com', password: "111111")
		sign_in @user
	end

	# after(:each)do
	# 	sign_out @user
	# end

	let(:valid_attributes) {
		{ name: Faker::Lorem.sentence, user_id: @user.id }
	}

	let(:invalid_attributes) {
		{ name: nil }
	}

	describe "GET #index" do
		it "assigns all projects as @projects" do
			project = Project.create! valid_attributes
			get :index
			expect(assigns(:projects)).to eq([project])
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
	end

	describe "GET #show" do
		it "assigns the requested project as @project" do
			project = Project.create! valid_attributes
			get :show, {:id => project.to_param}
			expect(assigns(:project)).to eq(project)
		end

		it 'should have corect response status' do
			get 'show'
			expect(response).to have_http_status(:success)
		end
	end

	# describe "GET #edit" do
	# 	it "assigns the requested project as @project" do
	# 		project = Project.create! valid_attributes
	# 		get :edit, {:id => project.to_param}, valid_session
	# 		expect(assigns(:project)).to eq(project)
	# 	end
	# end

	# describe "POST #create" do
	# 	context "with valid params" do
	# 		it "creates a new Project" do
	# 			expect {
	# 				post :create, {:project => valid_attributes}, valid_session
	# 			}.to change(Project, :count).by(1)
	# 		end

	# 		it "assigns a newly created project as @project" do
	# 			post :create, {:project => valid_attributes}, valid_session
	# 			expect(assigns(:project)).to be_a(Project)
	# 			expect(assigns(:project)).to be_persisted
	# 		end

	# 		it "redirects to the created project" do
	# 			post :create, {:project => valid_attributes}, valid_session
	# 			expect(response).to redirect_to(Project.last)
	# 		end
	# 	end

	# 	context "with invalid params" do
	# 		it "assigns a newly created but unsaved project as @project" do
	# 			post :create, {:project => invalid_attributes}, valid_session
	# 			expect(assigns(:project)).to be_a_new(Project)
	# 		end

	# 		it "re-renders the 'new' template" do
	# 			post :create, {:project => invalid_attributes}, valid_session
	# 			expect(response).to render_template("new")
	# 		end
	# 	end
	# end

	# describe "PUT #update" do
	# 	context "with valid params" do
	# 		let(:new_attributes) {
	# 			skip("Add a hash of attributes valid for your model")
	# 		}

	# 		it "updates the requested project" do
	# 			project = Project.create! valid_attributes
	# 			put :update, {:id => project.to_param, :project => new_attributes}, valid_session
	# 			project.reload
	# 			skip("Add assertions for updated state")
	# 		end

	# 		it "assigns the requested project as @project" do
	# 			project = Project.create! valid_attributes
	# 			put :update, {:id => project.to_param, :project => valid_attributes}, valid_session
	# 			expect(assigns(:project)).to eq(project)
	# 		end

	# 		it "redirects to the project" do
	# 			project = Project.create! valid_attributes
	# 			put :update, {:id => project.to_param, :project => valid_attributes}, valid_session
	# 			expect(response).to redirect_to(project)
	# 		end
	# 	end

	# 	context "with invalid params" do
	# 		it "assigns the project as @project" do
	# 			project = Project.create! valid_attributes
	# 			put :update, {:id => project.to_param, :project => invalid_attributes}, valid_session
	# 			expect(assigns(:project)).to eq(project)
	# 		end

	# 		it "re-renders the 'edit' template" do
	# 			project = Project.create! valid_attributes
	# 			put :update, {:id => project.to_param, :project => invalid_attributes}, valid_session
	# 			expect(response).to render_template("edit")
	# 		end
	# 	end
	# end

	# describe "DELETE #destroy" do
	# 	it "destroys the requested project" do
	# 		project = Project.create! valid_attributes
	# 		expect {
	# 			delete :destroy, {:id => project.to_param}, valid_session
	# 		}.to change(Project, :count).by(-1)
	# 	end

	# 	it "redirects to the projects list" do
	# 		project = Project.create! valid_attributes
	# 		delete :destroy, {:id => project.to_param}, valid_session
	# 		expect(response).to redirect_to(projects_url)
	# 	end
	# end
end
