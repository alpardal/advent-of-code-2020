input = File.readlines(File.join(__dir__, 'input')).map(&:chomp)

seat_from_code = ->(s) { Integer("0b#{s.tr('FBRL', '0110')}").divmod(8) }
# notice that `seat_id` just undoes the divmod above - it exists only
# to make it easier to relate the solution to the problem statement
seat_id = ->((row, col)) { row * 8 + col }

ids = input.map(&seat_from_code >> seat_id)
puts "(pt1) max set id = #{ids.max}"

before, _after = ids.sort.chunk_while { |a, b| a.next == b }.to_a
puts "(pt2) my seat id is #{before.last.next}"
