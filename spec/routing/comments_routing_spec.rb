require "rails_helper"

RSpec.describe Api::V1::CommentsController, type: :routing do
	describe "routing" do
		it "routes to #create" do
			expect(:post => "/api/v1/comments").to route_to("api/v1/comments#create", format: :json)
		end

		it "routes to #destroy" do
			expect(:delete => "/api/v1/comments/1").to route_to("api/v1/comments#destroy", :id => "1", format: :json)
		end
	end
end
