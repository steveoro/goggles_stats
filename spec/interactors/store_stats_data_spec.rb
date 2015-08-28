# encoding: utf-8

require 'spec_helper'
require 'ffaker'

require_relative '../../app/interactors/store_stats_data'


describe StoreStatsData, type: :interactor do

  let(:stats_data)   { StatsData.new( key: FFaker::Lorem.word, value: FFaker::Lorem.word ) }

  subject { StoreStatsData.new( stats_data: stats_data ) }


  it "responds to #call" do
    expect( subject ).to respond_to(:call)
  end


  context "when created with a valid StatsData object," do
    it "holds the object in context" do
# DEBUG
#      puts "\r\n#{ subject.context.inspect }"
      expect( subject.context.stats_data ).to eq( stats_data )
    end
  end


  describe "#call" do
    it "stores the key on Redis" do
      expect( subject.call ).to eq( StoreStatsData::SUCCESS )
    end
  end
  #-- -------------------------------------------------------------------------
  #++
end
