# Author: Oisín Redmond

class BaseStation

  attr_reader :name, :cell

  def initialize(name, cell)
    @name, @cell = name, cell
  end

  def move(cell)
    @cell = cell
  end

  def to_s
    "#{@name} #{@cell.to_s}"
  end

end