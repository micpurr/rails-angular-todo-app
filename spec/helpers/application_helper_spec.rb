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

	describe "form size calculations" do
		describe "get_col_size return correct values" do
			it "should return string" do
				expect(helper.get_col_size(:xs, 10, true)).to be_instance_of(String)
			end

			it "should not return array" do
				expect(helper.get_col_size(:xs, 10, true)).not_to be_instance_of(Array)
			end

			it "should return bootstrap default grid size" do
				expect(helper.get_col_size(:xs, nil, true)).to include("12").or include('16')
			end

			it "should not return offset if grid_value > 10 and default bootstrap grid size == 12" do
				expect(helper.get_col_size(:xs, 11, true)).not_to include("offset")
			end

			it "should not return offset if grid_value > 14 and default bootstrap grid size == 16" do
				expect(helper.get_col_size(:xs, 15, true)).not_to include("offset")
			end

			it "should not return offset if offset is tern off" do
				expect(helper.get_col_size(:xs, 10, false)).not_to include("offset")
			end

			it "should return offset" do
				expect(helper.get_col_size(:xs, 10, true)).to include("offset")
			end

			it "should return correct grid_name" do
				expect(helper.get_col_size(:xs, 10, true)).to include("xs")
			end
		end

		describe "form_size return correct values" do
			it "should return string" do
				expect(helper.form_size).to be_instance_of(String)
			end

			it "should return changed default values" do
				xs, sm, md, lg = 10, 8, 6, 4
				expect(helper.form_size({xs: xs, sm: sm, md: md, lg: lg})).to include("col-xs-#{xs}").and include("col-sm-#{sm}").and include("col-md-#{md}").and include("col-lg-#{lg}")
			end

			it "should not return offset when it turns off" do
				expect(helper.form_size({}, false)).not_to include("offset")
			end
		end
	end
end
