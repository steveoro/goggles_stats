# encoding: utf-8

require 'interactor'
require 'redis'
require_relative '../models/stats_data'


=begin
 == StoreStatsData

 Interactor class dedicated to store StatsData on a local Redis instance.

=end
class StoreStatsData
  include Interactor

  # Success message string. Must be equal to the message returned by Redis on a
  # successful #set operation.
  SUCCESS = 'OK'


  # Invokes the interactor to do its job.
  # Returns the SUCCESS string when successful.
  #
  # == Key Params for the Context Hash:
  # - stats_data: a StatsData instance to be processed
  #
  def call
    raise ArgumentError.new("stats_data must be an instance of StatsData!") unless context.stats_data.instance_of?( StatsData )
    Redis.current.set( context.stats_data.key, context.stats_data.value )
  end
  #-- -------------------------------------------------------------------------
  #++
end
