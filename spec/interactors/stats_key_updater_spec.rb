# encoding: utf-8

require 'spec_helper'
require 'ffaker'

require_relative '../../app/interactors/stats_key_updater'


describe StatsKeyUpdater, type: :interactor do

  let(:key)   { FFaker::Lorem.word }

  subject { StatsKeyUpdater.new( key: key ) }

  it "responds to #call" do
    expect( subject ).to respond_to(:call)
  end


  context "when created with a valid context," do
    it "holds the object in context" do
      expect( subject.context.key ).to eq( key )
    end
  end


  describe "#call" do
    it "adds the key to the list of stats keys used when missing" do
      expect( subject.call ).to be true
      # Let's clean-up the Redis instance:
      expect( Redis.current.srem(StatsKeyUpdater::STATS_KEY_SET_NAME, key) ).to be true
    end
  end
  #-- -------------------------------------------------------------------------
  #++
end
