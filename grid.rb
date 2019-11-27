# Author: Oisín Redmond
require_relative 'cell'

attr_reader :cells

class Grid
  def initialize
    @cells = [][]
    x = 0
    y = 0
    while x != 20
      while y != 20
        @cells[x][y] = Cell.new(x, y)
        y = y + 1
      end
      x = x + 1
    end
  end

  def coverage(all_base_stations)
    cells_weak_coverage = []
    cells_medium_coverage = []
    cells_strong_coverage = []
    @cells.each do |cell|
      if cell.coverage(all_base_stations) <= 0.1
        cells_weak_coverage << cell
      elsif cell.coverage(all_base_stations) > 0.1 && cell.coverage(all_base_stations) <= 0.3
        cells_medium_coverage << cell
      elsif cell.coverage(all_base_stations) > 0.3
        cells_strong_coverage << cell
      end
    end
  end
end