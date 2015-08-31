# encoding: utf-8

require 'interactor'
require 'redis'


=begin
 == StatsKeyUpdater

 Interactor class dedicated to update any base name key used by StoreStatsData.

=end
class StatsKeyUpdater
  include Interactor

  # Set name used to store all the stats keys.
  STATS_KEY_SET_NAME = "stats_keys"


  # Invokes the interactor to do its job.
  # Updates the list (set) of used "stats_keys".
  # Returns either 1 for a new key or 0 when the key is existing.
  #
  # == Key Params for the Context Hash:
  # - key: a String name to be added to the set (if not already existing).
  #
  def call
    raise ArgumentError.new("'key' must be an instance of String!") unless context.key.instance_of?( String )
    Redis.current.sadd( STATS_KEY_SET_NAME, context.key )
  end
  #-- -------------------------------------------------------------------------
  #++
end
