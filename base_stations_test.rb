# Author: Oisín Redmond

require_relative 'cell'
require_relative 'base_station'
require_relative 'base_stations'

base_stations = BaseStations.new
base_stations.add(BaseStation.new("Ois", Cell.new(8, 8)))
base_stations.add(BaseStation.new("Ev", Cell.new(15, 15)))
puts base_stations.to_s
