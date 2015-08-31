# encoding: utf-8

require_relative '../interactors/stats_key_updater'
require 'stats_data'
require 'redis'


=begin
 == HomeController

 Defines all the main landing-page actions.

=end
class HomeController < ApplicationController

  before_filter :verify_parameters, only: [:destroy]


  def index
    @stats_names = Redis.current.smembers( StatsKeyUpdater::STATS_KEY_SET_NAME )
  end
  #-- -------------------------------------------------------------------------
  #++

  def detail
    @stats_name = params[:stats_key]
    keys = Redis.current.keys( "*#{ @stats_name }*" )
    @stats_json_data = (keys.instance_of?(Array) && keys.size > 0) ? Redis.current.mget( keys ) : []
  end
  #-- -------------------------------------------------------------------------
  #++

  # Deletes a whole family of stats, using the base name params[:stats_name]
  # (DELETE only)
  #
  def destroy
    Redis.current.srem( StatsKeyUpdater::STATS_KEY_SET_NAME, @stats_name )
    keys = Redis.current.keys( "*#{ @stats_name }*" )
    if keys.instance_of?(Array) && keys.size > 0
      keys.each { |key| Redis.current.del(key) }
      flash[:info] = "#All entries linked to '#{@stats_name}' were deleted."
    else
      flash[:info] = "Key '#{@stats_name}' not found!"
    end
    redirect_to home_index_path()
  end
  #-- -------------------------------------------------------------------------
  #++


  private


  # Verifies any required parameters for all restricted actions
  #
  def verify_parameters
    @stats_name = params[:stats_name]
    unless @stats_name.instance_of?(String) &&
           Redis.current.sismember( StatsKeyUpdater::STATS_KEY_SET_NAME, @stats_name )
      flash[:error] = "Invalid or missing :stats_name parameter!"
      redirect_to home_index_path() and return
    end
  end
  #-- -------------------------------------------------------------------------
  #++
end
