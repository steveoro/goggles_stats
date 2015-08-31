# encoding: utf-8

require 'spec_helper'
require 'ffaker'

require_relative '../../app/interactors/store_stats_data'


describe StoreStatsData, type: :interactor do

  let(:key)         { FFaker::Lorem.word }
  let(:stats_data)  { StatsData.new( key: key, value: FFaker::Lorem.word ) }

  subject { StoreStatsData.new( stats_data: stats_data ) }


  it "responds to #call" do
    expect( subject ).to respond_to(:call)
  end


  context "when created with a valid context," do
    it "holds the object in context" do
      expect( subject.context.stats_data ).to eq( stats_data )
    end
  end


  describe "#call" do
    it "stores the key on Redis" do
      expect( subject.call ).to eq( StoreStatsData::SUCCESS )
      # Let's clean-up the Redis instance:
      expect( Redis.current.del(key) ).to eq(1)
    end
  end
  #-- -------------------------------------------------------------------------
  #++
end
