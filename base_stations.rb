class BaseStations

  attr_reader :all_base_stations

  def initialize
    @all_base_stations = []
  end

  def add(base_station)
    @all_base_stations << base_station
  end

  def each
    @all_base_stations.each{|base_station| yield base_station}
  end

  def to_s
    string = ""
    @all_base_stations.each{|station| string = string + station.to_s + " "}
  end

end