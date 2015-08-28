# encoding: utf-8

require 'spec_helper'
require 'ffaker'

require_relative '../../app/interactors/file_parser'


describe FileParser, type: :interactor do

  let(:file_name)   { File.join(Rails.root, "test/fixtures/users_x_day-20150101-20150826.csv") }

  subject { FileParser.new( file_name: file_name ) }


  it "responds to #call" do
    expect( subject ).to respond_to(:call)
  end


  context "when called with a valid file name," do
    it "holds the file name in context" do
      expect( subject.context.file_name ).to eq( file_name )
    end
  end


  describe "#call" do
    it "has a number of tot. acquired rows > 2" do
      subject.call
      expect( subject.context.tot_rows ).to be > 2
    end

    it "has a number of successfully acquired rows == tot.rows minus the header" do
      subject.call
      expect( subject.context.successful_data_rows ).to eq( subject.context.tot_rows - 1 )
    end
  end
  #-- -------------------------------------------------------------------------
  #++
end
