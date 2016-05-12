require 'rails_helper'

##
##  Need locale en file and 
##  en->actions->new translation
##
RSpec.describe ApplicationHelper, type: :helper do
	describe "check correct localize" do
		it "return correct default capitalize translation (EN locale)" do
			expect(helper.lc('actions.new')).to eq("New")
		end

		it "return correct upcase translation (EN locale)" do
			expect(helper.lc('actions.new', :upcase)).to eq("NEW")
		end
	end
end
