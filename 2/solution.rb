entries = File.readlines(File.join(__dir__, 'input'))

parse_pass = ->(str) {
  str.match(
    /^(?<low>\d+)-(?<high>\d+) (?<letter>\w): (?<pass>\w+)/
  )&.captures
}

candidates = entries.map(&parse_pass)

pt1_valid = ->((low, high, letter, pass)) {
  (low.to_i..high.to_i).cover?(pass.count(letter))
}

pt1_entries = candidates.select(&pt1_valid)
puts "(pt1) valid passwords: #{pt1_entries.size}"

pt2_valid = ->((low, high, letter, pass)) {
  [low, high].select { |pos| pass[pos.to_i - 1] == letter }
             .count == 1
}
pt2_entries = candidates.select(&pt2_valid)
puts "(pt2) valid passwords: #{pt2_entries.size}"
