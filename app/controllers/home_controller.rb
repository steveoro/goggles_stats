# encoding: utf-8

require_relative '../interactors/stats_key_updater'
require 'stats_data'
require 'redis'


=begin
 == HomeController

 Defines all the main landing-page actions.

=end
class HomeController < ApplicationController

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
end
