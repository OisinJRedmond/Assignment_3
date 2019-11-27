# Author: Oisín Redmond

require_relative 'cell'
require_relative 'base_station'
require_relative 'base_stations'

puts "Part 1:\n\n"
base_stations = BaseStations.new
IO.foreach("base_stations.txt") do |line|
  data = line.split
  base_stations.add(BaseStation.new(data[0], Cell.new(data[1].to_f, data[2].to_f)))
end
puts base_stations.to_s
puts "\n\nPart 2:\n\n"
cells = []
x = 0
y = 0
while x != 21
  while y != 21
    cells << Cell.new(x, y)
    y = y + 1
  end
  y  = 0
  x = x + 1
end
cells_weak_coverage = []
cells_medium_coverage = []
cells_strong_coverage = []
cells.each do |cell|
  if cell.coverage(base_stations) <= 0.1
    cells_weak_coverage << cell
  elsif cell.coverage(base_stations) > 0.1 && cell.coverage(base_stations) <= 0.3
    cells_medium_coverage << cell
  elsif cell.coverage(base_stations) > 0.3
    cells_strong_coverage << cell
  end
end
puts("Number of cells with weak coverage: #{cells_weak_coverage.length}")
puts("Number of cells with medium coverage: #{cells_medium_coverage.length}")
puts("Number of cells with strong coverage: #{cells_strong_coverage.length}")
print("Weak cells: ")
cells_weak_coverage.each do |cell|
  print cell.to_s + " "
end
puts "\n"
print("Medium cells: ")
cells_medium_coverage.each do |cell|
  print cell.to_s + " "
end
puts "\n"
print("Strong cells: ")
cells_strong_coverage.each do |cell|
  print cell.to_s + " "
end
puts("\n\nPart 3\n\n")
route = []
IO.foreach("route.txt") do |line|
  data = line.split
  route << cells[data[0].to_f*21 + data[1].to_f]
end
route_coverage = 0
route.each do |cell|
  if cells_weak_coverage.include?(cell)
    print("weak ")
  elsif cells_medium_coverage.include?(cell)
    print("medium ")
  elsif cells_strong_coverage.include?(cell)
    print("Strong ")
  end
  route_coverage += cell.coverage(base_stations)
end
puts("average_coverage = #{route_coverage/route.length}")
puts("\n\nPart 4\n\n")
total_coverage = 0
cells.each{|cell| total_coverage += cell.coverage(base_stations)}
TCQ = total_coverage/cells.size
puts "TCQ is: #{TCQ}"
optimal_TCQ = TCQ
base_stations.each do |base_station|
  puts "\nEnter each\n"
  adjacent = base_station.cell.adjacent
  while !adjacent.empty?
    puts "\nEnter while\n"
    base_station.move(adjacent.pop)
    total_coverage = 0
    cells.each{|cell| total_coverage += cell.coverage(base_stations)}
    if optimal_TCQ < total_coverage/cells.size
      optimal_TCQ = total_coverage/cells.size
      puts "TCQ changed"
    end
    puts "adjacent is empty"
  end
end
puts "Optimal TCQ is: #{optimal_TCQ}\n"
puts "TCQ is #{((optimal_TCQ/TCQ)*100 - 100).round}% more optimal."