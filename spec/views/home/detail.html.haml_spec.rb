require 'rails_helper'

RSpec.describe "home/detail.html.haml", type: :view do

  context "when rendered," do
    let(:stats_names) { [FFaker::Lorem.word, FFaker::Lorem.word, FFaker::Lorem.word] }

    before(:each) do
      # Let's mock the controller assign:
      assign( :stats_name, stats_names.first )
      assign( :stats_json_data, [] )
      render
    end

    it "displays the title" do
      expect( rendered ).to include("Details")
    end

    it "contains the stats base key name" do
      expect( rendered ).to include( stats_names.first )
    end
  end
end
