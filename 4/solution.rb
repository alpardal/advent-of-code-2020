input = File.readlines(File.join(__dir__, 'input')).map(&:chomp)

last = :last.to_proc
join_with = ->(str) { ->(items) { items.join(str) } }
key_value = ->(str) { str.split(':') }
parse_passport = ->(str) { str.split(' ').map(&key_value).to_h }

entries = input.chunk { |c| c.empty?? nil : true }
               .map(&last >> join_with[' '] >> parse_passport)

# pt1 1

has_keys = ->(keys) {
  ->(hash) { (keys - hash.keys).empty? }
}
is_valid_pass_pt1 = has_keys[%w(byr iyr eyr hgt hcl ecl pid)]
puts "(pt1) valid passports: #{entries.select(&is_valid_pass_pt1).size}"

# pt 2

call_with = ->(input) { ->(p) { p[input] } }
proc_and = ->(*ps) { ->(input) { ps.all?(&call_with[input]) } }
proc_or = ->(*ps) { ->(input) { ps.any?(&call_with[input]) } }

# notice that `get_key` is the same as `call_with`
# since procs can be called w/ hash syntax
get_key = ->(key) { ->(h) { h[key] } }
in_range = ->(range) { ->(v) { range.cover?(v.to_i) } }
matches = ->(regex) { ->(v) { regex.match?(v) } }
included_in = ->(values) { ->(v) { values.include?(v) } }

valid_height = proc_or[
  proc_and[matches[/^\d\d\dcm$/], in_range[150..193]],
  proc_and[matches[/^\d\din$/], in_range[59..76]],
]

is_valid_pass_pt2 = proc_and[
  get_key['byr'] >> in_range[1920..2002],
  get_key['iyr'] >> in_range[2010..2020],
  get_key['eyr'] >> in_range[2020..2030],
  get_key['hgt'] >> valid_height,
  get_key['hcl'] >> matches[/^#[0-9a-f]{6}$/],
  get_key['ecl'] >> included_in[%w(amb blu brn gry grn hzl oth)],
  get_key['pid'] >> matches[/^\d{9}$/]
]

puts "(pt2) valid passports: #{entries.select(&is_valid_pass_pt2).size}"
