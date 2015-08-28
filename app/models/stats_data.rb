# encoding: utf-8

require 'virtus'


=begin
 == StatsData

 Model/DAO class for single entries of statistical data.
 It has a :key and a :value.

=end
class StatsData
  include Virtus.model

  attribute :key, String
  attribute :value, String
end
