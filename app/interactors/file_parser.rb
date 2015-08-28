# encoding: utf-8

require 'fileutils'
require 'interactor'
require_relative '../models/stats_data'


=begin
 == FileReader

 Interactor class dedicated to read the contents of a text file.

 After the call, it stores the whole String contents into the #context.data
 member.
 This quick'n'dirty solution assumes the text file has a reasonable size.
 (At least, in the order a few MBs.)

=end
class FileParser
  include Interactor

  # Invokes the interactor to do its job.
  #
  # == Key Params for the Context Hash:
  # - file_name: the file_name to be read
  #
  def call
    raise ArgumentError.new("file_name must be an instance of String!") unless context.file_name.instance_of?( String )
    context.tot_rows = 0
    context.successful_data_rows = 0
                                                    # Scan each line of the file until gets reaches EOF:
    File.open( context.file_name ) do |f|
      f.each_line do |curr_line|
        if context.tot_rows > 0                     # Stardard data rows:
          result_hash = {}
          # Ignore comma contained inside quotes for percentages, dollars or floats:
          curr_values = curr_line.split( /,(?!(\d\d\"|\d\d\%\"|\d\d.US\$))/i )
                                                    # Group all values by field name into an Hash:
          context.field_names.each_with_index do |element, index|
            result_hash[ element ] = curr_values[index]
          end
          # Prerare a unique key for the current row and store the resulting JSON
          # encoded string as its values on Redis:
          key    = result_hash.first.join(': ')

          # We'll encode the aggregated hash object as JSON string.
          # To decode, read the value from Redis using the key and use JSON.load to
          # get a resulting Hash.
          # (Passing the Hash to a dedicated Virtus.model will create an instance
          #  of the model)
          value  = result_hash.to_json
          storer = StoreStatsData.new( stats_data: StatsData.new(key: key, value: value) )

          if storer.call == 'OK'                    # Serialization successfull?
            context.successful_data_rows = context.successful_data_rows + 1
          end
        else                                        # Header row:
          context.field_names = curr_line.split(',')
        end
        context.tot_rows = context.tot_rows + 1
      end
    end
  end
  #-- -------------------------------------------------------------------------
  #++
end
