input = File.readlines(File.join(__dir__, 'input')).map(&:chomp)

unfold = ->(start, f) {
  Enumerator.new do |e|
    current = start

    loop do
      e.yield current
      current = f[current]
    end
  end
}

get_location = ->((row, col)) {
  input[row].then { |r| r[col % r.size] }
}

advance_by = ->(slope) {
  ->((row, col)) { [row + slope.first, col + slope.last] }
}
is_valid_pos = ->((row, _col)) { row < input.size }
is_tree = ->(location) { location == '#' }

visited_positions = ->(start, slope) {
  unfold[start, advance_by[slope]].take_while(&is_valid_pos)
}

count_trees = ->(slope) {
  visited_positions[[0, 0], slope]
    .map(&get_location)
    .select(&is_tree)
    .count
}

pt1_slope = [1, 3]
puts "(pt1) num of trees for slope [1, 3]: #{count_trees[pt1_slope]}"

pt2_target_slopes = [
  [1, 1], [1, 3], [1, 5], [1, 7], [2, 1]
]
pt2_counts = pt2_target_slopes.map(&count_trees)
puts "(pt2) product of all counts: #{pt2_counts.reduce(:*)}"
