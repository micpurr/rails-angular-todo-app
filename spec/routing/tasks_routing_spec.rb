require "rails_helper"

RSpec.describe Api::V1::TasksController, type: :routing do
	describe "routing" do
		it "routes to #show" do
			expect(:get => "/api/v1/tasks/1").to route_to("api/v1/tasks#show", :id => "1", format: :json)
		end

		it "routes to #create" do
			expect(:post => "/api/v1/tasks").to route_to("api/v1/tasks#create", format: :json)
		end

		it "routes to #change_priority" do
			expect(:post => "/api/v1/tasks/1/change_priority").to route_to("api/v1/tasks#change_priority", :task_id => "1", format: :json)
		end

		it "routes to #update via PUT" do
			expect(:put => "/api/v1/tasks/1").to route_to("api/v1/tasks#update", :id => "1", format: :json)
		end

		it "routes to #update via PATCH" do
			expect(:patch => "/api/v1/tasks/1").to route_to("api/v1/tasks#update", :id => "1", format: :json)
		end

		it "routes to #destroy" do
			expect(:delete => "/api/v1/tasks/1").to route_to("api/v1/tasks#destroy", :id => "1", format: :json)
		end

	end
end
