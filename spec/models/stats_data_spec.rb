# encoding: utf-8

require 'spec_helper'
require 'ffaker'

require_relative '../../app/models/stats_data'


describe StatsData, type: :interactor do

  let(:key)   { FFaker::Lorem.word }
  let(:value) { FFaker::Lorem.word }

  subject { StatsData.new( key: key, value: value ) }


  context "for a new, non-empty instance," do
    it "has the assigned key" do
      expect( subject.key ).to eq(key)
    end
    it "has the assigned value" do
      expect( subject.value ).to eq(value)
    end
  end
  #-- -------------------------------------------------------------------------
  #++
end
