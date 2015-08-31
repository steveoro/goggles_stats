require 'rails_helper'
require 'ffaker'


RSpec.describe "home/index.html.haml", type: :view do

  context "when rendered," do
    let(:stats_names) { [FFaker::Lorem.word, FFaker::Lorem.word, FFaker::Lorem.word] }

    before(:each) do
      # Let's mock the controller assign:
      assign( :stats_names, stats_names )
      render
    end

    it "displays the title" do
      expect( rendered ).to include("Imported stats")
    end

    it "contains all the stats key names" do
      stats_names.each do |stats_name|
        expect( rendered ).to include( stats_name )
      end
    end
  end
end
