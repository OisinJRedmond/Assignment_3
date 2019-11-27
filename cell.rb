# Author: Oisín Redmond

class Cell
  attr_reader :x, :y

  def initialize (x, y)
    x, y = x.to_i, y.to_i
    if x >= 0 && 0 <= y &&  y <= 20 && x <= 20
      @x, @y = x, y
    else
      @y, @x = -1, -1
    end
  end

  def coverage (all_base_stations)
    cell_location_x = @x - 0.5
    cell_location_y = @y - 0.5
    closest_distance = 100
    all_base_stations.each do |base_station|
      base_station_x_location = base_station.cell.x - 0.5
      base_station_y_location = base_station.cell.y - 0.5
      distance = Math.sqrt((cell_location_y - base_station_y_location)**2 + (cell_location_x - base_station_x_location)**2)
      if distance < closest_distance
        closest_distance = distance
      end
    end
    coverage = 1/(1 + closest_distance)
  end

  def adjacent
    adjacent_cells = []
    i, j = -1, -1
    while i <= 1
      while j <= 1
        adjacent_cells << Cell.new(@x  + i, @y + j)
        j += 1
      end
      j = -1
      i += 1
    end
    adjacent_cells.delete_if {|cell| cell.x < 0 || cell.y < 0 || cell.x > 20 || cell.y > 20}
  end

  def to_s
    "(#{@x}, #{@y})"
  end

  end